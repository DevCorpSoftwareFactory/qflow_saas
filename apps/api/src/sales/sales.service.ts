import {
  Injectable,
  Logger,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { DataSource, EntityManager } from 'typeorm';
import {
  Sale,
  SaleDetail,
  InventoryLot,
  InventoryMovement,
  CashMovement,
  ProductVariant,
  SalePayment,
} from '@qflow/database';
import { StockService } from '../inventory/stock/stock.service';
import { CreateSaleDto, SaleItemDto } from './dto';

@Injectable()
export class SalesService {
  private readonly logger = new Logger(SalesService.name);

  constructor(
    private readonly dataSource: DataSource,
    private readonly stockService: StockService,
  ) {}

  /**
   * Register a sale with full ACID transaction guarantees.
   * All steps execute atomically - any failure triggers complete rollback.
   */
  async createSale(dto: CreateSaleDto, tenantId: string): Promise<Sale> {
    this.logger.log(`Starting sale registration for tenant ${tenantId}`);

    return this.dataSource.transaction(
      'SERIALIZABLE',
      async (manager: EntityManager) => {
        // Step 1: Validate stock for ALL items before any DB writes
        await this.validateAllItems(dto.items, dto.branchId);

        // Step 2: Calculate totals
        const { subtotal, taxAmount, totalAmount } = this.calculateTotals(dto);

        // Step 3: Create Sale header
        const sale = manager.create(Sale, {
          tenantId,
          saleNumber:
            dto.saleNumber ||
            `SALE-${Date.now()}-${Math.floor(Math.random() * 1000)}`,
          branchId: dto.branchId,
          customerId: dto.customerId,
          cashierId: dto.cashierId,
          subtotal,
          taxAmount,
          discountAmount: dto.discountAmount || 0,
          totalAmount,
          status: 'completed',
          saleType: 'retail',
          saleDate: dto.saleDate ? new Date(dto.saleDate) : new Date(),
        });
        await manager.save(sale);
        this.logger.log(`Sale header created: ${sale.id}`);

        // Step 4: Create SaleDetails + Update Inventory (locked)
        for (const item of dto.items) {
          await this.processSaleItem(
            manager,
            sale,
            item,
            dto.branchId,
            tenantId,
          );
        }

        // Step 5: Create CashMovement
        await this.createCashMovement(manager, sale, dto, tenantId);

        this.logger.log(`Sale ${sale.id} completed successfully`);

        // Reload sale with all relations to return complete data
        return (await manager.findOne(Sale, {
          where: { id: sale.id },
          relations: ['details', 'payments'],
        }))!;
      },
    );
  }

  /**
   * Validate stock availability for all items.
   * Throws immediately if any item lacks stock.
   */
  private async validateAllItems(
    items: SaleItemDto[],
    branchId: string,
  ): Promise<void> {
    for (const item of items) {
      await this.stockService.checkAvailability(
        item.variantId,
        branchId,
        item.quantity,
      );
    }
    this.logger.log('All items validated for stock availability');
  }

  /**
   * Calculate sale totals.
   */
  private calculateTotals(dto: CreateSaleDto): {
    subtotal: number;
    taxAmount: number;
    totalAmount: number;
  } {
    let subtotal = 0;

    for (const item of dto.items) {
      const itemSubtotal = item.unitPrice * item.quantity;
      const discount = itemSubtotal * ((item.discountPercent || 0) / 100);
      subtotal += itemSubtotal - discount;
    }

    // Assuming 19% IVA for Colombia
    const taxRate = 0.19;
    const taxAmount = subtotal * taxRate;
    const totalAmount = subtotal + taxAmount - (dto.discountAmount || 0);

    return { subtotal, taxAmount, totalAmount };
  }

  /**
   * Process a single sale item: create detail, update lot, create movement.
   * Uses pessimistic locking to prevent race conditions.
   */
  private async processSaleItem(
    manager: EntityManager,
    sale: Sale,
    item: SaleItemDto,
    branchId: string,
    tenantId: string,
  ): Promise<void> {
    // Get variant for cost info
    const variant = await manager.findOne(ProductVariant, {
      where: { id: item.variantId },
    });

    if (!variant) {
      throw new NotFoundException(`Variant ${item.variantId} not found`);
    }

    // Find and LOCK the lot (pessimistic write lock)
    const lot = await manager.findOne(InventoryLot, {
      where: {
        variantId: item.variantId,
        branchId,
        status: 'active',
      },
      lock: { mode: 'pessimistic_write' },
      order: { expiryDate: 'ASC' }, // FIFO by expiry
    });

    if (!lot) {
      throw new BadRequestException(
        `No active lot found for variant ${item.variantId} in branch ${branchId}`,
      );
    }

    // Final stock check under lock
    if (lot.currentQuantity < item.quantity) {
      throw new BadRequestException(
        `Insufficient stock in lot ${lot.id}. Available: ${lot.currentQuantity}, Required: ${item.quantity}`,
      );
    }

    // Create SaleDetail (immutable unit price)
    const itemSubtotal =
      item.unitPrice * item.quantity * (1 - (item.discountPercent || 0) / 100);
    const detail = manager.create(SaleDetail, {
      tenantId,
      saleId: sale.id,
      variantId: item.variantId,
      lotId: lot.id,
      quantity: item.quantity,
      unitPrice: item.unitPrice, // Historical price - IMMUTABLE
      costPrice: lot.unitCost,
      discountPercent: item.discountPercent || 0,
      subtotal: itemSubtotal,
    });
    await manager.save(detail);

    // Create InventoryMovement (Kardex - IMMUTABLE)
    // NOTE: Manual decrement REMOVED because trigger_movement_update_lot handles it.
    const movement = manager.create(InventoryMovement, {
      tenantId,
      branchId,
      variantId: item.variantId,
      lotId: lot.id,
      movementType: 'sale',
      quantity: -item.quantity, // Negative for outbound
      referenceType: 'sale',
      referenceId: sale.id,
      userId: sale.cashierId,
      movementDate: new Date(),
    });
    await manager.save(movement);

    this.logger.log(
      `Processed item ${item.variantId}: qty=${item.quantity}, lot=${lot.id}`,
    );
  }

  /**
   * Create cash movement for the sale.
   */
  private async createCashMovement(
    manager: EntityManager,
    sale: Sale,
    dto: CreateSaleDto,
    tenantId: string,
  ): Promise<void> {
    const cashMovement = manager.create(CashMovement, {
      tenantId,
      branchId: dto.branchId, // Pass branchId from DTO
      cashSessionId: dto.cashSessionId,
      movementType: 'income',
      category: 'sales_cash',
      amount: sale.totalAmount,
      concept: `Venta ${sale.saleNumber || sale.id}`,
      referenceType: 'sale',
      referenceId: sale.id,
    });
    await manager.save(cashMovement);

    // Also create SalePayment record to track valid payments
    const payment = manager.create(SalePayment, {
      tenantId,
      saleId: sale.id,
      paymentMethod: dto.paymentMethod || 'cash',
      amount: sale.totalAmount,
      reference: 'Cash payment',
    });
    await manager.save(payment);
    await manager.save(cashMovement);
    this.logger.log(`Cash movement created for sale ${sale.id}`);
  }
}
