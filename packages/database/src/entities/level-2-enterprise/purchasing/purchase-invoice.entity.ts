import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsOptional, MaxLength, IsNumber, Min, IsUrl } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Supplier } from './supplier.entity';
import { PurchaseOrder } from './purchase-order.entity';

/**
 * PurchaseInvoice - Invoices from suppliers
 * 
 * CRITICAL for traceability - origin of inventory.
 * balance is a generated column: total_amount - paid_amount
 * 
 * @table purchase_invoices
 */
@Entity('purchase_invoices')
@Index(['tenantId', 'supplierId', 'invoiceNumber'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'supplierId'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class PurchaseInvoice extends TenantBaseEntity {
    /** Supplier's invoice number */
    @Column({ name: 'invoice_number', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    invoiceNumber: string;

    /** Purchase order ID (may be null for direct purchases) */
    @Column({ name: 'purchase_order_id', type: 'uuid', nullable: true })
    @IsOptional()
    purchaseOrderId?: string;

    @ManyToOne(() => PurchaseOrder)
    @JoinColumn({ name: 'purchase_order_id' })
    purchaseOrder?: PurchaseOrder;

    /** Supplier ID */
    @Column({ name: 'supplier_id', type: 'uuid' })
    supplierId: string;

    @ManyToOne(() => Supplier)
    @JoinColumn({ name: 'supplier_id' })
    supplier: Supplier;

    /** Branch ID */
    @Column({ name: 'branch_id', type: 'uuid' })
    branchId: string;

    /** Invoice date */
    @Column({ name: 'invoice_date', type: 'date' })
    invoiceDate: Date;

    /** Due date */
    @Column({ name: 'due_date', type: 'date' })
    dueDate: Date;

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

    /** Amount paid */
    @Column({ name: 'paid_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    paidAmount: number;

    /** Balance (generated column: total - paid) */
    @Column({ type: 'decimal', precision: 15, scale: 2, generatedType: 'STORED', asExpression: 'total_amount - paid_amount' })
    balance: number;

    /** Status: pending, partial, paid */
    @Column({ type: 'varchar', length: 20, default: 'pending' })
    @IsString()
    status: string;

    /** PDF URL */
    @Column({ name: 'pdf_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    pdfUrl?: string;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;
}
