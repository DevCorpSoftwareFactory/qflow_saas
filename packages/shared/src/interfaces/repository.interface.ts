/**
 * Repository Interface
 * Generic repository interface for data access layer.
 */

import { UUID } from '../types/common.types';
import { PaginationParams, PaginatedResult } from '../types/pagination.types';
import { IEntity } from './entity.interface';

/**
 * Find options for queries
 */
export interface FindOptions<T> {
    where?: Partial<T>;
    orderBy?: { [K in keyof T]?: 'ASC' | 'DESC' };
    relations?: string[];
    select?: (keyof T)[];
}

/**
 * Find one options
 */
export interface FindOneOptions<T> extends FindOptions<T> {
    throwIfNotFound?: boolean;
}

/**
 * Bulk operation options
 */
export interface BulkOptions {
    skipValidation?: boolean;
    returnEntities?: boolean;
}

/**
 * Transaction callback type
 */
export type TransactionCallback<T> = (repository: IRepository<any>) => Promise<T>;

/**
 * Generic repository interface
 */
export interface IRepository<T extends IEntity> {
    /**
     * Find entity by ID
     */
    findById(id: UUID, options?: FindOneOptions<T>): Promise<T | null>;

    /**
     * Find one entity matching criteria
     */
    findOne(options: FindOneOptions<T>): Promise<T | null>;

    /**
     * Find all entities matching criteria
     */
    findAll(options?: FindOptions<T>): Promise<T[]>;

    /**
     * Find entities with pagination
     */
    findPaginated(params: PaginationParams, options?: FindOptions<T>): Promise<PaginatedResult<T>>;

    /**
     * Count entities matching criteria
     */
    count(options?: FindOptions<T>): Promise<number>;

    /**
     * Check if entity exists
     */
    exists(id: UUID): Promise<boolean>;

    /**
     * Create a new entity
     */
    create(data: Partial<T>): Promise<T>;

    /**
     * Create multiple entities
     */
    createMany(data: Partial<T>[], options?: BulkOptions): Promise<T[]>;

    /**
     * Update an entity by ID
     */
    update(id: UUID, data: Partial<T>): Promise<T>;

    /**
     * Update multiple entities
     */
    updateMany(criteria: Partial<T>, data: Partial<T>): Promise<number>;

    /**
     * Delete an entity by ID (soft delete if supported)
     */
    delete(id: UUID): Promise<boolean>;

    /**
     * Delete multiple entities
     */
    deleteMany(criteria: Partial<T>): Promise<number>;

    /**
     * Hard delete (permanent removal)
     */
    hardDelete(id: UUID): Promise<boolean>;

    /**
     * Restore a soft-deleted entity
     */
    restore(id: UUID): Promise<T>;

    /**
     * Execute operations within a transaction
     */
    transaction<R>(callback: TransactionCallback<R>): Promise<R>;
}

/**
 * Tenant-aware repository interface
 */
export interface ITenantRepository<T extends IEntity> extends IRepository<T> {
    /**
     * Set tenant context for all operations
     */
    setTenantId(tenantId: UUID): void;

    /**
     * Get current tenant ID
     */
    getTenantId(): UUID | null;
}
