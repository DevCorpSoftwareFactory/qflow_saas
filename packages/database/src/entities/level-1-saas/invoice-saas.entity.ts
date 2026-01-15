import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsNumber, IsOptional, MaxLength, Min, IsUrl } from 'class-validator';
import { BaseEntity } from '../base/base.entity';
import { Tenant } from './tenant.entity';

/**
 * InvoiceSaas - Invoices issued by QFlow Pro to tenants
 * 
 * Global table (no tenant_id) - Internal SaaS accounting.
 * Format: NF-2026-00001
 * 
 * @table invoices_saas
 */
@Entity('invoices_saas')
export class InvoiceSaas extends BaseEntity {
    /** Invoice number: NF-2026-00001 */
    @Column({ name: 'invoice_number', type: 'varchar', length: 50, unique: true })
    @Index()
    @IsString()
    @MaxLength(50)
    invoiceNumber: string;

    /** Tenant being billed */
    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @ManyToOne(() => Tenant)
    @JoinColumn({ name: 'tenant_id' })
    tenant: Tenant;

    /** Billing period start date */
    @Column({ name: 'billing_period_start', type: 'date' })
    billingPeriodStart: Date;

    /** Billing period end date */
    @Column({ name: 'billing_period_end', type: 'date' })
    billingPeriodEnd: Date;

    /** Plan name at time of invoice */
    @Column({ name: 'plan_name', type: 'varchar', length: 100 })
    @IsString()
    planName: string;

    /** Base amount before tax */
    @Column({ name: 'base_amount', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    baseAmount: number;

    /** Tax amount (IVA) */
    @Column({ name: 'tax_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    taxAmount: number;

    /** Total amount (base + tax - discount) */
    @Column({ name: 'total_amount', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    totalAmount: number;

    /** Discount percentage */
    @Column({ name: 'discount_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsOptional()
    @IsNumber()
    discountPercent?: number;

    /** Discount amount */
    @Column({ name: 'discount_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsOptional()
    @IsNumber()
    discountAmount?: number;

    /** Status: pending, paid, overdue, cancelled, refunded */
    @Column({ type: 'varchar', length: 20, default: 'pending' })
    @Index()
    @IsString()
    status: string;

    /** Payment due date */
    @Column({ name: 'due_date', type: 'date' })
    @Index()
    dueDate: Date;

    /** Payment timestamp */
    @Column({ name: 'paid_at', type: 'timestamptz', nullable: true })
    paidAt?: Date;

    /** Payment method used */
    @Column({ name: 'payment_method', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    paymentMethod?: string;

    /** Payment reference/transaction ID */
    @Column({ name: 'payment_reference', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    paymentReference?: string;

    /** PDF invoice URL */
    @Column({ name: 'pdf_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    pdfUrl?: string;

    /** Internal notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;
}
