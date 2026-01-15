import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    OneToMany,
} from 'typeorm';
import { IsString, IsOptional, MaxLength, IsNumber, Min, IsIn, IsDateString } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Customer } from './customer.entity';
import { OrderItem } from './order-item.entity';
import { Branch } from '../organization/branch.entity';
import { User } from '../organization/user.entity';

export enum OrderStatus {
    REQUESTED = 'requested',
    CONFIRMED = 'confirmed',
    PREPARING = 'preparing',
    READY = 'ready',
    IN_TRANSIT = 'in_transit',
    DELIVERED = 'delivered',
    CANCELLED = 'cancelled',
}

export enum OrderPaymentStatus {
    PENDING = 'pending',
    PARTIAL = 'partial',
    PAID = 'paid',
}

/**
 * Pedidos B2B / Restaurante
 * @table orders
 */
@Entity('orders')
@Index(['tenantId', 'orderNumber'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'customerId'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class Order extends TenantBaseEntity {
    /** Order number */
    @Column({ name: 'order_number', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    orderNumber: string;

    @Column({ name: 'customer_id', type: 'uuid' })
    customerId: string;

    @ManyToOne(() => Customer)
    @JoinColumn({ name: 'customer_id' })
    customer: Customer;

    @Column({ name: 'branch_id', type: 'uuid' })
    branchId: string;

    @ManyToOne(() => Branch)
    @JoinColumn({ name: 'branch_id' })
    branch: Branch;

    @Column({ name: 'order_date', type: 'timestamptz', default: () => 'NOW()' })
    orderDate: Date;

    @Column({ name: 'delivery_date', type: 'date', nullable: true })
    @IsOptional()
    deliveryDate?: Date;

    /** Status */
    @Column({
        type: 'enum',
        enum: OrderStatus,
        default: OrderStatus.REQUESTED
    })
    @IsIn(Object.values(OrderStatus))
    status: OrderStatus;

    // Entrega
    @Column({ name: 'delivery_address', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    deliveryAddress?: string;

    @Column({ name: 'delivery_notes', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    deliveryNotes?: string;

    @Column({ name: 'delivery_zone', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    deliveryZone?: string;

    // Totales
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    subtotal: number;

    @Column({ name: 'shipping_cost', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    shippingCost: number;

    @Column({ name: 'tax_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    taxAmount: number;

    @Column({ name: 'total_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalAmount: number;

    // Pago
    @Column({
        name: 'payment_status',
        type: 'enum',
        enum: OrderPaymentStatus,
        default: OrderPaymentStatus.PENDING
    })
    @IsIn(Object.values(OrderPaymentStatus))
    paymentStatus: OrderPaymentStatus;

    @Column({ name: 'amount_paid', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    amountPaid: number;

    // Vendedor
    @Column({ name: 'sales_rep_id', type: 'uuid', nullable: true })
    @IsOptional()
    salesRepId?: string;

    @ManyToOne(() => User)
    @JoinColumn({ name: 'sales_rep_id' })
    salesRep?: User;

    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    @OneToMany(() => OrderItem, (item) => item.order)
    items: OrderItem[];
}
