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
 * Catalog E2E Tests
 * Tests for /catalog endpoints.
 */
describe('Catalog E2E Tests', () => {
    let app: INestApplication;
    let dataSource: DataSource;

    // Dynamic IDs for isolation
    const testTenantId = randomUUID();
    const testBranchId = randomUUID();
    const testRoleId = randomUUID();
    const testUnitId = randomUUID();
    const testCategoryId = randomUUID();
    const testBrandId = randomUUID();
    const testProductId = randomUUID();
    const testVariantId = randomUUID();
    const testPriceListId = randomUUID();
    const testCustomerId = randomUUID();

    const uniqueSuffix = Date.now();
    const testUser = {
        email: `catalog-test-${uniqueSuffix}@test.com`,
        password: 'SecureTestPass123!',
        fullName: 'Catalog Test User',
        tenantId: testTenantId,
        roleId: testRoleId,
    };

    let accessToken: string;

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

        // If register fails (e.g. user already exists which is unlikely with unique email), try login directly
        // console.log('Register failed:', regRes.body);

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
       VALUES ($1, 'Catalog Test Tenant', 'cat-${uniqueSuffix}', 'CAT-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
            [testTenantId, testUser.email],
        );

        // 2. Branch
        await dataSource.query(
            `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'Catalog Branch', 'CB001', '123 Cat St', '555-4444', true, NOW(), NOW())`,
            [testBranchId, testTenantId],
        );

        // 3. Role
        await dataSource.query(
            `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'Catalog Role', 'Viewer', false, '["catalog:read"]')`,
            [testRoleId, testTenantId],
        );

        // 4. Unit
        await dataSource.query(
            `INSERT INTO units_of_measure (id, tenant_id, name, abbreviation, is_active, unit_type)
       VALUES ($1, $2, 'Test Unit', 'tu', true, 'quantity')`,
            [testUnitId, testTenantId],
        );

        // 5. Category
        await dataSource.query(
            `INSERT INTO product_categories (id, tenant_id, name, description, is_active)
       VALUES ($1, $2, 'Test Category', 'Desc', true)`,
            [testCategoryId, testTenantId],
        );

        // 6. Brand
        await dataSource.query(
            `INSERT INTO brands (id, tenant_id, name, is_active)
       VALUES ($1, $2, 'Test Brand', true)`,
            [testBrandId, testTenantId],
        );

        // 7. Product (Logic)
        await dataSource.query(
            `INSERT INTO products (id, tenant_id, name, code, unit_id, category_id, brand_id, description, is_active)
       VALUES ($1, $2, 'Test Product', 'TP-${uniqueSuffix}', $3, $4, $5, 'Prod Desc', true)`,
            [testProductId, testTenantId, testUnitId, testCategoryId, testBrandId],
        );

        // 8. Variant (Physical)
        await dataSource.query(
            `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
       VALUES ($1, $2, $3, 'VAR-${uniqueSuffix}', true)`,
            [testVariantId, testTenantId, testProductId],
        );

        // 9. Customer
        await dataSource.query(
            `INSERT INTO customers (id, tenant_id, code, customer_type, full_name, email, document_number, document_type, phone, address, status)
       VALUES ($1, $2, 'CUST-${uniqueSuffix}', 'retail', 'John Doe', 'john-${uniqueSuffix}@test.com', '12345-${uniqueSuffix}', 'CC', '555-1234', '123 St', 'active')`,
            [testCustomerId, testTenantId],
        );

        // 10. Price List
        await dataSource.query(
            `INSERT INTO price_lists (id, tenant_id, name, is_active, is_default)
            VALUES ($1, $2, 'Standard Price List', true, true)`,
            [testPriceListId, testTenantId],
        );
    }

    // ============================================
    // Catalog API Tests
    // ============================================
    describe('GET /catalog/categories', () => {
        it('should require authentication', async () => {
            const response = await getTestServer(app).get('/catalog/categories');
            expect(response.status).toBe(401);
        });

        it('should return categories', async () => {
            const response = await getTestServer(app)
                .get('/catalog/categories')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.length).toBeGreaterThanOrEqual(1);
            expect(response.body.items.some((i: any) => i.id === testCategoryId)).toBe(true);
        });
    });

    describe('GET /catalog/products', () => {
        it('should return products', async () => {
            const response = await getTestServer(app)
                .get('/catalog/products')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.some((i: any) => i.id === testProductId)).toBe(true);
        });
    });

    describe('GET /catalog/brands', () => {
        it('should return brands', async () => {
            const response = await getTestServer(app)
                .get('/catalog/brands')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.some((i: any) => i.id === testBrandId)).toBe(true);
        });
    });

    describe('GET /catalog/units', () => {
        it('should return units', async () => {
            const response = await getTestServer(app)
                .get('/catalog/units')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.some((i: any) => i.id === testUnitId)).toBe(true);
        });
    });

    describe('GET /catalog/customers', () => {
        it('should return customers', async () => {
            const response = await getTestServer(app)
                .get('/catalog/customers')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.some((i: any) => i.id === testCustomerId)).toBe(true);
        });
    });

    describe('GET /catalog/price-lists', () => {
        it('should return price lists', async () => {
            const response = await getTestServer(app)
                .get('/catalog/price-lists')
                .set('Authorization', `Bearer ${accessToken}`);
            expect(response.status).toBe(200);
            expect(response.body).toHaveProperty('items');
            expect(Array.isArray(response.body.items)).toBe(true);
            expect(response.body.items.some((i: any) => i.id === testPriceListId)).toBe(true);
        });
    });
});
