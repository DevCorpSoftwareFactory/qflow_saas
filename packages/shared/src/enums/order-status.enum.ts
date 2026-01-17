/**
 * Order Status Enum
 * Represents the lifecycle of an order from request to completion.
 */
export enum OrderStatus {
    REQUESTED = 'requested',
    CONFIRMED = 'confirmed',
    PREPARING = 'preparing',
    READY = 'ready',
    IN_TRANSIT = 'in_transit',
    DELIVERED = 'delivered',
    COMPLETED = 'completed',
    CANCELLED = 'cancelled',
    ISSUE = 'issue',
}
