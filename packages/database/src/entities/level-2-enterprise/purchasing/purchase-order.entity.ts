import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsOptional, MaxLength, IsNumber, Min } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Supplier } from './supplier.entity';

/**
 * PurchaseOrder - Orders sent to suppliers
 * 
 * @table purchase_orders
 */
@Entity('purchase_orders')
@Index(['tenantId', 'orderNumber'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'supplierId'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class PurchaseOrder extends TenantBaseEntity {
    /** Order number: PO-2026-00001 */
    @Column({ name: 'order_number', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    orderNumber: string;

    /** Supplier ID */
    @Column({ name: 'supplier_id', type: 'uuid' })
    supplierId: string;

    @ManyToOne(() => Supplier)
    @JoinColumn({ name: 'supplier_id' })
    supplier: Supplier;

    /** Branch ID */
    @Column({ name: 'branch_id', type: 'uuid' })
    branchId: string;

    /** Order date */
    @Column({ name: 'order_date', type: 'date', default: () => 'CURRENT_DATE' })
    orderDate: Date;

    /** Expected delivery date */
    @Column({ name: 'expected_date', type: 'date', nullable: true })
    expectedDate?: Date;

    /** Actual delivered date */
    @Column({ name: 'delivered_date', type: 'date', nullable: true })
    deliveredDate?: Date;

    /** Status: draft, sent, confirmed, partial, received, cancelled */
    @Column({ type: 'varchar', length: 20, default: 'draft' })
    @IsString()
    status: string;

    /** Subtotal */
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    subtotal: number;

    /** Tax amount */
    @Column({ name: 'tax_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    taxAmount: number;

    /** Discount amount */
    @Column({ name: 'discount_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    discountAmount: number;

    /** Total amount */
    @Column({ name: 'total_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalAmount: number;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    /** Internal notes */
    @Column({ name: 'internal_notes', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    internalNotes?: string;

    /** Approved by user ID */
    @Column({ name: 'approved_by', type: 'uuid', nullable: true })
    approvedBy?: string;

    /** Approval timestamp */
    @Column({ name: 'approved_at', type: 'timestamptz', nullable: true })
    approvedAt?: Date;
}
