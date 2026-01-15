// Level 3: B2B Client Portal Entities
// Re-exporting specific entities safe/relevant for the Client Portal

import {
    // Organization
    Branch,
    // Catalog
    Product, ProductVariant, ProductCategory, Brand, UnitOfMeasure, PriceList, PriceListItem,
    // Sales
    Order, OrderStatus, OrderPaymentStatus, OrderItem, Customer,
    // Support
    SupportTicket, TicketMessage,
    // Base
    BaseEntity, TenantBaseEntity,
    AppDataSource
} from '@qflow/database';

export const initializeDatabase = async () => {
    if (!AppDataSource.isInitialized) {
        await AppDataSource.initialize();
    }
    return AppDataSource;
};

export const getDatabase = async () => {
    if (!AppDataSource.isInitialized) {
        await AppDataSource.initialize();
    }
    return AppDataSource;
};

// Re-export
export {
    Branch,
    Product, ProductVariant, ProductCategory, Brand, UnitOfMeasure, PriceList, PriceListItem,
    Order, OrderStatus, OrderPaymentStatus, OrderItem, Customer,
    SupportTicket, TicketMessage,
    BaseEntity, TenantBaseEntity,
    AppDataSource
};

