import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pos/data/dto/product_variant_view.dart';
import 'package:pos/presentation/blocs/cart/cart_bloc.dart';
import 'package:pos/services/sales_service.dart';
import 'package:pos/services/dto/create_sale_dto.dart';
import 'package:pos/services/hardware/hardware_service.dart';
import 'package:pos/services/hardware/receipt_generator.dart';
import 'package:pos/data/local/database.dart';

import 'cart_bloc_test.mocks.dart';

@GenerateMocks([SalesService, HardwareService, ReceiptGenerator])
void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    late MockSalesService mockSalesService;
    late MockHardwareService mockHardwareService;
    late MockReceiptGenerator mockReceiptGenerator;

    final product = ProductVariantView(
      variantId: 'v1',
      productId: 'p1',
      productName: 'Test Product',
      sku: 'SKU1',
      categoryName: 'Test Category',
      price: 100.0,
      trackInventory: true,
      hasBatchControl: false,
    );

    setUp(() {
      mockSalesService = MockSalesService();
      mockHardwareService = MockHardwareService();
      mockReceiptGenerator = MockReceiptGenerator();
      cartBloc =
          CartBloc(mockSalesService, mockHardwareService, mockReceiptGenerator);
    });

    test('initial state is correct', () {
      expect(cartBloc.state, const CartState());
    });

    blocTest<CartBloc, CartState>(
      'adds item to cart',
      build: () => cartBloc,
      act: (bloc) => bloc.add(CartItemAdded(product)),
      expect: () => [
        isA<CartState>()
            .having((s) => s.items.length, 'items.length', 1)
            .having((s) => s.subtotal, 'subtotal', 100.0)
            .having((s) => s.itemsCount, 'itemsCount', 1),
      ],
    );

    blocTest<CartBloc, CartState>(
      'applies promotion correctly (10%)',
      build: () => cartBloc,
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        total: 119.0, // With 19% IVA
        taxAmount: 19.0,
        itemsCount: 1,
      ),
      act: (bloc) => bloc.add(const CartPromotionApplied('PROMO10')),
      expect: () => [
        isA<CartState>()
            .having((s) => s.promoCode, 'promoCode', 'PROMO10')
            .having((s) => s.discountAmount, 'discountAmount', 10.0),
      ],
    );

    blocTest<CartBloc, CartState>(
      'applies promotion correctly (Flat \$50)',
      build: () => cartBloc,
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        total: 119.0,
        taxAmount: 19.0,
        itemsCount: 1,
      ),
      act: (bloc) => bloc.add(const CartPromotionApplied('PROMO50')),
      expect: () => [
        isA<CartState>()
            .having((s) => s.promoCode, 'promoCode', 'PROMO50')
            .having((s) => s.discountAmount, 'discountAmount', 50.0),
      ],
    );

    blocTest<CartBloc, CartState>(
      'clears promotion',
      build: () => cartBloc,
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        discountAmount: 10.0,
        total: 107.1,
        taxAmount: 17.1,
        itemsCount: 1,
        promoCode: 'PROMO10',
      ),
      act: (bloc) => bloc.add(const CartPromotionApplied('CLEAR')),
      expect: () => [
        isA<CartState>()
            .having((s) => s.promoCode, 'promoCode', null)
            .having((s) => s.discountAmount, 'discountAmount', 0.0),
      ],
    );

    blocTest<CartBloc, CartState>(
      'handles checkout success',
      build: () {
        final mockSaleResult = SaleResult(
          sale: LocalSale(
            id: 'sale1',
            tenantId: 'tenant1',
            branchId: 'branch1',
            cashierId: 'user1',
            saleDate: DateTime.now(),
            saleType: SaleType.retail,
            status: SaleStatus.completed,
            subtotal: 100.0,
            discountPercent: 0,
            discountAmount: 0,
            taxAmount: 19.0,
            totalAmount: 119.0,
            synced: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            localId: 'sale1',
          ),
          saleNumber: 'V20260115-0001',
          items: [
            ProcessedSaleItem(
              itemId: 'item1',
              variantId: 'v1',
              lotId: 'lot1',
              lotNumber: 'LOT-001',
              quantity: 1,
              unitPrice: 100.0,
              costPrice: 80.0,
              subtotal: 100.0,
            ),
          ],
          totals: const SaleTotals(
            subtotal: 100.0,
            taxAmount: 19.0,
            totalAmount: 119.0,
            taxRate: 0.19,
          ),
        );

        when(mockSalesService.createSale(any, any))
            .thenAnswer((_) async => mockSaleResult);
        when(mockReceiptGenerator.generateReceiptFromResult(
          saleResult: anyNamed('saleResult'),
          payments: anyNamed('payments'),
          tenantName: anyNamed('tenantName'),
          branchName: anyNamed('branchName'),
          cashierName: anyNamed('cashierName'),
          change: anyNamed('change'),
        )).thenAnswer((_) async => []);
        when(mockHardwareService.printReceipt(any)).thenAnswer((_) async => {});
        when(mockHardwareService.openDrawer()).thenAnswer((_) async => {});
        return cartBloc;
      },
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        taxAmount: 19.0,
        total: 119.0,
        itemsCount: 1,
      ),
      act: (bloc) => bloc.add(CartCheckoutRequested(
        userId: 'user1',
        tenantId: 'tenant1',
        branchId: 'branch1',
        payments: [PaymentDto.cash(119.0)],
      )),
      expect: () => [
        // Loading state
        isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
        // Success state
        isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
        // Clear state
        isA<CartState>().having((s) => s.status, 'status', CartStatus.initial),
      ],
    );

    blocTest<CartBloc, CartState>(
      'rejects insufficient payment',
      build: () => cartBloc,
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        taxAmount: 19.0,
        total: 119.0,
        itemsCount: 1,
      ),
      act: (bloc) => bloc.add(CartCheckoutRequested(
        userId: 'user1',
        tenantId: 'tenant1',
        branchId: 'branch1',
        payments: [PaymentDto.cash(50.0)], // Insufficient
      )),
      expect: () => [
        isA<CartState>()
            .having((s) => s.status, 'status', CartStatus.failure)
            .having((s) => s.errorMessage, 'errorMessage',
                contains('insufficient')),
      ],
    );

    blocTest<CartBloc, CartState>(
      'handles split payment',
      build: () {
        final mockSaleResult = SaleResult(
          sale: LocalSale(
            id: 'sale1',
            tenantId: 'tenant1',
            branchId: 'branch1',
            cashierId: 'user1',
            saleDate: DateTime.now(),
            saleType: SaleType.retail,
            status: SaleStatus.completed,
            subtotal: 100.0,
            discountPercent: 0,
            discountAmount: 0,
            taxAmount: 19.0,
            totalAmount: 119.0,
            synced: false,
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            localId: 'sale1',
          ),
          saleNumber: 'V20260115-0002',
          items: [],
          totals: const SaleTotals(
            subtotal: 100.0,
            taxAmount: 19.0,
            totalAmount: 119.0,
            taxRate: 0.19,
          ),
        );

        when(mockSalesService.createSale(any, any))
            .thenAnswer((_) async => mockSaleResult);
        when(mockReceiptGenerator.generateReceiptFromResult(
          saleResult: anyNamed('saleResult'),
          payments: anyNamed('payments'),
          tenantName: anyNamed('tenantName'),
          branchName: anyNamed('branchName'),
          cashierName: anyNamed('cashierName'),
          change: anyNamed('change'),
        )).thenAnswer((_) async => []);
        when(mockHardwareService.printReceipt(any)).thenAnswer((_) async => {});
        when(mockHardwareService.openDrawer()).thenAnswer((_) async => {});
        return cartBloc;
      },
      seed: () => CartState(
        items: [CartItem(product: product, quantity: 1)],
        subtotal: 100.0,
        taxAmount: 19.0,
        total: 119.0,
        itemsCount: 1,
      ),
      act: (bloc) => bloc.add(CartCheckoutRequested(
        userId: 'user1',
        tenantId: 'tenant1',
        branchId: 'branch1',
        payments: [
          PaymentDto.cash(60.0),
          PaymentDto.nequi(59.0),
        ],
      )),
      expect: () => [
        isA<CartState>().having((s) => s.status, 'status', CartStatus.loading),
        isA<CartState>().having((s) => s.status, 'status', CartStatus.success),
        isA<CartState>().having((s) => s.status, 'status', CartStatus.initial),
      ],
    );
  });
}
