/**
 * Service Interface
 * Generic service interface for business logic layer.
 */

import { UUID } from '../types/common.types';
import { PaginationParams, PaginatedResult } from '../types/pagination.types';
import { IEntity } from './entity.interface';

/**
 * Service context with user and tenant information
 */
export interface ServiceContext {
    tenantId: UUID;
    userId: UUID;
    userRole?: string;
    permissions?: string[];
    ipAddress?: string;
    userAgent?: string;
}

/**
 * Base service options
 */
export interface ServiceOptions {
    context: ServiceContext;
    skipValidation?: boolean;
    skipAudit?: boolean;
}

/**
 * Generic service interface
 */
export interface IService<T extends IEntity, CreateDto, UpdateDto> {
    /**
     * Get entity by ID
     */
    getById(id: UUID, context: ServiceContext): Promise<T>;

    /**
     * Get all entities with pagination
     */
    getAll(params: PaginationParams, context: ServiceContext): Promise<PaginatedResult<T>>;

    /**
     * Create a new entity
     */
    create(dto: CreateDto, options: ServiceOptions): Promise<T>;

    /**
     * Update an existing entity
     */
    update(id: UUID, dto: UpdateDto, options: ServiceOptions): Promise<T>;

    /**
     * Delete an entity
     */
    delete(id: UUID, options: ServiceOptions): Promise<boolean>;

    /**
     * Validate entity data
     */
    validate(dto: CreateDto | UpdateDto): Promise<void>;
}

/**
 * CRUD service with extended operations
 */
export interface ICrudService<T extends IEntity, CreateDto, UpdateDto> extends IService<T, CreateDto, UpdateDto> {
    /**
     * Create multiple entities
     */
    createMany(dtos: CreateDto[], options: ServiceOptions): Promise<T[]>;

    /**
     * Update multiple entities
     */
    updateMany(updates: Array<{ id: UUID; dto: UpdateDto }>, options: ServiceOptions): Promise<T[]>;

    /**
     * Delete multiple entities
     */
    deleteMany(ids: UUID[], options: ServiceOptions): Promise<number>;

    /**
     * Restore a deleted entity
     */
    restore(id: UUID, options: ServiceOptions): Promise<T>;
}

/**
 * Searchable service interface
 */
export interface ISearchableService<T extends IEntity> {
    /**
     * Search entities by query string
     */
    search(query: string, params: PaginationParams, context: ServiceContext): Promise<PaginatedResult<T>>;

    /**
     * Get search suggestions
     */
    getSuggestions(query: string, limit: number, context: ServiceContext): Promise<string[]>;
}

/**
 * Exportable service interface
 */
export interface IExportableService {
    /**
     * Export entities to specified format
     */
    export(
        format: 'csv' | 'xlsx' | 'pdf',
        params: PaginationParams,
        context: ServiceContext,
    ): Promise<Uint8Array>;

    /**
     * Import entities from file
     */
    import(
        file: Uint8Array,
        format: 'csv' | 'xlsx',
        options: ServiceOptions,
    ): Promise<{ imported: number; failed: number; errors: string[] }>;
}
