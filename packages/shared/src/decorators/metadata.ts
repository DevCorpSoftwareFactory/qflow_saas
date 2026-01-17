/**
 * Decorator Metadata Keys
 * Standard metadata keys for shared decorators.
 * These work with reflect-metadata and can be used by NestJS or other frameworks.
 */

// Import reflect-metadata polyfill
import 'reflect-metadata';

/**
 * Metadata key for public endpoints
 */
export const IS_PUBLIC_KEY = 'isPublic';

/**
 * Metadata key for current user parameter
 */
export const CURRENT_USER_KEY = 'currentUser';

/**
 * Metadata key for current tenant parameter  
 */
export const CURRENT_TENANT_KEY = 'currentTenant';

/**
 * Metadata key for required permissions
 */
export const PERMISSIONS_KEY = 'permissions';

/**
 * Metadata key for required roles
 */
export const ROLES_KEY = 'roles';

/**
 * Metadata key for audit log configuration
 */
export const AUDIT_LOG_KEY = 'auditLog';

/**
 * Metadata key for rate limiting
 */
export const RATE_LIMIT_KEY = 'rateLimit';

/**
 * Metadata key for caching
 */
export const CACHE_KEY = 'cache';

/**
 * Set metadata on a target
 * Framework-agnostic utility for setting metadata
 */
export function setMetadata<T>(key: string, value: T) {
    return function (
        target: object | Function,
        _propertyKey?: string | symbol,
        descriptor?: PropertyDescriptor,
    ): void {
        if (descriptor) {
            // Method decorator
            Reflect.defineMetadata(key, value, descriptor.value);
        } else {
            // Class decorator
            Reflect.defineMetadata(key, value, target);
        }
    };
}

/**
 * Get metadata from a target
 */
export function getMetadata<T>(key: string, target: object, propertyKey?: string | symbol): T | undefined {
    if (propertyKey) {
        return Reflect.getMetadata(key, target, propertyKey);
    }
    return Reflect.getMetadata(key, target);
}

/**
 * Check if metadata exists on a target
 */
export function hasMetadata(key: string, target: object, propertyKey?: string | symbol): boolean {
    if (propertyKey) {
        return Reflect.hasMetadata(key, target, propertyKey);
    }
    return Reflect.hasMetadata(key, target);
}
