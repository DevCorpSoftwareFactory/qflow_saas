import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import { randomUUID } from 'crypto';
import { getTestServer } from './utils';

/**
 * Inventory E2E Tests
 * Tests for /inventory endpoints (check-availability).
 */
describe('Inventory E2E Tests', () => {
  let app: INestApplication;
  let dataSource: DataSource;

  // Dynamic IDs for isolation
  const testTenantId = randomUUID();
  const testBranchId = randomUUID();
  const testVariantId = randomUUID();
  const testProductId = randomUUID();
  const testUnitId = randomUUID();
  const testLotId = randomUUID();

  const uniqueSuffix = Date.now();

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({ whitelist: true, transform: true }),
    );
    await app.init();

    dataSource = moduleFixture.get<DataSource>(DataSource);

    // Seed required data
    await seedTestData();
  });

  afterAll(async () => {
    await app.close();
  });

  async function seedTestData() {
    // 1. Tenant
    await dataSource.query(
      `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
       VALUES ($1, 'Inventory Test Tenant', 'inv-${uniqueSuffix}', 'INV-TAX-${uniqueSuffix}', 'inv-${uniqueSuffix}@test.com', 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
      [testTenantId],
    );

    // 2. Branch
    await dataSource.query(
      `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'Inventory Branch', 'IB001', '123 Inv St', '555-3333', true, NOW(), NOW())`,
      [testBranchId, testTenantId],
    );

    // 3. Unit, Product, Variant
    await dataSource.query(
      `INSERT INTO units_of_measure (id, tenant_id, name, abbreviation, is_active, unit_type)
       VALUES ($1, $2, 'Unit', 'u', true, 'quantity')`,
      [testUnitId, testTenantId],
    );

    await dataSource.query(
      `INSERT INTO products (id, tenant_id, name, code, unit_id, description, track_inventory, is_salable, is_purchasable, is_returnable, is_active, min_stock, has_expiry, has_batch_control)
       VALUES ($1, $2, 'Inventory Product', 'IP-${uniqueSuffix}', $3, 'Inv Desc', true, true, true, true, true, 0, false, true)`,
      [testProductId, testTenantId, testUnitId],
    );

    await dataSource.query(
      `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
       VALUES ($1, $2, $3, 'INV-SKU-${uniqueSuffix}', true)`,
      [testVariantId, testTenantId, testProductId],
    );

    // 4. Initial Stock (lot with 50 units)
    await dataSource.query(
      `INSERT INTO inventory_lots (id, tenant_id, branch_id, variant_id, lot_number, current_quantity, initial_quantity, purchase_price, status)
       VALUES ($1, $2, $3, $4, $5, 50, 50, 2500.00, 'active')`,
      [
        testLotId,
        testTenantId,
        testBranchId,
        testVariantId,
        `INV-LOT-${uniqueSuffix}`,
      ],
    );
  }

  // ============================================
  // Inventory Check Availability Tests
  // ============================================
  describe('POST /inventory/check-availability', () => {
    it('should return available=true when stock is sufficient', async () => {
      const response = await getTestServer(app)
        .post('/inventory/check-availability')
        .send({
          variantId: testVariantId,
          branchId: testBranchId,
          quantity: 10, // We have 50
        });

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('available', true);
    });

    it('should return 400 when stock is insufficient', async () => {
      const response = await getTestServer(app)
        .post('/inventory/check-availability')
        .send({
          variantId: testVariantId,
          branchId: testBranchId,
          quantity: 100, // We only have 50
        });

      // API throws StockInsufficientException which returns 400
      expect(response.status).toBe(400);
      expect(response.body).toHaveProperty('message');
    });

    it('should return 400 for non-existent variant', async () => {
      const fakeVariantId = randomUUID();
      const response = await getTestServer(app)
        .post('/inventory/check-availability')
        .send({
          variantId: fakeVariantId,
          branchId: testBranchId,
          quantity: 1,
        });

      // API throws StockInsufficientException for non-existent variants
      expect(response.status).toBe(400);
      expect(response.body).toHaveProperty('message');
    });

    it('should return 400 for non-existent branch', async () => {
      const fakeBranchId = randomUUID();
      const response = await getTestServer(app)
        .post('/inventory/check-availability')
        .send({
          variantId: testVariantId,
          branchId: fakeBranchId,
          quantity: 1,
        });

      // No stock in that branch = insufficient = 400
      expect(response.status).toBe(400);
      expect(response.body).toHaveProperty('message');
    });
  });
});
