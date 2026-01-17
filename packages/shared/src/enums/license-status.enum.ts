/**
 * License Status Enum
 * Represents the status of a tenant's license/subscription.
 */
export enum LicenseStatus {
    PENDING = 'pending',
    ACTIVE = 'active',
    EXPIRED = 'expired',
    SUSPENDED = 'suspended',
    CANCELLED = 'cancelled',
    REVOKED = 'revoked',
}
