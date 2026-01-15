import { BadRequestException } from '@nestjs/common';

export class StockInsufficientException extends BadRequestException {
  constructor(
    public readonly variantId: string,
    public readonly available: number,
    public readonly required: number,
    public readonly warehouseId: string,
  ) {
    super({
      error: 'STOCK_INSUFFICIENT',
      message: `Stock insuficiente. Disponible: ${available}, Requerido: ${required}`,
      details: {
        variantId,
        available,
        required,
        missing: required - available,
        warehouseId,
      },
    });
  }
}
