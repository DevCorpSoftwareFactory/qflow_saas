/**
 * User Types
 * Types for user management and authentication.
 */

import { UUID, DateTime, AuditFields } from './common.types';

/**
 * User status
 */
export enum UserStatus {
    PENDING = 'pending',
    ACTIVE = 'active',
    INACTIVE = 'inactive',
    SUSPENDED = 'suspended',
    DELETED = 'deleted',
}

/**
 * User role
 */
export enum UserRole {
    SUPER_ADMIN = 'super_admin',
    TENANT_ADMIN = 'tenant_admin',
    MANAGER = 'manager',
    CASHIER = 'cashier',
    WAREHOUSE = 'warehouse',
    VIEWER = 'viewer',
}

/**
 * User profile information
 */
export interface UserProfile {
    firstName: string;
    lastName: string;
    displayName?: string;
    avatarUrl?: string;
    phone?: string;
    language?: string;
    timezone?: string;
}

/**
 * User entity interface
 */
export interface User extends AuditFields {
    id: UUID;
    tenantId: UUID;
    email: string;
    status: UserStatus;
    role: UserRole;
    profile: UserProfile;
    branchIds?: UUID[];
    lastLoginAt?: DateTime;
    emailVerifiedAt?: DateTime;
}

/**
 * JWT Auth payload (token claims)
 */
export interface AuthPayload {
    sub: UUID; // User ID
    tenantId: UUID;
    email: string;
    role: UserRole;
    branchIds?: UUID[];
    iat?: number;
    exp?: number;
}

/**
 * Session information
 */
export interface UserSession {
    userId: UUID;
    tenantId: UUID;
    deviceId?: string;
    ipAddress?: string;
    userAgent?: string;
    createdAt: DateTime;
    expiresAt: DateTime;
}
