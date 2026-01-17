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
 * Sales E2E Tests
 * Tests for POST /sales endpoint.
 */
describe('Sales E2E Tests', () => {
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
    const testCashSessionId = randomUUID();
    const testLotId = randomUUID();

    const uniqueSuffix = Date.now();
    const testUser = {
        email: `sales-test-${uniqueSuffix}@test.com`,
        password: 'SecureTestPass123!',
        fullName: 'Sales Test User',
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
       VALUES ($1, 'Sales Test Tenant', 'sales-${uniqueSuffix}', 'SALES-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
            [testTenantId, testUser.email],
        );

        // 2. Branch
        await dataSource.query(
            `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'Sales Branch', 'SB001', '123 Sales St', '555-2222', true, NOW(), NOW())`,
            [testBranchId, testTenantId],
        );

        // 3. Role
        await dataSource.query(
            `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'Sales Role', 'Full Access', false, '["*"]')`,
            [testRoleId, testTenantId],
        );

        // 4. Cash Register
        await dataSource.query(
            `INSERT INTO cash_registers (id, tenant_id, branch_id, name, code, is_active)
       VALUES ($1, $2, $3, 'Sales Register', 'SR01', true)`,
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
       VALUES ($1, $2, 'Sales Product', 'SP-${uniqueSuffix}', $3, 'Sales Desc', true, true, true, true, true, 0, false, true)`,
            [testProductId, testTenantId, testUnitId],
        );

        await dataSource.query(
            `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
       VALUES ($1, $2, $3, 'SALES-SKU-${uniqueSuffix}', true)`,
            [testVariantId, testTenantId, testProductId],
        );

        // 6. Initial Stock (lot with 100 units)
        await dataSource.query(
            `INSERT INTO inventory_lots (id, tenant_id, branch_id, variant_id, lot_number, current_quantity, initial_quantity, purchase_price, status)
       VALUES ($1, $2, $3, $4, $5, 100, 100, 5000.00, 'active')`,
            [testLotId, testTenantId, testBranchId, testVariantId, `SALES-LOT-${uniqueSuffix}`],
        );
    }

    // ============================================
    // Sales API Tests
    // ============================================
    describe('POST /sales', () => {
        it('should require authentication', async () => {
            const response = await getTestServer(app)
                .post('/sales')
                .send({
                    branchId: testBranchId,
                    items: [{ variantId: testVariantId, quantity: 1, unitPrice: 10000 }],
                });

            expect(response.status).toBe(401);
        });

        it('should create a sale with valid data', async () => {
            const response = await getTestServer(app)
                .post('/sales')
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    branchId: testBranchId,
                    cashierId: userId,
                    items: [
                        {
                            variantId: testVariantId,
                            quantity: 2,
                            unitPrice: 10000,
                        },
                    ],
                    paymentMethod: 'cash',
                    discountAmount: 0,
                });

            expect(response.status).toBe(201);
            expect(response.body).toHaveProperty('id');
            expect(response.body).toHaveProperty('saleNumber');
            expect(response.body).toHaveProperty('totalAmount');
            expect(response.body).toHaveProperty('subtotal');
            expect(Number(response.body.subtotal)).toBeGreaterThan(0);
        });

        it('should reject sale with insufficient stock', async () => {
            const response = await getTestServer(app)
                .post('/sales')
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    branchId: testBranchId,
                    cashierId: userId,
                    items: [
                        {
                            variantId: testVariantId,
                            quantity: 10000, // More than available (100)
                            unitPrice: 10000,
                        },
                    ],
                    paymentMethod: 'cash',
                    discountAmount: 0,
                });

            expect(response.status).toBe(400);
            expect(response.body).toHaveProperty('message');
        });

        it('should reject sale with non-existent variant', async () => {
            const fakeVariantId = randomUUID();
            const response = await getTestServer(app)
                .post('/sales')
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    branchId: testBranchId,
                    cashierId: userId,
                    items: [
                        {
                            variantId: fakeVariantId,
                            quantity: 1,
                            unitPrice: 10000,
                        },
                    ],
                    paymentMethod: 'cash',
                    discountAmount: 0,
                });

            // Should fail because variant doesn't exist
            expect(response.status).toBeGreaterThanOrEqual(400);
        });

        it('should create sale with discount', async () => {
            const response = await getTestServer(app)
                .post('/sales')
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    branchId: testBranchId,
                    cashierId: userId,
                    items: [
                        {
                            variantId: testVariantId,
                            quantity: 1,
                            unitPrice: 10000,
                            discountPercent: 10, // 10% discount
                        },
                    ],
                    paymentMethod: 'cash',
                    discountAmount: 1000, // Additional 1000 off
                });

            expect(response.status).toBe(201);
            expect(response.body).toHaveProperty('id');
            expect(response.body).toHaveProperty('saleNumber');
            // Total should reflect discounts applied
            expect(Number(response.body.discountAmount)).toBe(1000);
        });
    });
});
