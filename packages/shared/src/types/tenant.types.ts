/**
 * Tenant Types
 * Types for multi-tenant organization management.
 */

import { UUID, DateTime, AuditFields } from './common.types';
import { LicenseStatus } from '../enums/license-status.enum';

/**
 * Tenant status
 */
export enum TenantStatus {
    PENDING = 'pending',
    ACTIVE = 'active',
    SUSPENDED = 'suspended',
    CANCELLED = 'cancelled',
}

/**
 * Tenant subscription plan
 */
export enum TenantPlan {
    FREE = 'free',
    STARTER = 'starter',
    PROFESSIONAL = 'professional',
    ENTERPRISE = 'enterprise',
}

/**
 * Tenant limits based on plan
 */
export interface TenantLimits {
    maxUsers: number;
    maxBranches: number;
    maxProducts: number;
    maxTransactionsPerMonth: number;
    maxStorageMB: number;
    features: string[];
}

/**
 * Tenant settings interface
 */
export interface TenantSettingsType {
    // General
    timezone: string;
    currency: string;
    locale: string;
    dateFormat: string;

    // Business
    taxId?: string;
    legalName?: string;
    tradeName?: string;
    address?: string;
    phone?: string;
    email?: string;

    // POS Settings
    allowNegativeStock: boolean;
    requireCashSessionOpen: boolean;
    enableBlindCounting: boolean;
    defaultPriceListId?: UUID;

    // Notifications
    emailNotifications: boolean;
    lowStockAlerts: boolean;
    dailyReports: boolean;
}

/**
 * Tenant metrics/usage
 */
export interface TenantMetrics {
    usersCount: number;
    branchesCount: number;
    productsCount: number;
    transactionsThisMonth: number;
    storageUsedMB: number;
    lastActivityAt?: DateTime;
}

/**
 * Tenant entity interface
 */
export interface Tenant extends AuditFields {
    id: UUID;
    name: string;
    slug: string;
    status: TenantStatus;
    plan: TenantPlan;
    licenseStatus: LicenseStatus;
    licenseExpiresAt?: DateTime;
    settings: TenantSettingsType;
    limits: TenantLimits;
    metrics?: TenantMetrics;
    logoUrl?: string;
    primaryColor?: string;
}
