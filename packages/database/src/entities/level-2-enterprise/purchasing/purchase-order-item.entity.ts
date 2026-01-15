import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, IsInt, Min } from 'class-validator';
import { PurchaseOrder } from './purchase-order.entity';

/**
 * PurchaseOrderItem - Line items for purchase orders
 * 
 * @table purchase_order_items
 */
@Entity('purchase_order_items')
@Index(['purchaseOrderId'])
@Index(['tenantId', 'variantId'])
export class PurchaseOrderItem {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Purchase order ID */
    @Column({ name: 'purchase_order_id', type: 'uuid' })
    purchaseOrderId: string;

    @ManyToOne(() => PurchaseOrder, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'purchase_order_id' })
    purchaseOrder: PurchaseOrder;

    /** Variant ID */
    @Column({ name: 'variant_id', type: 'uuid' })
    variantId: string;

    /** Quantity ordered */
    @Column({ name: 'quantity_ordered', type: 'int' })
    @IsInt()
    @Min(1)
    quantityOrdered: number;

    /** Quantity received (for partial receipts) */
    @Column({ name: 'quantity_received', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    quantityReceived: number;

    /** Unit price */
    @Column({ name: 'unit_price', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    unitPrice: number;

    /** Discount percent */
    @Column({ name: 'discount_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    discountPercent: number;

    /** Subtotal */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    subtotal: number;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;
}
