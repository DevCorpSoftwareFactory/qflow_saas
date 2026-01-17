/**
 * Not Found Exception
 * Exception when an entity is not found.
 */

import { DomainException } from './domain.exception';

/**
 * Not found exception with entity type and ID
 */
export class NotFoundException extends DomainException {
    public readonly entityType: string;
    public readonly entityId: string;

    constructor(entityType: string, entityId: string, message?: string) {
        super(
            'NOT_FOUND',
            message || `${entityType} with ID '${entityId}' not found`,
            { entityType, entityId },
        );
        this.name = 'NotFoundException';
        this.entityType = entityType;
        this.entityId = entityId;
    }

    /**
     * Create not found exception for a specific entity type
     */
    static for(entityType: string): (id: string) => NotFoundException {
        return (id: string) => new NotFoundException(entityType, id);
    }

    override toJSON(): Record<string, unknown> {
        return {
            ...super.toJSON(),
            entityType: this.entityType,
            entityId: this.entityId,
        };
    }
}
