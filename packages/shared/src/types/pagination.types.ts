/**
 * Pagination Types
 * Types for paginated API responses.
 */

import { DateTime } from './common.types';

/**
 * Pagination request parameters
 */
export interface PaginationParams {
    page?: number;
    limit?: number;
    sortBy?: string;
    sortOrder?: 'asc' | 'desc';
    search?: string;
}

/**
 * Pagination metadata in response
 */
export interface PaginationMeta {
    currentPage: number;
    itemsPerPage: number;
    totalItems: number;
    totalPages: number;
    hasNextPage: boolean;
    hasPreviousPage: boolean;
}

/**
 * Paginated result wrapper
 */
export interface PaginatedResult<T> {
    items: T[];
    meta: PaginationMeta;
}

/**
 * Cursor-based pagination params (for infinite scroll)
 */
export interface CursorPaginationParams {
    cursor?: string;
    limit?: number;
    direction?: 'forward' | 'backward';
}

/**
 * Cursor-based pagination result
 */
export interface CursorPaginatedResult<T> {
    items: T[];
    nextCursor?: string;
    previousCursor?: string;
    hasMore: boolean;
}

/**
 * Filter operators for advanced queries
 */
export type FilterOperator = 'eq' | 'ne' | 'gt' | 'gte' | 'lt' | 'lte' | 'like' | 'in' | 'between';

/**
 * Filter condition
 */
export interface FilterCondition {
    field: string;
    operator: FilterOperator;
    value: unknown;
}

/**
 * Date range filter
 */
export interface DateRangeFilter {
    startDate?: DateTime;
    endDate?: DateTime;
}
