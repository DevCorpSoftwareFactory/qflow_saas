import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsNumber, IsInt, Min } from 'class-validator';
import { Order } from './order.entity';

/**
 * OrderItem - Order line items
 * 
 * @table order_items
 */
@Entity('order_items')
@Index(['orderId'])
export class OrderItem {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Order ID */
    @Column({ name: 'order_id', type: 'uuid' })
    orderId: string;

    @ManyToOne(() => Order, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'order_id' })
    order: Order;

    /** Variant ID */
    @Column({ name: 'variant_id', type: 'uuid' })
    variantId: string;

    /** Quantity ordered */
    @Column({ type: 'int' })
    @IsInt()
    @Min(1)
    quantity: number;

    /** Unit price at order time */
    @Column({ name: 'unit_price', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    unitPrice: number;

    /** Subtotal */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    subtotal: number;

    /** Quantity delivered (for partial deliveries) */
    @Column({ name: 'quantity_delivered', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    quantityDelivered: number;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
