/**
 * Entity Interface
 * Base interface for all domain entities.
 */

import { UUID, DateTime } from '../types/common.types';

/**
 * Base entity interface with common fields
 */
export interface IEntity {
    id: UUID;
    createdAt: DateTime;
    updatedAt: DateTime;
}

/**
 * Soft-deletable entity interface
 */
export interface ISoftDeletable {
    deletedAt?: DateTime;
    deletedBy?: UUID;
}

/**
 * Multi-tenant entity interface
 */
export interface ITenantEntity extends IEntity {
    tenantId: UUID;
}

/**
 * Auditable entity interface
 */
export interface IAuditable {
    createdBy?: UUID;
    updatedBy?: UUID;
}

/**
 * Full base entity with all common fields
 */
export interface IBaseEntity extends ITenantEntity, ISoftDeletable, IAuditable { }

/**
 * Syncable entity for offline-first support
 */
export interface ISyncable {
    localId?: string;
    synced: boolean;
    syncedAt?: DateTime;
}
