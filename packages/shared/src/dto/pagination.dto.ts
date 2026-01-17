/**
 * Pagination DTOs
 * Standard pagination request and response types.
 */

/**
 * Pagination request parameters
 */
export interface PaginationRequestDto {
    page?: number;
    limit?: number;
    sortBy?: string;
    sortOrder?: 'asc' | 'desc';
    search?: string;
}

/**
 * Default pagination values
 */
export const PAGINATION_DEFAULTS = {
    page: 1,
    limit: 20,
    maxLimit: 100,
    sortOrder: 'desc' as const,
};

/**
 * Pagination metadata in response
 */
export interface PaginationMetaDto {
    currentPage: number;
    itemsPerPage: number;
    totalItems: number;
    totalPages: number;
    hasNextPage: boolean;
    hasPreviousPage: boolean;
}

/**
 * Paginated response wrapper
 */
export interface PaginatedResponseDto<T> {
    items: T[];
    meta: PaginationMetaDto;
}

/**
 * Create pagination metadata from query results
 */
export function createPaginationMeta(
    page: number,
    limit: number,
    totalItems: number,
): PaginationMetaDto {
    const totalPages = Math.ceil(totalItems / limit);
    return {
        currentPage: page,
        itemsPerPage: limit,
        totalItems,
        totalPages,
        hasNextPage: page < totalPages,
        hasPreviousPage: page > 1,
    };
}

/**
 * Create a paginated response
 */
export function createPaginatedResponse<T>(
    items: T[],
    page: number,
    limit: number,
    totalItems: number,
): PaginatedResponseDto<T> {
    return {
        items,
        meta: createPaginationMeta(page, limit, totalItems),
    };
}

/**
 * Calculate skip value for database query
 */
export function calculateSkip(page: number, limit: number): number {
    return (page - 1) * limit;
}

/**
 * Normalize pagination params with defaults
 */
export function normalizePaginationParams(params: PaginationRequestDto): Required<PaginationRequestDto> {
    return {
        page: Math.max(1, params.page || PAGINATION_DEFAULTS.page),
        limit: Math.min(
            PAGINATION_DEFAULTS.maxLimit,
            Math.max(1, params.limit || PAGINATION_DEFAULTS.limit),
        ),
        sortBy: params.sortBy || 'createdAt',
        sortOrder: params.sortOrder || PAGINATION_DEFAULTS.sortOrder,
        search: params.search || '',
    };
}
