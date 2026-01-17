/**
 * Tenant DTOs
 * Data transfer objects for tenant operations.
 */


/**
 * Create tenant request DTO
 */
export interface CreateTenantDto {
    slug: string;
    companyName: string;
    tradeName?: string;
    taxId: string;
    email: string;
    phone?: string;
    address?: string;
    city?: string;
    region?: string;
    country?: string;
    plan?: string;
    ownerName: string;
    ownerEmail: string;
}

/**
 * Update tenant request DTO
 */
export interface UpdateTenantDto {
    companyName?: string;
    tradeName?: string;
    email?: string;
    phone?: string;
    address?: string;
    city?: string;
    region?: string;
    logoUrl?: string;
    primaryColor?: string;
    primaryContactName?: string;
    primaryContactEmail?: string;
    primaryContactPhone?: string;
}

/**
 * Tenant response DTO
 */
export interface TenantResponseDto {
    id: string;
    slug: string;
    companyName: string;
    tradeName?: string;
    taxId: string;
    email: string;
    phone?: string;
    logoUrl?: string;
    primaryColor?: string;
    plan: string;
    status: string;
    timezone: string;
    currency: string;
    maxBranches: number;
    maxUsers: number;
    currentBranchesCount: number;
    currentUsersCount: number;
    trialEndsAt?: string;
    subscribedAt?: string;
    createdAt: string;
    updatedAt: string;
}

/**
 * Tenant settings update DTO
 */
export interface UpdateTenantSettingsDto {
    ivaRate?: number;
    dateFormat?: string;
    timeFormat?: string;
    decimalPrecision?: number;
    allowNegativeStock?: boolean;
    requireCashSession?: boolean;
    enableBlindCounting?: boolean;
    defaultPriceListId?: string;
    receiptHeader?: string;
    receiptFooter?: string;
    lowStockThreshold?: number;
    emailNotifications?: boolean;
    lowStockAlerts?: boolean;
    dailyReports?: boolean;
    enableFifo?: boolean;
    enableLotTracking?: boolean;
    enableExpirationTracking?: boolean;
}

/**
 * Tenant settings response DTO
 */
export interface TenantSettingsResponseDto {
    id: string;
    tenantId: string;
    ivaRate: number;
    dateFormat: string;
    timeFormat: string;
    decimalPrecision: number;
    allowNegativeStock: boolean;
    requireCashSession: boolean;
    enableBlindCounting: boolean;
    defaultPriceListId?: string;
    receiptHeader?: string;
    receiptFooter?: string;
    lowStockThreshold: number;
    emailNotifications: boolean;
    lowStockAlerts: boolean;
    dailyReports: boolean;
    enableFifo: boolean;
    enableLotTracking: boolean;
    enableExpirationTracking: boolean;
}
