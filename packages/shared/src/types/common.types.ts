/**
 * Common Types
 * Base types used throughout the application.
 */

/** UUID string type alias */
export type UUID = string;

/** ISO 8601 DateTime string type alias */
export type DateTime = string;

/** Money amount in smallest currency unit (cents) */
export type Money = number;

/** Percentage represented as decimal (0.0 - 1.0) */
export type Percentage = number;

/**
 * Audit fields present on most entities
 */
export interface AuditFields {
    createdAt: DateTime;
    updatedAt: DateTime;
    createdBy?: UUID;
    updatedBy?: UUID;
}

/**
 * Soft delete fields
 */
export interface SoftDeleteFields {
    deletedAt?: DateTime;
    deletedBy?: UUID;
}

/**
 * Multi-tenant fields
 */
export interface TenantFields {
    tenantId: UUID;
}

/**
 * Offline sync fields
 */
export interface SyncFields {
    localId?: string;
    synced: boolean;
    syncedAt?: DateTime;
}

/**
 * Base entity with common fields
 */
export interface BaseEntity extends AuditFields, TenantFields {
    id: UUID;
}

/**
 * API Response wrapper
 */
export interface ApiResponse<T> {
    success: boolean;
    data?: T;
    error?: {
        code: string;
        message: string;
        details?: Record<string, unknown>;
    };
    meta?: Record<string, unknown>;
}

/**
 * Bulk operation result
 */
export interface BulkOperationResult {
    total: number;
    successful: number;
    failed: number;
    errors?: Array<{
        index: number;
        error: string;
    }>;
}
