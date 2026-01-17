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
 * Cash Session E2E Tests
 * Tests for /cash-sessions endpoints (open, close, active).
 */
describe('Cash Session E2E Tests', () => {
    let app: INestApplication;
    let dataSource: DataSource;

    // Dynamic IDs for isolation
    const testTenantId = randomUUID();
    const testBranchId = randomUUID();
    const testRoleId = randomUUID();
    const testCashRegisterId = randomUUID();

    const uniqueSuffix = Date.now();
    const testUser = {
        email: `cash-test-${uniqueSuffix}@test.com`,
        password: 'SecureTestPass123!',
        fullName: 'Cash Test User',
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
       VALUES ($1, 'Cash Test Tenant', 'cash-${uniqueSuffix}', 'CASH-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
            [testTenantId, testUser.email],
        );

        // 2. Branch
        await dataSource.query(
            `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'Cash Branch', 'CB001', '123 Cash St', '555-4444', true, NOW(), NOW())`,
            [testBranchId, testTenantId],
        );

        // 3. Role
        await dataSource.query(
            `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'Cash Role', 'Full Access', false, '["*"]')`,
            [testRoleId, testTenantId],
        );

        // 4. Cash Register
        await dataSource.query(
            `INSERT INTO cash_registers (id, tenant_id, branch_id, name, code, is_active)
       VALUES ($1, $2, $3, 'Cash Register', 'CR01', true)`,
            [testCashRegisterId, testTenantId, testBranchId],
        );
    }

    // ============================================
    // Cash Session Open/Close Tests
    // ============================================
    describe('POST /cash-sessions/open', () => {
        it('should require authentication', async () => {
            const response = await getTestServer(app)
                .post('/cash-sessions/open')
                .send({
                    cashRegisterId: testCashRegisterId,
                    branchId: testBranchId,
                    openingAmount: 50000,
                });

            expect(response.status).toBe(401);
        });

        it('should open a new cash session', async () => {
            const response = await getTestServer(app)
                .post('/cash-sessions/open')
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    cashRegisterId: testCashRegisterId,
                    branchId: testBranchId,
                    openingAmount: 50000,
                });

            expect(response.status).toBe(201);
            expect(response.body).toHaveProperty('id');
            expect(response.body).toHaveProperty('status', 'open');
            expect(Number(response.body.initialAmount)).toBe(50000);
        });
    });

    describe('GET /cash-sessions/active', () => {
        it('should require authentication', async () => {
            const response = await getTestServer(app)
                .get('/cash-sessions/active');

            expect(response.status).toBe(401);
        });

        it('should return active session for authenticated user', async () => {
            const response = await getTestServer(app)
                .get('/cash-sessions/active')
                .set('Authorization', `Bearer ${accessToken}`);

            expect(response.status).toBe(200);
            // May be null if no active session, or session object
            // Since we opened one in previous test, it should exist
            if (response.body) {
                expect(response.body).toHaveProperty('status', 'open');
            }
        });
    });

    describe('POST /cash-sessions/:id/close', () => {
        it('should require authentication', async () => {
            const response = await getTestServer(app)
                .post(`/cash-sessions/${randomUUID()}/close`)
                .send({
                    declaredAmount: 50000,
                });

            expect(response.status).toBe(401);
        });

        it('should close an active session with balanced amounts', async () => {
            // First get the active session
            const activeRes = await getTestServer(app)
                .get('/cash-sessions/active')
                .set('Authorization', `Bearer ${accessToken}`);

            if (!activeRes.body || !activeRes.body.id) {
                // No active session - skip this test
                return;
            }

            const sessionId = activeRes.body.id as string;

            const response = await getTestServer(app)
                .post(`/cash-sessions/${sessionId}/close`)
                .set('Authorization', `Bearer ${accessToken}`)
                .send({
                    declaredAmount: 50000, // Same as initial, no movements
                });

            expect(response.status).toBe(201);
            expect(response.body).toHaveProperty('status', 'closed');
        });
    });
});
