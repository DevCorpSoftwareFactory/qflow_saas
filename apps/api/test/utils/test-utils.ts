/**
 * Test Utilities
 *
 * Shared typed interfaces and helper functions for E2E tests.
 * These enable strict type checking without ESLint violations.
 */
import { INestApplication } from '@nestjs/common';
import request from 'supertest';

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

  const body = response.body as RegisterResponseBody;
  return body.id;
}

// ============================================
// Test Constants
// ============================================

export const TEST_TENANT_ID = '00000000-0000-0000-0000-000000000001';
export const TEST_ROLE_ID = '00000000-0000-0000-0000-000000000002';
export const TEST_BRANCH_ID = '00000000-0000-0000-0000-000000000002';
export const TEST_VARIANT_ID = '00000000-0000-0000-0000-000000000003';
export const TEST_CASHIER_ID = '00000000-0000-0000-0000-000000000004';
