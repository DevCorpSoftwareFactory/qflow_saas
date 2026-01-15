import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsNumber, IsInt, Min, IsUUID } from 'class-validator';
import { Sale } from './sale.entity';
import { InventoryLot } from '../inventory/inventory-lot.entity';
import { ProductVariant } from '../catalog/product-variant.entity';

/**
 * Detalle de venta. unit_price es INMUTABLE (precio histórico al momento de venta)
 * @table sales_details
 */
@Entity('sales_details')
@Index(['saleId'])
@Index(['tenantId', 'lotId'])
@Index(['tenantId', 'variantId'])
export class SaleDetail {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @Column({ name: 'sale_id', type: 'uuid' })
    @IsUUID()
    saleId: string;

    @ManyToOne(() => Sale, (sale) => sale.details, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'sale_id' })
    sale: Sale;

    /** Qué lote se consumió */
    @Column({ name: 'lot_id', type: 'uuid' })
    @IsUUID()
    lotId: string;

    @ManyToOne(() => InventoryLot)
    @JoinColumn({ name: 'lot_id' })
    lot: InventoryLot;

    @Column({ name: 'variant_id', type: 'uuid' })
    @IsUUID()
    variantId: string;

    @ManyToOne(() => ProductVariant)
    @JoinColumn({ name: 'variant_id' })
    variant: ProductVariant;

    /** 
     * Cantidad
     * @validation CHECK (quantity > 0)
     */
    @Column({ type: 'int' })
    @IsInt()
    @Min(1)
    quantity: number;

    /** 
     * Precio de venta GUARDADO. No cambia aunque el precio del producto suba
     * INMUTABLE
     */
    @Column({ name: 'unit_price', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    unitPrice: number;

    /** Costo del lote al momento de venta. Usar para margen bruto */
    @Column({ name: 'cost_price', type: 'decimal', precision: 15, scale: 2, nullable: true })
    @IsNumber()
    costPrice?: number;

    // Descuentos
    @Column({ name: 'discount_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    discountPercent: number;

    @Column({ name: 'discount_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    discountAmount: number;

    // Cálculos
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    subtotal: number;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
