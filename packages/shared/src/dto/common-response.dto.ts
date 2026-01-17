/**
 * Common Response DTOs
 * Standard API response wrappers.
 */

import { ErrorCode } from './error-code.enum';

/**
 * API Error details
 */
export interface ApiErrorDto {
    code: ErrorCode | string;
    message: string;
    field?: string;
    details?: Record<string, unknown>;
}

/**
 * Standard API response wrapper
 */
export interface ApiResponseDto<T = unknown> {
    success: boolean;
    data?: T;
    error?: ApiErrorDto;
    errors?: ApiErrorDto[];
    meta?: Record<string, unknown>;
    timestamp: string;
    requestId?: string;
}

/**
 * Success response (shorthand)
 */
export interface ApiSuccessDto<T = unknown> extends ApiResponseDto<T> {
    success: true;
    data: T;
}

/**
 * Error response (shorthand)
 */
export interface ApiErrorResponseDto extends ApiResponseDto<never> {
    success: false;
    error: ApiErrorDto;
}

/**
 * Create a success response
 */
export function createSuccessResponse<T>(
    data: T,
    meta?: Record<string, unknown>,
): ApiSuccessDto<T> {
    return {
        success: true,
        data,
        meta,
        timestamp: new Date().toISOString(),
    };
}

/**
 * Create an error response
 */
export function createErrorResponse(
    code: ErrorCode | string,
    message: string,
    details?: Record<string, unknown>,
): ApiErrorResponseDto {
    return {
        success: false,
        error: { code, message, details },
        timestamp: new Date().toISOString(),
    };
}

/**
 * Create a validation error response
 */
export function createValidationErrorResponse(
    errors: Array<{ field: string; message: string }>,
): ApiResponseDto<never> {
    return {
        success: false,
        errors: errors.map((e) => ({
            code: 'VALIDATION_ERROR',
            message: e.message,
            field: e.field,
        })),
        timestamp: new Date().toISOString(),
    };
}
