/**
 * Test Utilities
 *
 * Shared typed interfaces and helper functions for E2E tests.
 * These enable strict type checking without ESLint violations.
 */
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Role, Tenant } from '@qflow/database';
import { Repository, DataSource } from 'typeorm';
import { randomUUID } from 'crypto';

// ============================================
// API Response Types
// ============================================

export interface LoginResponseBody {
  accessToken: string;
  requiresMfa: boolean;
  user: {
    id: string;
    email: string;
    fullName: string;
    tenantId: string;
  };
}

export interface RegisterResponseBody {
  id: string;
  email: string;
}

export interface MfaSetupResponseBody {
  secret: string;
  qrCodeUrl: string;
}

export interface ErrorResponseBody {
  message: string | string[];
  statusCode: number;
  error?: string;
}

export interface SaleResponseBody {
  id: string;
  totalAmount: number;
  subtotal: number;
  taxAmount: number;
}

export interface StockCheckResponseBody {
  available: boolean;
  quantity: number;
}

// ============================================
// Database Query Result Types
// ============================================

export interface StockQueryResult {
  total: string | number;
}

export interface SalesCountResult {
  count: string | number;
}

export interface FailedLoginResult {
  failed_login_attempts: number;
}

export interface InventoryMovementResult {
  quantity: number;
  movement_type: string;
}

export interface UserQueryResult {
  full_name: string;
  email: string;
}

// ============================================
// Test Helpers
// ============================================

/**
 * Get typed HTTP server from NestJS application.
 * Use this instead of app.getHttpServer() directly.
 */
export function getTestServer(
  app: INestApplication,
): ReturnType<typeof request> {
  return request(app.getHttpServer() as Parameters<typeof request>[0]);
}

/**
 * Create a typed login request.
 */
export async function loginUser(
  app: INestApplication,
  email: string,
  password: string,
): Promise<{ token: string; userId: string }> {
  const response = await getTestServer(app)
    .post('/auth/login')
    .send({ email, password });

  const body = response.body as LoginResponseBody;
  if (!body.user) {
    throw new Error(`Login failed: ${JSON.stringify(body)}`);
  }
  return {
    token: body.accessToken,
    userId: body.user.id,
  };
}

/**
 * Register a test user and return their ID.
 */
export async function registerUser(
  app: INestApplication,
  userData: {
    email: string;
    password: string;
    fullName: string;
    tenantId: string;
    roleId: string;
  },
): Promise<string> {
  const response = await getTestServer(app)
    .post('/auth/register')
    .send(userData);

  const body = response.body as RegisterResponseBody & ErrorResponseBody;

  if (response.status !== 201 || !body.id) {
    throw new Error(`Registration failed: ${JSON.stringify(body)}`);
  }

  return body.id;
}

// ============================================
// Test Constants
// ============================================

// Valid v4 UUIDs generated for testing to satisfy @IsUUID('4') constraints
export const TEST_TENANT_ID = 'd9b1df87-e4f6-4777-9049-a95a7f63391c';
export const TEST_ROLE_ID = 'f47ac10b-58cc-4372-a567-0e02b2c3d479';
export const TEST_BRANCH_ID = 'a0eebc99-9c0b-4ef8-bb6d-6bb9bd380a11';
export const TEST_VARIANT_ID = 'b5eebc99-9c0b-4ef8-bb6d-6bb9bd380a12';
export const TEST_CASHIER_ID = 'c9eebc99-9c0b-4ef8-bb6d-6bb9bd380a13';

/**
 * Helper to create a user and login, returning auth token and user details.
 * Simplifies E2E test setup.
 */
export async function createAuthorizedUser(
  app: INestApplication,
  overrideData: Partial<
    RegisterResponseBody & { tenantId: string; roleId: string }
  > = {},
): Promise<{
  token: string;
  userId: string;
  tenantId: string;
  roleId: string;
}> {
  const uniqueSuffix = Date.now();

  // Use consistent IDs for testing
  const tenantId = overrideData.tenantId || TEST_TENANT_ID;
  const roleId = overrideData.roleId || TEST_ROLE_ID;

  // Seed Tenant if missing
  const dataSource = app.get(DataSource);
  const tenantRepo = dataSource.getRepository(Tenant);
  let tenant = await tenantRepo.findOne({ where: { id: tenantId } });
  if (!tenant) {
    tenant = tenantRepo.create({
      id: tenantId,
      slug: `test-${uniqueSuffix}`, // Short enough for varchar(50)
      companyName: 'Test Company',
      taxId: `NIT-${uniqueSuffix}`,
      email: `contact-${uniqueSuffix}@test.com`,
      plan: 'enterprise',
      status: 'active',
      timezone: 'America/Bogota',
      currency: 'COP',
      language: 'es',
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    await tenantRepo.save(tenant);
  }

  // Seed Role if missing
  const roleRepo = dataSource.getRepository(Role);
  let role = await roleRepo.findOne({ where: { id: roleId } });
  if (!role) {
    role = roleRepo.create({
      id: roleId,
      tenantId: tenantId,
      name: 'Admin',
      description: 'Test Admin Role',
      permissions: {}, // Empty permissions is fine for basic existence
      isSystemRole: false,
      isActive: true, // Make sure it's active
      createdAt: new Date(),
      updatedAt: new Date(),
    });
    await roleRepo.save(role);
  }

  const userData = {
    email: `test-user-${uniqueSuffix}@example.com`,
    password: 'SecureTestPass123!',
    fullName: 'Test User',
    tenantId,
    roleId,
    ...overrideData,
  };

  const userId = await registerUser(app, userData);
  const { token } = await loginUser(app, userData.email, userData.password);

  return {
    token,
    userId,
    tenantId: userData.tenantId,
    roleId: userData.roleId,
  };
}
