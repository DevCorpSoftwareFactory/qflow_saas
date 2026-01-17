/**
 * Current User Decorator
 * Parameter decorator to extract current user from request.
 * 
 * Note: The actual extraction logic lives in the NestJS guard/interceptor.
 * This decorator just marks the parameter for extraction.
 */

import 'reflect-metadata';
import { CURRENT_USER_KEY } from './metadata';

/**
 * Current user options
 */
export interface CurrentUserOptions {
    /**
     * Specific property to extract from user object
     */
    property?: string;
    /**
     * Whether user is required (throw if not present)
     */
    required?: boolean;
}

/**
 * Default options
 */
const DEFAULT_OPTIONS: CurrentUserOptions = {
    required: true,
};

/**
 * Parameter decorator metadata storage
 */
export interface CurrentUserMetadata {
    parameterIndex: number;
    options: CurrentUserOptions;
}

/**
 * Store for parameter decorators (since Reflect.metadata doesn't work well with params)
 */
const currentUserParams = new WeakMap<object, Map<string | symbol, CurrentUserMetadata[]>>();

/**
 * Mark a parameter as the current user injection point
 */
export function CurrentUser(options: CurrentUserOptions = {}): ParameterDecorator {
    const mergedOptions = { ...DEFAULT_OPTIONS, ...options };

    return (target: object, propertyKey: string | symbol | undefined, parameterIndex: number): void => {
        if (propertyKey === undefined) return;

        // Store metadata for parameter
        const metadata: CurrentUserMetadata = {
            parameterIndex,
            options: mergedOptions,
        };

        // Get or create map for this target
        let targetMap = currentUserParams.get(target.constructor);
        if (!targetMap) {
            targetMap = new Map();
            currentUserParams.set(target.constructor, targetMap);
        }

        // Get or create array for this method
        const methodParams = targetMap.get(propertyKey) || [];
        methodParams.push(metadata);
        targetMap.set(propertyKey, methodParams);

        // Also store via Reflect for NestJS compatibility
        Reflect.defineMetadata(CURRENT_USER_KEY, mergedOptions, target.constructor, propertyKey);
    };
}

/**
 * Get current user metadata for a method
 */
export function getCurrentUserMetadata(
    target: object,
    propertyKey: string | symbol,
): CurrentUserMetadata[] | undefined {
    const targetMap = currentUserParams.get(target.constructor || target);
    return targetMap?.get(propertyKey);
}
