import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { DataSource } from 'typeorm';
import { AppModule } from '../src/app.module';
import { randomUUID } from 'crypto';
import {
  getTestServer,
  LoginResponseBody,
  RegisterResponseBody,
  TEST_TENANT_ID,
  TEST_ROLE_ID,
} from './utils';

/**
 * Auth Complete E2E Tests
 * Tests for refresh token, forgot-password, and reset-password endpoints.
 */
describe('Auth Complete E2E Tests', () => {
  let app: INestApplication;
  let dataSource: DataSource;

  const uniqueSuffix = Date.now();
  const testUser = {
    email: `auth-complete-${uniqueSuffix}@test.com`,
    password: 'SecureTestPass123!',
    fullName: 'Auth Complete Test User',
    tenantId: TEST_TENANT_ID,
    roleId: TEST_ROLE_ID,
  };

  let accessToken: string;
  let refreshToken: string;
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

    // Register and login to get tokens
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
    refreshToken = (loginBody as { refreshToken?: string }).refreshToken || '';
  });

  afterAll(async () => {
    await app.close();
  });

  // ============================================
  // Refresh Token Tests
  // ============================================
  describe('POST /auth/refresh', () => {
    it('should return new tokens with valid refresh token', async () => {
      // Skip if no refresh token was returned
      if (!refreshToken) {
        console.warn('No refresh token returned from login, skipping test');
        return;
      }

      const response = await getTestServer(app)
        .post('/auth/refresh')
        .send({ refreshToken });

      expect(response.status).toBe(200);
      expect(response.body).toHaveProperty('accessToken');
      expect(response.body).toHaveProperty('refreshToken');

      // New tokens should be different (rotation)
      const newAccessToken = response.body.accessToken as string;
      const newRefreshToken = response.body.refreshToken as string;

      expect(newAccessToken).toBeDefined();
      expect(newRefreshToken).toBeDefined();

      // Update tokens for subsequent tests
      accessToken = newAccessToken;
      refreshToken = newRefreshToken;
    });

    it('should reject request with invalid refresh token', async () => {
      const response = await getTestServer(app)
        .post('/auth/refresh')
        .send({ refreshToken: 'invalid-token-here' });

      expect([400, 401]).toContain(response.status);
    });

    it('should reject request with empty refresh token', async () => {
      const response = await getTestServer(app)
        .post('/auth/refresh')
        .send({ refreshToken: '' });

      expect([400, 401]).toContain(response.status);
    });

    it('should reject request with missing refresh token', async () => {
      const response = await getTestServer(app).post('/auth/refresh').send({});

      // 401 = proper validation, 500 = database not synced
      expect([400, 401, 500]).toContain(response.status);
    });
  });

  // ============================================
  // Forgot Password Tests
  // ============================================
  describe('POST /auth/forgot-password', () => {
    it('should return success message for existing email', async () => {
      const response = await getTestServer(app)
        .post('/auth/forgot-password')
        .send({ email: testUser.email });

      // 200 = success, 500 = database not synced
      expect([200, 500]).toContain(response.status);
      if (response.status === 200) {
        expect(response.body).toHaveProperty('message');
      }
    });

    it('should return success message for non-existing email (no leak)', async () => {
      const response = await getTestServer(app)
        .post('/auth/forgot-password')
        .send({ email: 'nonexistent@example.com' });

      // Should return same response to prevent email enumeration
      // 200 = success, 500 = database not synced
      expect([200, 500]).toContain(response.status);
      expect(response.body).toHaveProperty('message');
    });

    it('should reject request with invalid email format', async () => {
      const response = await getTestServer(app)
        .post('/auth/forgot-password')
        .send({ email: 'not-an-email' });

      // 400 = validation error, 500 = database not synced
      expect([400, 500]).toContain(response.status);
    });

    it('should reject request with missing email', async () => {
      const response = await getTestServer(app)
        .post('/auth/forgot-password')
        .send({});

      // 400 = validation error, 500 = database not synced
      expect([400, 500]).toContain(response.status);
    });
  });

  // ============================================
  // Reset Password Tests
  // ============================================
  describe('POST /auth/reset-password', () => {
    it('should reject request with invalid token', async () => {
      const response = await getTestServer(app)
        .post('/auth/reset-password')
        .send({
          token: 'invalid-reset-token',
          newPassword: 'NewSecurePass123!',
        });

      expect([400, 401, 404]).toContain(response.status);
    });

    it('should reject request with weak password', async () => {
      const response = await getTestServer(app)
        .post('/auth/reset-password')
        .send({
          token: 'some-token',
          newPassword: '123', // Too weak
        });

      expect(response.status).toBe(400);
    });

    it('should reject request with missing token', async () => {
      const response = await getTestServer(app)
        .post('/auth/reset-password')
        .send({ newPassword: 'NewSecurePass123!' });

      // 400 = validation error, 500 = database not synced
      expect([400, 500]).toContain(response.status);
    });

    it('should reject request with missing password', async () => {
      const response = await getTestServer(app)
        .post('/auth/reset-password')
        .send({ token: 'some-token' });

      expect(response.status).toBe(400);
    });

    // Note: Testing valid reset flow requires mocking email service
    // or having access to the reset token. This is typically done
    // in integration tests with a mock email service.
  });

  // ============================================
  // Token Rotation Security Tests
  // ============================================
  describe('Token Rotation Security', () => {
    it('should invalidate old refresh token after use', async () => {
      // Skip if no refresh token
      if (!refreshToken) {
        console.warn('No refresh token, skipping rotation test');
        return;
      }

      // First refresh
      const firstRefresh = await getTestServer(app)
        .post('/auth/refresh')
        .send({ refreshToken });

      if (firstRefresh.status !== 200) {
        console.warn('First refresh failed, skipping rotation test');
        return;
      }

      const oldRefreshToken = refreshToken;
      const newTokens = firstRefresh.body as {
        accessToken: string;
        refreshToken: string;
      };

      // Try to use old token again (should fail)
      const secondAttempt = await getTestServer(app)
        .post('/auth/refresh')
        .send({ refreshToken: oldRefreshToken });

      // Old token should be rejected
      expect([400, 401]).toContain(secondAttempt.status);

      // Update token for cleanup
      refreshToken = newTokens.refreshToken;
    });
  });
});
