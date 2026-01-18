import { Test, TestingModule } from '@nestjs/testing';
import { AppModule } from '../src/app.module';
import { AuthService } from '../src/auth/auth.service';
import { INestApplication, VersioningType } from '@nestjs/common';
const request = require('supertest');
import { ConfigService } from '@nestjs/config';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Role, Tenant } from '@qflow/database';
import { Repository } from 'typeorm';

describe('Auth Persistence Integration', () => {
  let app: INestApplication;
  let authService: AuthService;
  let roleRepository: Repository<Role>;
  let tenantRepository: Repository<Tenant>;
  let createdUser: any;
  let token: string;
  let secret: string;

  const testEmail = `persistence-test-${Date.now()}@example.com`;
  const testPassword = 'Password123!';

  // Step 1: Initialize App, Register/Login, Get Token
  it('should register and login to get a token', async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();

    // Replicate main.ts configuration
    app.setGlobalPrefix('api');
    app.enableVersioning({
      type: VersioningType.URI,
      defaultVersion: '1',
    });

    await app.init();

    authService = moduleFixture.get<AuthService>(AuthService);
    roleRepository = moduleFixture.get<Repository<Role>>(
      getRepositoryToken(Role),
    );
    tenantRepository = moduleFixture.get<Repository<Tenant>>(
      getRepositoryToken(Tenant),
    );
    const configService = moduleFixture.get<ConfigService>(ConfigService);
    secret = configService.get('auth.jwtSecret') || '';

    // Get a valid role
    const role = await roleRepository.findOne({ where: {} });
    const roleId = role ? role.id : 'default-role-id';

    // Get a valid tenant
    const tenant = await tenantRepository.findOne({ where: {} });
    const tenantId = tenant ? tenant.id : 'default-tenant-id';

    // Register
    try {
      await authService.register({
        email: testEmail,
        password: testPassword,
        fullName: 'Persistence Tester',
        tenantId: tenantId,
        roleId: roleId,
        branchIds: [],
        phone: '1234567890',
      });
    } catch (e) {
      // console.error('Registration failed:', e);
      // Don't fail here, maybe user already exists or other valid reason,
      // but logging helps debugging. Check login next.
    }

    // Login
    const loginResponse = await authService.login({
      email: testEmail,
      password: testPassword,
    });

    token = loginResponse.accessToken;
    expect(token).toBeDefined();

    await app.close();
  });

  // Step 2: Re-initialize App (Simulate Restart) and Validate Token
  it('should validate the token after restart', async () => {
    const moduleFixture: TestingModule = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleFixture.createNestApplication();

    // Replicate main.ts configuration
    app.setGlobalPrefix('api');
    app.enableVersioning({
      type: VersioningType.URI,
      defaultVersion: '1',
    });

    await app.init();

    // Verify Secret consistency
    const configService = moduleFixture.get<ConfigService>(ConfigService);
    const newSecret = configService.get('auth.jwtSecret');
    expect(newSecret).toBe(secret);

    // Try to access a protected route using the OLD token
    // Since we don't have a simple GET /profile without controller, we verify via strategy logic or http
    // But let's use the actual /api/v1/auth/profile endpoint if possible, but testing module mocks http?
    // We can use supertest.

    const response = await request(app.getHttpServer())
      .get('/api/v1/auth/profile')
      .set('Authorization', `Bearer ${token}`)
      .expect(200);

    // Verify Profile Payload (User Entity Fields)
    expect(response.body.email).toBe(testEmail);
    expect(response.body).toHaveProperty('avatarUrl');
    expect(response.body).toHaveProperty('language');
    expect(response.body).toHaveProperty('timezone');

    // Verify Settings Payload (Tenant Security Fields)
    const settingsResponse = await request(app.getHttpServer())
      .get('/api/v1/settings/security')
      .set('Authorization', `Bearer ${token}`)
      .expect(200);

    expect(settingsResponse.body).toHaveProperty('sessionTimeoutMinutes');
    expect(settingsResponse.body).toHaveProperty('minPasswordLength');
    expect(settingsResponse.body).toHaveProperty('passwordExpiryDays');
    expect(settingsResponse.body).toHaveProperty('maxLoginAttempts');

    await app.close();
  });
});
