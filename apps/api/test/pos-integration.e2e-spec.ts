import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import { randomUUID } from 'crypto';
import * as request from 'supertest';
const supertest = require('supertest');
const req = supertest;

describe('POS Integration & Sync (e2e)', () => {
  let app: INestApplication;
  let dataSource: DataSource;

  // Dynamic IDs
  const testTenantId = randomUUID();
  const testRoleId = randomUUID();
  const testBranchId = randomUUID();
  const testRegisterId = randomUUID();

  const uniqueSuffix = Date.now();
  const testUser = {
    email: `pos-test-${uniqueSuffix}@test.com`,
    password: 'SecureTestPass123!',
    fullName: 'POS Test User',
  };

  let accessToken: string;
  let userId: string;
  let tenantId: string;
  let sessionId: string;

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

    await setupPOSEnvironment();
  });

  afterAll(async () => {
    await app.close();
  });

  async function setupPOSEnvironment() {
    // 1. Seed Tenant
    await dataSource.query(
      `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
       VALUES ($1, 'POS Auto Tenant', 'pos-${uniqueSuffix}', 'POS-TAX-${uniqueSuffix}', $2, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
      [testTenantId, testUser.email],
    );

    // 2. Seed Role
    await dataSource.query(
      `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'POS Role', 'Cashier', false, '["pos:all"]')`,
      [testRoleId, testTenantId],
    );

    // 3. Register User via API (Passing required tenantId and roleId)
    const registerDto = {
      email: testUser.email,
      password: testUser.password,
      fullName: testUser.fullName,
      phone: '555-1234',
      tenantId: testTenantId,
      roleId: testRoleId,
    };

    const regRes = await req(app.getHttpServer())
      .post('/auth/register')
      .send(registerDto);

    if (regRes.status !== 201) {
      console.error('Register failed:', regRes.body);
      throw new Error('Register failed');
    }

    // 4. Login to get Access Token
    const loginRes = await req(app.getHttpServer())
      .post('/auth/login')
      .send({ email: testUser.email, password: testUser.password });

    if (loginRes.status !== 200) {
      console.error('Login failed:', loginRes.body);
      throw new Error('Login failed');
    }

    accessToken = loginRes.body.accessToken;
    userId = loginRes.body.user.id;
    tenantId = loginRes.body.user.tenantId;

    // 5. Create Branch (SQL)
    await dataSource.query(
      `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
       VALUES ($1, $2, 'POS Branch', 'PB01', '123 POS Ave', '555-0000', true, NOW(), NOW())`,
      [testBranchId, tenantId],
    );

    // 6. Create Cash Register (SQL) linked to Branch
    await dataSource.query(
      `INSERT INTO cash_registers (id, tenant_id, branch_id, code, name, is_active, created_at, updated_at)
       VALUES ($1, $2, $3, 'REG-01', 'Main Register', true, NOW(), NOW())`,
      [testRegisterId, tenantId, testBranchId],
    );
  }

  it('Should open a cash session', async () => {
    const dto = {
      cashRegisterId: testRegisterId,
      openingAmount: 500.0,
      openingNotes: 'Start of day',
      branchId: testBranchId,
    };

    const res = await req(app.getHttpServer())
      .post('/cash-sessions/open')
      .set('Authorization', `Bearer ${accessToken}`)
      .send(dto);

    expect(res.status).toBe(201);
    expect(res.body.id).toBeDefined();
    expect(Number(res.body.initialAmount)).toBe(500.0);
    sessionId = res.body.id;
  });

  it('Should create a cash movement (Withdrawal)', async () => {
    const dto = {
      movementType: 'withdrawal',
      amount: 50.0,
      concept: 'Test Withdrawal',
      category: 'expense',
      reference: 'REF-123',
    };

    const res = await req(app.getHttpServer())
      .post('/cash-movements') // The new endpoint
      .set('Authorization', `Bearer ${accessToken}`)
      .send(dto);

    expect(res.status).toBe(201);
    expect(res.body.cashSessionId).toBe(sessionId);
    expect(Number(res.body.amount)).toBe(50.0);
    expect(res.body.branchId).toBe(testBranchId);
  });

  it('Should auto-update cash session system amount', async () => {
    // 500 initial - 50 withdrawal = 450
    const res = await req(app.getHttpServer())
      .get('/cash-sessions/active')
      .set('Authorization', `Bearer ${accessToken}`);

    expect(res.status).toBe(200);
    expect(Number(res.body.systemAmount)).toBe(450.0);
  });
});
