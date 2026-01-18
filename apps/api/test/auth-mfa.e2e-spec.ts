import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { AppModule } from '../src/app.module';
import { DataSource } from 'typeorm';
import { randomUUID } from 'crypto';
import {
  getTestServer,
  LoginResponseBody,
  RegisterResponseBody,
  MfaSetupResponseBody,
} from './utils/test-utils';
import { authenticator } from 'otplib';

describe('Auth MFA (e2e)', () => {
  let app: INestApplication;

  const uniqueSuffix = Date.now();
  const testUser = {
    email: `mfa-flow-${uniqueSuffix}@test.com`,
    password: 'SecureMfaPass123!',
    fullName: 'MFA Flow User',
    tenantId: '',
    roleId: '',
  };

  let dataSource: DataSource;
  let tenantId: string;
  let roleId: string;

  beforeAll(async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();
    app.useGlobalPipes(
      new ValidationPipe({ whitelist: true, transform: true }),
    );
    await app.init();

    dataSource = moduleFixture.get(DataSource);

    // Seed Tenant and Role
    tenantId = randomUUID();
    roleId = randomUUID();

    // Insert Tenant
    await dataSource.query(
      `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
       VALUES ($1, 'MFA Test Tenant', $2, $3, $4, 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
      [
        tenantId,
        `mfa-${uniqueSuffix}`,
        `TAX-${uniqueSuffix}`,
        `admin-mfa-${uniqueSuffix}@test.com`,
      ],
    );

    // Insert Role
    await dataSource.query(
      `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
       VALUES ($1, $2, 'User Role', 'Basic Access', false, '["*"]')`,
      [roleId, tenantId],
    );

    testUser.tenantId = tenantId;
    testUser.roleId = roleId;
  });

  afterAll(async () => {
    await app.close();
  });

  let userId: string;
  let accessToken: string;
  let mfaSecret: string;

  it('Step 1: Register User', async () => {
    const response = await getTestServer(app)
      .post('/auth/register')
      .send(testUser);

    expect(response.status).toBe(201);
    const body = response.body as RegisterResponseBody;
    userId = body.id;
  });

  it('Step 2: Login (Initial - No MFA)', async () => {
    const response = await getTestServer(app)
      .post('/auth/login')
      .send({ email: testUser.email, password: testUser.password });

    expect(response.status).toBe(200);
    const body = response.body as LoginResponseBody;
    expect(body.requiresMfa).toBeFalsy();
    accessToken = body.accessToken;
  });

  it('Step 3: Setup MFA', async () => {
    const response = await getTestServer(app)
      .post('/auth/mfa/setup')
      .set('Authorization', `Bearer ${accessToken}`)
      .send({ userId });

    expect(response.status).toBe(200);
    const body = response.body as MfaSetupResponseBody;
    expect(body.secret).toBeDefined();
    expect(body.qrCodeUrl).toBeDefined();
    mfaSecret = body.secret;
  });

  it('Step 4: Verify MFA (Enable)', async () => {
    const token = authenticator.generate(mfaSecret);
    const response = await getTestServer(app)
      .post('/auth/mfa/verify')
      .set('Authorization', `Bearer ${accessToken}`)
      .send({ userId, code: token });

    expect(response.status).toBe(200);
    expect(response.body).toEqual({ success: true });
  });

  it('Step 5: Test Login with MFA Required', async () => {
    // Attempt login without code
    const response = await getTestServer(app)
      .post('/auth/login')
      .send({ email: testUser.email, password: testUser.password });

    expect(response.status).toBe(200);
    const body = response.body as LoginResponseBody;
    expect(body.accessToken).toBe(''); // Empty per service logic
    expect(body.requiresMfa).toBe(true);
  });

  it('Step 6: Test Login with MFA Code', async () => {
    const token = authenticator.generate(mfaSecret);
    const response = await getTestServer(app).post('/auth/login').send({
      email: testUser.email,
      password: testUser.password,
      mfaCode: token,
    });

    expect(response.status).toBe(200);
    const body = response.body as LoginResponseBody;
    expect(body.accessToken).not.toBe('');
    expect(body.requiresMfa).toBe(false);
  });

  it('Step 7: Test Login with Invalid MFA Code', async () => {
    const response = await getTestServer(app).post('/auth/login').send({
      email: testUser.email,
      password: testUser.password,
      mfaCode: '000000',
    });

    expect(response.status).toBe(401);
  });
});
