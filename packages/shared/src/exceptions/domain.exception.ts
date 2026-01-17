/**
 * Domain Exception
 * Base exception class for all domain-level errors.
 */

/**
 * Error details type
 */
export type ErrorDetails = Record<string, unknown>;

/**
 * Base domain exception class
 */
export class DomainException extends Error {
    public readonly code: string;
    public readonly details?: ErrorDetails;
    public readonly timestamp: Date;

    constructor(code: string, message: string, details?: ErrorDetails) {
        super(message);
        this.name = 'DomainException';
        this.code = code;
        this.details = details;
        this.timestamp = new Date();

        // Set prototype explicitly for proper instanceof checks
        Object.setPrototypeOf(this, DomainException.prototype);
    }

    /**
     * Convert to plain object for serialization
     */
    toJSON(): Record<string, unknown> {
        return {
            name: this.name,
            code: this.code,
            message: this.message,
            details: this.details,
            timestamp: this.timestamp.toISOString(),
        };
    }

    /**
     * Create exception from error
     */
    static fromError(error: Error, code: string = 'UNKNOWN_ERROR'): DomainException {
        if (error instanceof DomainException) {
            return error;
        }
        return new DomainException(code, error.message, { originalError: error.name });
    }
}
