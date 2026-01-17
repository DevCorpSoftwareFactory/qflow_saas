/**
 * Movement Type Enum
 * Represents the type of inventory movement in the system.
 */
export enum MovementType {
    PURCHASE = 'purchase',
    SALE = 'sale',
    TRANSFER_OUT = 'transfer_out',
    TRANSFER_IN = 'transfer_in',
    ADJUSTMENT = 'adjustment',
    RETURN_CUSTOMER = 'return_customer',
    RETURN_SUPPLIER = 'return_supplier',
    WASTE = 'waste',
    INTERNAL_CONSUMPTION = 'internal_consumption',
}
