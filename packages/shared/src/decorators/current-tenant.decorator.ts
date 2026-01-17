/**
 * Current Tenant Decorator
 * Parameter decorator to extract current tenant from request.
 * 
 * Note: The actual extraction logic lives in the NestJS guard/interceptor.
 * This decorator just marks the parameter for extraction.
 */

import 'reflect-metadata';
import { CURRENT_TENANT_KEY } from './metadata';

/**
 * Current tenant options
 */
export interface CurrentTenantOptions {
    /**
     * Whether tenant is required (throw if not present)
     */
    required?: boolean;
}

/**
 * Default options
 */
const DEFAULT_OPTIONS: CurrentTenantOptions = {
    required: true,
};

/**
 * Parameter decorator metadata storage
 */
export interface CurrentTenantMetadata {
    parameterIndex: number;
    options: CurrentTenantOptions;
}

/**
 * Store for parameter decorators
 */
const currentTenantParams = new WeakMap<object, Map<string | symbol, CurrentTenantMetadata[]>>();

/**
 * Mark a parameter as the current tenant injection point
 */
export function CurrentTenant(options: CurrentTenantOptions = {}): ParameterDecorator {
    const mergedOptions = { ...DEFAULT_OPTIONS, ...options };

    return (target: object, propertyKey: string | symbol | undefined, parameterIndex: number): void => {
        if (propertyKey === undefined) return;

        // Store metadata for parameter
        const metadata: CurrentTenantMetadata = {
            parameterIndex,
            options: mergedOptions,
        };

        // Get or create map for this target
        let targetMap = currentTenantParams.get(target.constructor);
        if (!targetMap) {
            targetMap = new Map();
            currentTenantParams.set(target.constructor, targetMap);
        }

        // Get or create array for this method
        const methodParams = targetMap.get(propertyKey) || [];
        methodParams.push(metadata);
        targetMap.set(propertyKey, methodParams);

        // Also store via Reflect for NestJS compatibility
        Reflect.defineMetadata(CURRENT_TENANT_KEY, mergedOptions, target.constructor, propertyKey);
    };
}

/**
 * Get current tenant metadata for a method
 */
export function getCurrentTenantMetadata(
    target: object,
    propertyKey: string | symbol,
): CurrentTenantMetadata[] | undefined {
    const targetMap = currentTenantParams.get(target.constructor || target);
    return targetMap?.get(propertyKey);
}
