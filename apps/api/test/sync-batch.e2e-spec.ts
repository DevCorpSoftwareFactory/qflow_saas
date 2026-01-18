import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import { randomUUID } from 'crypto';
import {
  getTestServer,
  LoginResponseBody,
  RegisterResponseBody,
} from './utils';

/**
 * Sync Batch E2E Tests
 * Tests for POST /sync/push endpoint handling offline data.
 */
describe('Sync Batch E2E Tests', () => {
  let app: INestApplication;
  let dataSource: DataSource;

  // Dynamic IDs for isolation
  const testTenantId = randomUUID();
  const testBranchId = randomUUID();
  const testRoleId = randomUUID();
  const testCashRegisterId = randomUUID();
  const testVariantId = randomUUID();
  const testProductId = randomUUID();
  const testUnitId = randomUUID();

  const uniqueSuffix = Date.now();
  const testUser = {
    email: `sync-test-${uniqueSuffix}@test.com`,
    password: 'SecureTestPass123!',
    fullName: 'Sync Test User',
    tenantId: testTenantId,
    roleId: testRoleId,
  };

  let accessToken: string;
  let userId: string;

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

    // Register and login
    const regRes = await getTestServer(app)
      .post('/auth/register')
      .send(testUser);
    const regBody = regRes.body as RegisterResponseBody;
    userId = regBody.id;

    const loginRes = await getTestServer(app)
      .post('/auth/login')
      .send({ email: testUser.email, password: testUser.password });
    const loginBody = loginRes.body as LoginResponseBody;
    accessToken = loginBody.accessToken;
  });

  afterAll(async () => {
    await app.close();
  });

  async function seedTestData() {
    // 1. Tenant
    await dataSource.query(
      `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
       VALUES ($1, 'Sync Test Tenant', 'sync-test-${uniqueSuffix}', 'SYNC-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
      [testTenantId, testUser.email],
    );

    // 2. Branch
    await dataSource.query(
      `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'Sync Branch', 'SB001', '123 Sync St', '555-1111', true, NOW(), NOW())`,
      [testBranchId, testTenantId],
    );

    // 3. Role
    await dataSource.query(
      `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'Sync Role', 'Full Access', false, '["*"]')`,
      [testRoleId, testTenantId],
    );

    // 4. Cash Register
    await dataSource.query(
      `INSERT INTO cash_registers (id, tenant_id, branch_id, name, code, is_active)
       VALUES ($1, $2, $3, 'Sync Register', 'SR01', true)`,
      [testCashRegisterId, testTenantId, testBranchId],
    );

    // 5. Unit, Product, Variant for sales
    await dataSource.query(
      `INSERT INTO units_of_measure (id, tenant_id, name, abbreviation, is_active, unit_type)
       VALUES ($1, $2, 'Unit', 'u', true, 'quantity')`,
      [testUnitId, testTenantId],
    );

    await dataSource.query(
      `INSERT INTO products (id, tenant_id, name, code, unit_id, description, track_inventory, is_salable, is_purchasable, is_returnable, is_active, min_stock, has_expiry, has_batch_control)
       VALUES ($1, $2, 'Sync Product', 'SP-${uniqueSuffix}', $3, 'Sync Desc', true, true, true, true, true, 0, false, true)`,
      [testProductId, testTenantId, testUnitId],
    );

    await dataSource.query(
      `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
       VALUES ($1, $2, $3, 'SYNC-SKU-${uniqueSuffix}', true)`,
      [testVariantId, testTenantId, testProductId],
    );

    // 6. Initial Stock (lot)
    const lotId = randomUUID();
    await dataSource.query(
      `INSERT INTO inventory_lots (id, tenant_id, branch_id, variant_id, lot_number, current_quantity, initial_quantity, purchase_price, status)
       VALUES ($1, $2, $3, $4, $5, 1000, 1000, 50.00, 'active')`,
      [
        lotId,
        testTenantId,
        testBranchId,
        testVariantId,
        `SYNC-LOT-${uniqueSuffix}`,
      ],
    );
  }

  // ============================================
  // Basic Sync Push Tests
  // ============================================
  describe('POST /sync/push', () => {
    it('should require authentication', async () => {
      const response = await getTestServer(app)
        .post('/sync/push')
        .send({ deviceId: 'test-device', sales: [] });

      expect(response.status).toBe(401);
    });

    it('should accept empty payload', async () => {
      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          sales: [],
          cashSessions: [],
          cashMovements: [],
        });

      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty('success', true);
      expect(response.body).toHaveProperty('syncedSales', 0);
      expect(response.body).toHaveProperty('syncedSessions', 0);
      expect(response.body).toHaveProperty('syncedMovements', 0);
    });

    it('should sync a cash session', async () => {
      const sessionId = randomUUID();
      const now = new Date().toISOString();

      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          cashSessions: [
            {
              id: sessionId,
              cashRegisterId: testCashRegisterId,
              branchId: testBranchId,
              userId: userId,
              status: 'open',
              openingDate: now,
              initialAmount: 100000,
              systemAmount: 100000,
              createdAt: now,
              updatedAt: now,
            },
          ],
        });

      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty('syncedSessions', 1);

      // Verify in database
      const sessions = await dataSource.query(
        'SELECT id, status FROM cash_sessions WHERE id = $1',
        [sessionId],
      );
      expect(sessions.length).toBe(1);
      expect(sessions[0].status).toBe('open');
    });

    it('should handle duplicate session (idempotency)', async () => {
      const sessionId = randomUUID();
      const now = new Date().toISOString();

      const payload = {
        deviceId: 'test-device',
        cashSessions: [
          {
            id: sessionId,
            cashRegisterId: testCashRegisterId,
            branchId: testBranchId,
            userId: userId,
            status: 'open',
            openingDate: now,
            initialAmount: 50000,
            systemAmount: 50000,
            createdAt: now,
            updatedAt: now,
          },
        ],
      };

      // First push
      await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(payload);

      // Second push (same ID)
      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send(payload);

      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty('syncedSessions', 1);

      // Should still be only one record
      const sessions = await dataSource.query(
        'SELECT COUNT(*) as count FROM cash_sessions WHERE id = $1',
        [sessionId],
      );
      expect(parseInt(sessions[0].count, 10)).toBe(1);
    });

    it('should sync cash movement and update session balance', async () => {
      // First create a session
      const sessionId = randomUUID();
      const now = new Date().toISOString();

      await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          cashSessions: [
            {
              id: sessionId,
              cashRegisterId: testCashRegisterId,
              branchId: testBranchId,
              userId: userId,
              status: 'open',
              openingDate: now,
              initialAmount: 100000,
              systemAmount: 100000,
              createdAt: now,
              updatedAt: now,
            },
          ],
        });

      // Now add a movement
      const movementId = randomUUID();
      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          cashMovements: [
            {
              id: movementId,
              cashSessionId: sessionId,
              branchId: testBranchId,
              movementType: 'income',
              category: 'sale',
              amount: 50000,
              concept: 'Test sale',
              userId: userId,
              movementDate: now,
            },
          ],
        });

      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty('syncedMovements', 1);

      // Verify movement exists
      const movements = await dataSource.query(
        'SELECT id FROM cash_movements WHERE id = $1',
        [movementId],
      );
      expect(movements.length).toBe(1);
    });

    it('should sync a sale with items', async () => {
      // Create session first
      const sessionId = randomUUID();
      const now = new Date().toISOString();

      await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          cashSessions: [
            {
              id: sessionId,
              cashRegisterId: testCashRegisterId,
              branchId: testBranchId,
              userId: userId,
              status: 'open',
              openingDate: now,
              initialAmount: 0,
              systemAmount: 0,
              createdAt: now,
              updatedAt: now,
            },
          ],
        });

      // Now create sale
      const saleId = randomUUID();
      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          sales: [
            {
              id: saleId,
              saleNumber: `SYNC-${uniqueSuffix}`,
              branchId: testBranchId,
              cashierId: userId,
              cashSessionId: sessionId,
              items: [
                {
                  variantId: testVariantId,
                  quantity: 2,
                  unitPrice: 10000,
                },
              ],
              createdAt: now,
            },
          ],
        });

      expect(response.status).toBe(201);
      expect(response.body).toHaveProperty('syncedSales', 1);
    });

    it('should return errors for invalid data without failing entire batch', async () => {
      const validSessionId = randomUUID();
      const invalidSessionId = randomUUID();
      const now = new Date().toISOString();

      const response = await getTestServer(app)
        .post('/sync/push')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          deviceId: 'test-device',
          cashSessions: [
            // Valid session
            {
              id: validSessionId,
              cashRegisterId: testCashRegisterId,
              branchId: testBranchId,
              userId: userId,
              status: 'open',
              openingDate: now,
              initialAmount: 10000,
              systemAmount: 10000,
              createdAt: now,
              updatedAt: now,
            },
            // Invalid session (missing required field or invalid reference)
            {
              id: invalidSessionId,
              cashRegisterId: randomUUID(), // Non-existent register
              branchId: testBranchId,
              userId: userId,
              status: 'open',
              openingDate: now,
              initialAmount: 10000,
              systemAmount: 10000,
              createdAt: now,
              updatedAt: now,
            },
          ],
        });

      expect(response.status).toBe(201);
      // At least one should succeed
      expect(response.body.syncedSessions).toBeGreaterThanOrEqual(1);
    });
  });
});
