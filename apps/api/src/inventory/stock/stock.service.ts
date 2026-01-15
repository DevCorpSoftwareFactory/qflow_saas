import { Injectable, Logger } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { ProductVariant, InventoryLot } from '@qflow/database';
import { StockInsufficientException } from '../exceptions/stock-insufficient.exception';

@Injectable()
export class StockService {
  private readonly logger = new Logger(StockService.name);

  constructor(
    @InjectRepository(InventoryLot)
    private readonly lotRepository: Repository<InventoryLot>,
    @InjectRepository(ProductVariant)
    private readonly variantRepository: Repository<ProductVariant>,
  ) {}

  /**
   * Verificar disponibilidad de stock (REGLA INMUTABLE).
   * Si no hay suficiente stock, lanza excepción.
   */
  async checkAvailability(
    variantId: string,
    branchId: string,
    quantity: number,
  ): Promise<boolean> {
    // 1. Validar tipo de producto (Optimización: Cachear esto o usar query builder con join)
    const variant = await this.variantRepository.findOne({
      where: { id: variantId },
      relations: ['product'],
      select: {
        id: true,
        product: {
          id: true,
          trackInventory: true,
        },
      },
    });

    if (!variant) {
      // Si no existe, bloqueamos por seguridad (o lanzamos NotFound)
      throw new StockInsufficientException(variantId, 0, quantity, branchId);
    }

    // Si NO controla inventario (Servicio), NO validar stock
    if (!variant.product.trackInventory) {
      return true;
    }

    // 2. Consultar existencias (SUMA de lotes activos)
    // Usamos query builder para sumar
    const { total } = (await this.lotRepository
      .createQueryBuilder('lot')
      .select('SUM(lot.current_quantity)', 'total')
      .where('lot.variant_id = :variantId', { variantId })
      .andWhere('lot.branch_id = :branchId', { branchId })
      .andWhere('lot.status = :status', { status: 'active' }) // Solo lotes activos
      .getRawOne()) as { total: string | number | null };

    const available = Number(total || 0);

    // 3. Comparación Estricta
    if (available < quantity) {
      this.logger.warn(
        `Stock Insufficient: Variant ${variantId}, Branch ${branchId}, Req ${quantity}, Avail ${available}`,
      );
      throw new StockInsufficientException(
        variantId,
        available,
        quantity,
        branchId,
      );
    }

    return true;
  }
}
