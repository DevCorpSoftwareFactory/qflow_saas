/**
 * Forbidden Exception
 * Exception for authorization/permission errors.
 */

import { DomainException } from './domain.exception';

/**
 * Forbidden exception with required permissions
 */
export class ForbiddenException extends DomainException {
    public readonly requiredPermissions?: string[];
    public readonly resource?: string;
    public readonly action?: string;

    constructor(
        message: string,
        requiredPermissions?: string[],
        resource?: string,
        action?: string,
    ) {
        super('FORBIDDEN', message, { requiredPermissions, resource, action });
        this.name = 'ForbiddenException';
        this.requiredPermissions = requiredPermissions;
        this.resource = resource;
        this.action = action;
    }

    /**
     * Create exception for missing permission
     */
    static missingPermission(permission: string): ForbiddenException {
        return new ForbiddenException(
            `Missing required permission: ${permission}`,
            [permission],
        );
    }

    /**
     * Create exception for missing multiple permissions
     */
    static missingPermissions(permissions: string[]): ForbiddenException {
        return new ForbiddenException(
            `Missing required permissions: ${permissions.join(', ')}`,
            permissions,
        );
    }

    /**
     * Create exception for resource access
     */
    static resourceAccess(resource: string, action: string): ForbiddenException {
        return new ForbiddenException(
            `Access denied: Cannot ${action} ${resource}`,
            undefined,
            resource,
            action,
        );
    }

    /**
     * Create exception for tenant access
     */
    static tenantAccess(tenantId: string): ForbiddenException {
        return new ForbiddenException(
            `Access denied: No access to tenant '${tenantId}'`,
            undefined,
            'tenant',
            'access',
        );
    }

    override toJSON(): Record<string, unknown> {
        return {
            ...super.toJSON(),
            requiredPermissions: this.requiredPermissions,
            resource: this.resource,
            action: this.action,
        };
    }
}
