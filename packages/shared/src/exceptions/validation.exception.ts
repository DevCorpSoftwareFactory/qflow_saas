/**
 * Validation Exception
 * Exception for validation errors with field-level details.
 */

import { DomainException } from './domain.exception';

/**
 * Validation error for a specific field
 */
export interface ValidationError {
    field: string;
    message: string;
    value?: unknown;
    constraint?: string;
}

/**
 * Validation exception with array of errors
 */
export class ValidationException extends DomainException {
    public readonly errors: ValidationError[];

    constructor(errors: ValidationError[], message?: string) {
        super(
            'VALIDATION_ERROR',
            message || `Validation failed: ${errors.length} error(s)`,
            { errors },
        );
        this.name = 'ValidationException';
        this.errors = errors;
    }

    /**
     * Create from a single field error
     */
    static fromField(field: string, message: string, value?: unknown): ValidationException {
        return new ValidationException([{ field, message, value }]);
    }

    /**
     * Create from multiple fields
     */
    static fromFields(fieldErrors: Record<string, string>): ValidationException {
        const errors: ValidationError[] = Object.entries(fieldErrors).map(([field, message]) => ({
            field,
            message,
        }));
        return new ValidationException(errors);
    }

    /**
     * Get errors for a specific field
     */
    getFieldErrors(field: string): ValidationError[] {
        return this.errors.filter((e) => e.field === field);
    }

    /**
     * Check if field has errors
     */
    hasFieldError(field: string): boolean {
        return this.errors.some((e) => e.field === field);
    }

    override toJSON(): Record<string, unknown> {
        return {
            ...super.toJSON(),
            errors: this.errors,
        };
    }
}
