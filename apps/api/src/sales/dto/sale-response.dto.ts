import { Sale } from '@qflow/database';

export class SaleResponseDto {
  id: string;
  saleNumber: string;
  totalAmount: number;
  status: string;
  paymentMethod?: string;
  saleDate: Date;
  itemCount: number;

  static fromEntity(sale: Sale): SaleResponseDto {
    const dto = new SaleResponseDto();
    dto.id = sale.id;
    dto.saleNumber = sale.saleNumber || '';
    dto.totalAmount = Number(sale.totalAmount);
    dto.status = sale.status;
    dto.saleDate = sale.saleDate;
    dto.itemCount = sale.details?.length || 0;

    // Map payment method from first payment if available
    if (sale.payments?.length > 0) {
      dto.paymentMethod = sale.payments[0].paymentMethod;
    }

    return dto;
  }
}
