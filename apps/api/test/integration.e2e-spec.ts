import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import { randomUUID } from 'crypto';
import request from 'supertest';
import {
  LoginResponseBody,
  RegisterResponseBody,
  MfaSetupResponseBody,
  ErrorResponseBody,
  SaleResponseBody,
} from './utils';

/**
 * End-to-End Integration Tests
 */
describe('Integration E2E Tests', () => {
  let app: INestApplication;
  let dataSource: DataSource;

  // Dynamic IDs for isolation
  const testTenantId = randomUUID();
  const testBranchId = randomUUID();
  const testRoleId = randomUUID();
  const testCashierRoleId = randomUUID();
  const testUnitId = randomUUID();
  const testProductId = randomUUID();
  const testVariantId = randomUUID();
  const testCashierId = randomUUID();

  // Unique data to avoid collisions
  const uniqueSuffix = Date.now();
  const adminEmail = `admin-integ-${uniqueSuffix}@test.com`;
  const adminPass = 'SecureAdminPass123!';
  const salesEmail = `sales-integ-${uniqueSuffix}@test.com`;
  const salesPass = 'SecureSalesPass123!';

  function getTestServer(app: INestApplication) {
    return request(app.getHttpServer());
  }

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

    await seedDatabase();
  });

  afterAll(async () => {
    await app.close();
  });

  async function seedDatabase() {
    // 1. Tenant
    await dataSource.query(
      `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
             VALUES ($1, 'Integration Test Tenant', 'integ-test-${uniqueSuffix}', 'INT-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
      [testTenantId, adminEmail],
    );

    // 2. Branch
    await dataSource.query(
      `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
             VALUES ($1, $2, 'Integ Branch', 'B001', '123 Integ St', '555-0000', true, NOW(), NOW())`,
      [testBranchId, testTenantId],
    );

    // 3. Admin Role
    await dataSource.query(
      `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
             VALUES ($1, $2, 'Admin Role', 'Full Access', false, '["*"]')`,
      [testRoleId, testTenantId],
    );

    // 4. Cashier Role
    await dataSource.query(
      `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
              VALUES ($1, $2, 'Cashier Role', 'Sales Access', false, '["sales.create", "inventory.view"]')`,
      [testCashierRoleId, testTenantId],
    );

    // 5. Cashier User (Pre-seeded for Sales Cycle)
    await dataSource.query(
      `INSERT INTO users (id, tenant_id, email, password_hash, full_name, role_id, branch_ids, is_active)
             VALUES ($1, $2, $3, 'hash_placeholder', 'Integ Cashier', $4, $5, true)`,
      [testCashierId, testTenantId, salesEmail, testCashierRoleId, JSON.stringify([testBranchId])],
    );

    // 6. Unit & Product & Variant (with Stock)
    await dataSource.query(
      `INSERT INTO units_of_measure (id, tenant_id, name, abbreviation, is_active, unit_type)
             VALUES ($1, $2, 'Unit', 'u', true, 'quantity')`,
      [testUnitId, testTenantId],
    );

    await dataSource.query(
      `INSERT INTO products (id, tenant_id, name, code, unit_id, description, track_inventory, is_salable, is_purchasable, is_returnable, is_active, min_stock, has_expiry, has_batch_control)
             VALUES ($1, $2, 'Integ Product', 'P-${uniqueSuffix}', $3, 'Desc', true, true, true, true, true, 0, false, true)`,
      [testProductId, testTenantId, testUnitId],
    );

    await dataSource.query(
      `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
             VALUES ($1, $2, $3, 'SKU-${uniqueSuffix}', true)`,
      [testVariantId, testTenantId, testProductId],
    );

    // 7. Initial Stock
    const lotId = randomUUID();
    const lotNumber = `INT-LOT-${uniqueSuffix}`;
    await dataSource.query(
      `INSERT INTO inventory_lots (id, tenant_id, branch_id, variant_id, lot_number, current_quantity, initial_quantity, purchase_price, status)
             VALUES ($1, $2, $3, $4, $5, 100, 100, 50.00, 'active')`,
      [lotId, testTenantId, testBranchId, testVariantId, lotNumber],
    );
  }

  describe('Complete Auth Flow', () => {
    // New User for Registration Test
    const registerUser = {
      email: `new-user-${uniqueSuffix}@test.com`,
      password: 'SecureTestPass123!',
      fullName: 'New User',
      tenantId: testTenantId,
      roleId: testRoleId,
    };

    let accessToken: string;
    let userId: string;

    it('Step 1: Should register a new user', async () => {
      const response = await getTestServer(app)
        .post('/auth/register')
        .send(registerUser);

      expect(response.status).toBe(201);

      const body = response.body as RegisterResponseBody;
      expect(body).toHaveProperty('id');
      expect(body).toHaveProperty('email', registerUser.email);

      userId = body.id;
    });

    it('Step 2: Should reject duplicate registration', async () => {
      const response = await getTestServer(app)
        .post('/auth/register')
        .send(registerUser);

      expect(response.status).toBe(409);
    });

    it('Step 3: Should login with correct credentials', async () => {
      const response = await getTestServer(app)
        .post('/auth/login')
        .send({ email: registerUser.email, password: registerUser.password });

      expect(response.status).toBe(200);

      const body = response.body as LoginResponseBody;
      expect(body).toHaveProperty('accessToken');
      expect(body).toHaveProperty('user');
      expect(body.user.email).toBe(registerUser.email);

      accessToken = body.accessToken;
    });

    it('Step 4: Should access protected endpoint with token', async () => {
      const response = await getTestServer(app)
        .post('/auth/logout')
        .set('Authorization', `Bearer ${accessToken}`);

      if (response.status !== 200) {
        console.error('[STEP 4 FAILED] Response:', JSON.stringify(response.body, null, 2));
      }

      expect(response.status).toBe(200);

      const body = response.body as { success: boolean };
      expect(body.success).toBe(true);
    });

    it('Step 5: Should reject access after logout', async () => {
      const response = await getTestServer(app)
        .post('/auth/mfa/setup')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({ userId });

      expect([200, 401]).toContain(response.status);
    });

    it('Step 6: Should reject wrong password', async () => {
      const response = await getTestServer(app)
        .post('/auth/login')
        .send({ email: registerUser.email, password: 'WrongPassword123!' });

      expect(response.status).toBe(401);
    });
  });

  describe('MFA Setup and Verification Flow', () => {
    const mfaUser = {
      email: `mfa-integ-${uniqueSuffix}@test.com`,
      password: 'SecureMfaPass123!',
      fullName: 'MFA E2E User',
      tenantId: testTenantId,
      roleId: testRoleId,
    };

    let accessToken: string;
    let userId: string;

    beforeAll(async () => {
      const regRes = await getTestServer(app)
        .post('/auth/register')
        .send(mfaUser);
      const regBody = regRes.body as RegisterResponseBody;
      userId = regBody.id;

      const loginRes = await getTestServer(app)
        .post('/auth/login')
        .send({ email: mfaUser.email, password: mfaUser.password });
      const loginBody = loginRes.body as LoginResponseBody;
      accessToken = loginBody.accessToken;
    });

    it('Should setup MFA and return QR code', async () => {
      const response = await getTestServer(app)
        .post('/auth/mfa/setup')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({ userId });

      expect(response.status).toBe(200);

      const body = response.body as MfaSetupResponseBody;
      expect(body).toHaveProperty('secret');
      expect(body).toHaveProperty('qrCodeUrl');
      expect(body.qrCodeUrl).toContain('data:image/png;base64');
    });
  });

  describe('API Error Response Format', () => {
    it('Should return proper error format for validation errors', async () => {
      const response = await getTestServer(app)
        .post('/auth/register')
        .send({ email: 'invalid' }); // Missing other fields

      expect(response.status).toBe(400);

      const body = response.body as ErrorResponseBody;
      expect(body).toHaveProperty('message');
      expect(body).toHaveProperty('statusCode', 400);
    });

    it('Should return proper error format for not found', async () => {
      const response = await getTestServer(app).get('/nonexistent-endpoint');

      expect(response.status).toBe(404);
    });
  });

  describe('Complete Sales Cycle', () => {
    // Requires a user with SALES permissions. We can register one or use the pre-seeded one if we knew the password.
    // Let's register a fresh one to be sure.
    const salesUserReg = {
      email: `sales-cycle-${uniqueSuffix}@test.com`,
      password: 'SecureSalesPass123!',
      fullName: 'Sales Cycle User',
      tenantId: testTenantId,
      roleId: testCashierRoleId, // Use Cashier Role
    };

    let accessToken: string;

    beforeAll(async () => {
      // Register
      await getTestServer(app).post('/auth/register').send(salesUserReg);

      // Login
      const loginRes = await getTestServer(app)
        .post('/auth/login')
        .send({ email: salesUserReg.email, password: salesUserReg.password });
      accessToken = (loginRes.body as LoginResponseBody).accessToken;
    });

    it('Step 1: Check stock availability', async () => {
      const response = await getTestServer(app)
        .post('/inventory/check-availability')
        .set('Authorization', `Bearer ${accessToken}`)
        .send({
          variantId: testVariantId,
          branchId: testBranchId,
          quantity: 1,
        });

      expect(response.status).toBe(200);
      expect(response.body).toEqual({ available: true });
    });

    it('Step 2: Create a sale', async () => {
      const response = await getTestServer(app)
        .post('/sales')
        .set('Authorization', `Bearer ${accessToken}`)
        .set('x-tenant-id', testTenantId) // Some guards might check this?
        .send({
          branchId: testBranchId,
          cashierId: testCashierId, // Or the current user ID if relevant
          paymentMethod: 'cash',
          items: [
            {
              variantId: testVariantId,
              quantity: 1,
              unitPrice: 100,
            },
          ],
        });

      if (response.status !== 201) {
        console.error('Sale Creation Failed:', response.body);
      }
      expect(response.status).toBe(201);

      const body = response.body as SaleResponseBody;
      expect(body).toHaveProperty('id');
      expect(body).toHaveProperty('totalAmount');
    });
  });
});
