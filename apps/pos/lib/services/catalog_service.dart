import 'package:drift/drift.dart';
import '../data/local/database.dart';
import '../data/api/api_client.dart';
import '../data/dto/product_variant_view.dart';

/// Service for synchronizing master data (Products, Prices, Customers)
/// Implements "Pull" strategy: Server -> Local
class CatalogService {
  final AppDatabase _db;
  final ApiClient _api;

  CatalogService(this._db, this._api);

  /// Get all sellable variants joined with product info
  Future<List<ProductVariantView>> getSellableVariants() async {
    final query = _db.select(_db.localProductVariants).join([
      innerJoin(
        _db.localProducts,
        _db.localProducts.id.equalsExp(_db.localProductVariants.productId),
      ),
      leftOuterJoin(
        _db.localProductCategories,
        _db.localProductCategories.id.equalsExp(_db.localProducts.categoryId),
      ),
    ]);

    final results = await query.get();

    return results.map((row) {
      final variant = row.readTable(_db.localProductVariants);
      final product = row.readTable(_db.localProducts);
      final category = row.readTableOrNull(_db.localProductCategories);

      return ProductVariantView(
        variantId: variant.id,
        productId: product.id,
        sku: variant.sku,
        barcode: variant.barcode,
        productName: product.name,
        categoryName: category?.name ?? 'Uncategorized',
        price: variant.price,
        trackInventory: product.trackInventory,
        hasBatchControl: product.hasBatchControl,
      );
    }).toList();
  }

  /// Search products by query (Name, SKU, Barcode) using LIKE
  Future<List<ProductVariantView>> searchProducts(String query) async {
    final searchStr = '%${query.toLowerCase()}%';

    final q = _db.select(_db.localProductVariants).join([
      innerJoin(
        _db.localProducts,
        _db.localProducts.id.equalsExp(_db.localProductVariants.productId),
      ),
      leftOuterJoin(
        _db.localProductCategories,
        _db.localProductCategories.id.equalsExp(_db.localProducts.categoryId),
      ),
    ]);

    q.where(
      _db.localProducts.name.lower().like(searchStr) |
          _db.localProductVariants.sku.lower().like(searchStr) |
          _db.localProductVariants.barcode.lower().like(searchStr),
    );

    // Limit results for performance
    q.limit(50);

    final results = await q.get();

    return results.map((row) {
      final variant = row.readTable(_db.localProductVariants);
      final product = row.readTable(_db.localProducts);
      final category = row.readTableOrNull(_db.localProductCategories);

      return ProductVariantView(
        variantId: variant.id,
        productId: product.id,
        sku: variant.sku,
        barcode: variant.barcode,
        productName: product.name,
        categoryName: category?.name ?? 'Uncategorized',
        price: variant.price,
        trackInventory: product.trackInventory,
        hasBatchControl: product.hasBatchControl,
      );
    }).toList();
  }

  /// Get single variant view
  Future<ProductVariantView?> getProductVariant(String variantId) async {
    final query = _db.select(_db.localProductVariants).join([
      innerJoin(
        _db.localProducts,
        _db.localProducts.id.equalsExp(_db.localProductVariants.productId),
      ),
      leftOuterJoin(
        _db.localProductCategories,
        _db.localProductCategories.id.equalsExp(_db.localProducts.categoryId),
      ),
    ])..where(_db.localProductVariants.id.equals(variantId));

    final row = await query.getSingleOrNull();
    if (row == null) return null;

    final variant = row.readTable(_db.localProductVariants);
    final product = row.readTable(_db.localProducts);
    final category = row.readTableOrNull(_db.localProductCategories);

    return ProductVariantView(
      variantId: variant.id,
      productId: product.id,
      sku: variant.sku,
      barcode: variant.barcode,
      productName: product.name,
      categoryName: category?.name ?? 'Uncategorized',
      price: variant.price,
      trackInventory: product.trackInventory,
      hasBatchControl: product.hasBatchControl,
    );
  }

  /// Full Sync of all catalogs
  Future<void> syncAll() async {
    // Sequential sync to ensure references exist
    await syncCategories();
    await syncBrands();
    await syncUnits();
    await syncProducts();
    await syncPriceLists();
    await syncCustomers();
  }

  /// Sync Product Categories
  Future<void> syncCategories() async {
    final response = await _api.get('/catalog/categories');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      await _db
          .delete(_db.localProductCategories)
          .go(); // Full replace strategy

      for (final item in items) {
        await _db
            .into(_db.localProductCategories)
            .insert(
              LocalProductCategoriesCompanion.insert(
                id: item['id'],
                tenantId: item['tenantId'],
                name: item['name'],
                code: Value(item['code']),
                parentId: Value(item['parentId']),
                isActive: Value(item['isActive'] ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }

  /// Sync Products and Variants
  Future<void> syncProducts() async {
    final response = await _api.get('/catalog/products');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      // Clear existing cache
      await _db.delete(_db.localProductVariants).go();
      await _db.delete(_db.localProducts).go();

      for (final item in items) {
        // Insert Product
        await _db
            .into(_db.localProducts)
            .insert(
              LocalProductsCompanion.insert(
                id: item['id'],
                tenantId: item['tenantId'],
                code: item['code'] ?? '',
                name: item['name'],
                description: Value(item['description']),
                categoryId: Value(item['categoryId']),
                hasBatchControl: Value(item['hasBatchControl'] ?? true),
                trackInventory: Value(item['trackInventory'] ?? true),
                isActive: Value(item['isActive'] ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );

        // Insert Variants
        if (item['variants'] != null) {
          for (final variant in item['variants']) {
            await _db
                .into(_db.localProductVariants)
                .insert(
                  LocalProductVariantsCompanion.insert(
                    id: variant['id'],
                    tenantId: item['tenantId'],
                    productId: item['id'],
                    sku: variant['sku'],
                    barcode: Value(variant['barcode']),
                    price: Value((variant['price'] as num?)?.toDouble() ?? 0.0),
                    isActive: Value(variant['isActive'] ?? true),
                  ),
                  mode: InsertMode.insertOrReplace,
                );
          }
        }
      }
    });
  }

  /// Sync Brands
  Future<void> syncBrands() async {
    final response = await _api.get('/catalog/brands');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      await _db.delete(_db.localBrands).go();

      for (final item in items) {
        await _db
            .into(_db.localBrands)
            .insert(
              LocalBrandsCompanion.insert(
                id: item['id'],
                tenantId: item['tenantId'],
                name: item['name'],
                description: Value(item['description']),
                logoUrl: Value(item['logoUrl']),
                website: Value(item['website']),
                isActive: Value(item['isActive'] ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }

  /// Sync Units of Measure
  Future<void> syncUnits() async {
    final response = await _api.get('/catalog/units');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      await _db.delete(_db.localUnitsOfMeasure).go();

      for (final item in items) {
        await _db
            .into(_db.localUnitsOfMeasure)
            .insert(
              LocalUnitsOfMeasureCompanion.insert(
                id: item['id'],
                tenantId: item['tenantId'],
                name: item['name'],
                abbreviation: item['abbreviation'],
                unitType: item['unitType'],
                conversionFactor: Value(
                  (item['conversionFactor'] as num?)?.toDouble(),
                ),
                baseUnitId: Value(item['baseUnitId']),
                isActive: Value(item['isActive'] ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }

  /// Sync Price Lists and Items
  Future<void> syncPriceLists() async {
    final response = await _api.get('/catalog/price-lists');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      await _db.delete(_db.localPriceListItems).go();
      await _db.delete(_db.localPriceLists).go();

      for (final list in items) {
        await _db
            .into(_db.localPriceLists)
            .insert(
              LocalPriceListsCompanion.insert(
                id: list['id'],
                tenantId: list['tenantId'],
                name: list['name'],
                isDefault: Value(list['isDefault'] ?? false),
                isActive: Value(list['isActive'] ?? true),
              ),
              mode: InsertMode.insertOrReplace,
            );

        // Items
        if (list['items'] != null) {
          for (final priceItem in list['items']) {
            await _db
                .into(_db.localPriceListItems)
                .insert(
                  LocalPriceListItemsCompanion.insert(
                    id: priceItem['id'],
                    tenantId: list['tenantId'],
                    priceListId: list['id'],
                    variantId: priceItem['variantId'],
                    price: (priceItem['price'] as num).toDouble(),
                    minQuantity: Value(priceItem['minQuantity'] ?? 1),
                  ),
                  mode: InsertMode.insertOrReplace,
                );
          }
        }
      }
    });
  }

  /// Sync Customers
  Future<void> syncCustomers() async {
    final response = await _api.get('/catalog/customers');
    final List<dynamic> items = response['items'] ?? [];

    await _db.transaction(() async {
      await _db.delete(_db.localCustomers).go();

      for (final item in items) {
        // Parse CustomerType enum
        final typeStr = item['customerType'] as String? ?? 'retail';
        final type = CustomerType.values.firstWhere(
          (e) => e.name == typeStr,
          orElse: () => CustomerType.retail,
        );

        await _db
            .into(_db.localCustomers)
            .insert(
              LocalCustomersCompanion.insert(
                id: item['id'],
                tenantId: item['tenantId'],
                code: item['code'] ?? item['id'],
                customerType: type,
                fullName: item['fullName'],
                taxId: Value(item['taxId']),
                email: Value(item['email']),
                phoneNumber: Value(item['phoneNumber']),
                address: Value(item['address']),
                priceListId: Value(item['priceListId']),
                creditLimit: Value(
                  (item['creditLimit'] as num?)?.toDouble() ?? 0.0,
                ),
              ),
              mode: InsertMode.insertOrReplace,
            );
      }
    });
  }
}
