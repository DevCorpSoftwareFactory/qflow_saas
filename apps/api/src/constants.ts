/**
 * Application Constants for QFlow Pro API
 */

// API Version
export const API_VERSION = 'v1';
export const API_PREFIX = 'api';

// Application
export const APP_NAME = 'QFlow Pro';
export const APP_DESCRIPTION = 'ERP SaaS Multi-Tenant para gestión de inventario, ventas y operaciones';

// Pagination
export const DEFAULT_PAGE_SIZE = 20;
export const MAX_PAGE_SIZE = 100;

// Cache TTL (seconds)
export const CACHE_TTL = {
    SHORT: 60, // 1 minute
    MEDIUM: 300, // 5 minutes
    LONG: 3600, // 1 hour
    DAY: 86400, // 1 day
};

// Rate Limiting
export const RATE_LIMIT = {
    WINDOW_MS: 60 * 1000, // 1 minute
    MAX_REQUESTS: 100,
};

// File Upload
export const FILE_UPLOAD = {
    MAX_SIZE: 5 * 1024 * 1024, // 5MB
    ALLOWED_MIME_TYPES: ['image/jpeg', 'image/png', 'image/webp', 'application/pdf'],
};

// JWT
export const JWT_CONSTANTS = {
    ACCESS_TOKEN_EXPIRES: '15m',
    REFRESH_TOKEN_EXPIRES: '7d',
};

// Roles
export const ROLES = {
    SUPER_ADMIN: 'super_admin',
    TENANT_ADMIN: 'tenant_admin',
    MANAGER: 'manager',
    CASHIER: 'cashier',
    WAREHOUSE: 'warehouse',
    VIEWER: 'viewer',
} as const;

export type Role = (typeof ROLES)[keyof typeof ROLES];

// Permissions
export const PERMISSIONS = {
    // Users
    USERS_READ: 'users:read',
    USERS_WRITE: 'users:write',
    USERS_DELETE: 'users:delete',

    // Products
    PRODUCTS_READ: 'products:read',
    PRODUCTS_WRITE: 'products:write',
    PRODUCTS_DELETE: 'products:delete',

    // Inventory
    INVENTORY_READ: 'inventory:read',
    INVENTORY_WRITE: 'inventory:write',
    INVENTORY_ADJUST: 'inventory:adjust',

    // Sales
    SALES_READ: 'sales:read',
    SALES_WRITE: 'sales:write',
    SALES_VOID: 'sales:void',

    // Cash Sessions
    CASH_READ: 'cash:read',
    CASH_OPEN: 'cash:open',
    CASH_CLOSE: 'cash:close',
    CASH_APPROVE: 'cash:approve',

    // Reports
    REPORTS_READ: 'reports:read',
    REPORTS_EXPORT: 'reports:export',
} as const;

export type Permission = (typeof PERMISSIONS)[keyof typeof PERMISSIONS];
