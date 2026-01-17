/**
 * Conflict Exception
 * Exception for resource conflicts (duplicates, concurrent modifications).
 */

import { DomainException } from './domain.exception';

/**
 * Conflict reason type
 */
export type ConflictReason = 'DUPLICATE' | 'CONCURRENT_MODIFICATION' | 'STATE_CONFLICT' | 'CONSTRAINT_VIOLATION';

/**
 * Conflict exception with reason
 */
export class ConflictException extends DomainException {
    public readonly reason: ConflictReason;
    public readonly conflictingField?: string;
    public readonly conflictingValue?: unknown;

    constructor(
        reason: ConflictReason,
        message: string,
        conflictingField?: string,
        conflictingValue?: unknown,
    ) {
        super('CONFLICT', message, { reason, conflictingField, conflictingValue });
        this.name = 'ConflictException';
        this.reason = reason;
        this.conflictingField = conflictingField;
        this.conflictingValue = conflictingValue;
    }

    /**
     * Create duplicate exception
     */
    static duplicate(field: string, value: unknown): ConflictException {
        return new ConflictException(
            'DUPLICATE',
            `Duplicate value for ${field}: '${value}'`,
            field,
            value,
        );
    }

    /**
     * Create concurrent modification exception
     */
    static concurrentModification(entityType: string, entityId: string): ConflictException {
        return new ConflictException(
            'CONCURRENT_MODIFICATION',
            `${entityType} with ID '${entityId}' was modified by another process`,
        );
    }

    /**
     * Create state conflict exception
     */
    static stateConflict(message: string): ConflictException {
        return new ConflictException('STATE_CONFLICT', message);
    }

    override toJSON(): Record<string, unknown> {
        return {
            ...super.toJSON(),
            reason: this.reason,
            conflictingField: this.conflictingField,
            conflictingValue: this.conflictingValue,
        };
    }
}
