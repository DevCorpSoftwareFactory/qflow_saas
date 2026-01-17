/**
 * Public Decorator
 * Marks endpoint as public (no authentication required).
 * 
 * Usage (in NestJS):
 * @Public()
 * @Get('health')
 * healthCheck() { ... }
 */

import 'reflect-metadata';
import { IS_PUBLIC_KEY } from './metadata';

/**
 * Mark a class or method as public (no auth required)
 */
export function Public() {
    return function (
        target: object | Function,
        _propertyKey?: string | symbol,
        descriptor?: PropertyDescriptor,
    ): void {
        if (descriptor) {
            Reflect.defineMetadata(IS_PUBLIC_KEY, true, descriptor.value);
        } else {
            Reflect.defineMetadata(IS_PUBLIC_KEY, true, target);
        }
    };
}

/**
 * Check if a target is marked as public
 */
export function isPublic(target: object, propertyKey?: string | symbol): boolean {
    if (propertyKey) {
        return Reflect.getMetadata(IS_PUBLIC_KEY, target, propertyKey) === true;
    }
    return Reflect.getMetadata(IS_PUBLIC_KEY, target) === true;
}
