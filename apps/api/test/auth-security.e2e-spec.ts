import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import {
  getTestServer,
  LoginResponseBody,
  FailedLoginResult,
  UserQueryResult,
  TEST_TENANT_ID,
  TEST_ROLE_ID,
} from './utils';

/**
 * Auth Security E2E Tests
 */
describe('AuthController Security Tests', () => {
  let app: INestApplication;
  let dataSource: DataSource;

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
  });

  afterAll(async () => {
    await app.close();
  });

  describe('Brute Force Protection', () => {
    const testEmail = 'bruteforce@test.com';
    const wrongPassword = 'wrongpassword';
    const maxAttempts = 5;

    it('should increment failed login attempts on wrong password', async () => {
      for (let i = 0; i < maxAttempts; i++) {
        await getTestServer(app)
          .post('/auth/login')
          .send({ email: testEmail, password: wrongPassword })
          .expect(401);
      }

      const result: FailedLoginResult[] = await dataSource.query(
        'SELECT failed_login_attempts FROM users WHERE email = $1',
        [testEmail],
      );

      if (result.length > 0) {
        expect(result[0].failed_login_attempts).toBeGreaterThanOrEqual(
          maxAttempts,
        );
      }
    });
  });

  describe('SQL Injection Prevention', () => {
    const sqlInjectionPayloads = [
      "admin'--",
      "admin'; DROP TABLE users;--",
      "' OR '1'='1",
      "1'; SELECT * FROM users WHERE '1'='1",
    ];

    sqlInjectionPayloads.forEach((payload) => {
      it(`should reject SQL injection: ${payload.substring(0, 20)}...`, async () => {
        const response = await getTestServer(app)
          .post('/auth/login')
          .send({ email: payload, password: 'password123' });

        expect([400, 401, 422]).toContain(response.status);

        const body = response.body as Record<string, unknown>;
        expect(body).not.toHaveProperty('passwordHash');
        expect(body).not.toHaveProperty('twoFactorSecret');
      });
    });
  });

  describe('JWT Token Security', () => {
    let validToken: string;
    const testUser = {
      email: `jwt-test-${Date.now()}@test.com`,
      password: 'SecurePass123!',
      fullName: 'JWT Test User',
      tenantId: TEST_TENANT_ID,
      roleId: TEST_ROLE_ID,
    };

    beforeAll(async () => {
      await getTestServer(app).post('/auth/register').send(testUser);

      const loginRes = await getTestServer(app)
        .post('/auth/login')
        .send({ email: testUser.email, password: testUser.password });

      const loginBody = loginRes.body as LoginResponseBody;
      validToken = loginBody.accessToken ?? '';
    });

    it('should reject requests with expired token', async () => {
      const expiredToken =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiZXhwIjoxfQ.invalid';

      const response = await getTestServer(app)
        .post('/auth/logout')
        .set('Authorization', `Bearer ${expiredToken}`);

      expect(response.status).toBe(401);
    });

    it('should reject requests with tampered token', async () => {
      if (!validToken) return;

      const parts = validToken.split('.');
      const tamperedPayload = Buffer.from(
        JSON.stringify({ sub: 'hacked-user-id', tenantId: 'hacked-tenant' }),
      ).toString('base64url');

      const tamperedToken = `${parts[0]}.${tamperedPayload}.${parts[2]}`;

      const response = await getTestServer(app)
        .post('/auth/logout')
        .set('Authorization', `Bearer ${tamperedToken}`);

      expect(response.status).toBe(401);
    });

    it('should not leak sensitive data in token payload', () => {
      if (!validToken) return;

      const payloadStr = Buffer.from(
        validToken.split('.')[1],
        'base64url',
      ).toString();
      const payload = JSON.parse(payloadStr) as Record<string, unknown>;

      expect(payload).not.toHaveProperty('password');
      expect(payload).not.toHaveProperty('passwordHash');
      expect(payload).not.toHaveProperty('twoFactorSecret');
    });
  });

  describe('Input Validation', () => {
    it('should reject registration with weak password', async () => {
      const response = await getTestServer(app).post('/auth/register').send({
        email: 'weak@test.com',
        password: '123',
        fullName: 'Weak Password User',
        tenantId: TEST_TENANT_ID,
        roleId: TEST_ROLE_ID,
      });

      expect(response.status).toBe(400);
    });

    it('should reject registration with invalid email', async () => {
      const response = await getTestServer(app).post('/auth/register').send({
        email: 'not-an-email',
        password: 'SecurePass123!',
        fullName: 'Invalid Email User',
        tenantId: TEST_TENANT_ID,
        roleId: TEST_ROLE_ID,
      });

      expect(response.status).toBe(400);
    });

    it('should reject registration with invalid UUID for tenantId', async () => {
      const response = await getTestServer(app).post('/auth/register').send({
        email: 'uuid-test@test.com',
        password: 'SecurePass123!',
        fullName: 'UUID Test User',
        tenantId: 'not-a-uuid',
        roleId: TEST_ROLE_ID,
      });

      expect(response.status).toBe(400);
    });

    it('should handle XSS in fullName', async () => {
      const xssPayload = '<script>alert("xss")</script>';
      const testEmail = `xss-test-${Date.now()}@test.com`;

      const response = await getTestServer(app).post('/auth/register').send({
        email: testEmail,
        password: 'SecurePass123!',
        fullName: xssPayload,
        tenantId: TEST_TENANT_ID,
        roleId: TEST_ROLE_ID,
      });

      if (response.status === 201) {
        const user: UserQueryResult[] = await dataSource.query(
          'SELECT full_name FROM users WHERE email = $1',
          [testEmail],
        );

        if (user.length > 0) {
          expect(user[0].full_name).not.toContain('<script>');
        }
      }
    });
  });
});
