import { Sale } from '@qflow/database';

/**
 * Sale Response DTO - aligned with init.sql sales table schema
 */
export class SaleResponseDto {
  id: string;
  saleNumber: string;
  branchId: string;
  customerId?: string;
  saleDate: Date;
  saleType: string;
  status: string;
  subtotal: number;
  discountPercent: number;
  discountAmount: number;
  taxAmount: number;
  totalAmount: number;
  cashierId?: string;
  localId?: string;
  synced: boolean;
  syncedAt?: Date;
  notes?: string;
  internalNotes?: string;
  createdAt: Date;
  updatedAt: Date;

  // Derived
  itemCount: number;
  paymentMethod?: string;

  static fromEntity(sale: Sale): SaleResponseDto {
    const dto = new SaleResponseDto();
    dto.id = sale.id;
    dto.saleNumber = sale.saleNumber || '';
    dto.branchId = sale.branchId;
    dto.customerId = sale.customerId;
    dto.saleDate = sale.saleDate;
    dto.saleType = sale.saleType;
    dto.status = sale.status;
    dto.subtotal = Number(sale.subtotal);
    dto.discountPercent = Number(sale.discountPercent);
    dto.discountAmount = Number(sale.discountAmount);
    dto.taxAmount = Number(sale.taxAmount);
    dto.totalAmount = Number(sale.totalAmount);
    dto.cashierId = sale.cashierId;
    dto.localId = sale.localId;
    dto.synced = sale.synced;
    dto.syncedAt = sale.syncedAt;
    dto.notes = sale.notes;
    dto.internalNotes = sale.internalNotes;
    dto.createdAt = sale.createdAt;
    dto.updatedAt = sale.updatedAt;
    dto.itemCount = sale.details?.length || 0;

    // Map payment method from first payment if available
    if (sale.payments?.length > 0) {
      dto.paymentMethod = sale.payments[0].paymentMethod;
    }

    return dto;
  }
}
