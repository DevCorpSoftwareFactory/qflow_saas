import {
    Entity,
    Column,
    Index,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsNumber, IsInt, IsEmail, Min } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * Customer - Business customers
 * 
 * Controls customer type for price lists (retail/wholesale/vip).
 * 
 * @table customers
 */
@Entity('customers')
@Index(['tenantId', 'code'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'customerType'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class Customer extends TenantBaseEntity {
    /** Internal customer code */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    code: string;

    /** Customer type: retail, wholesale, vip */
    @Column({ name: 'customer_type', type: 'varchar', length: 20 })
    @IsString()
    customerType: string;

    /** Full name */
    @Column({ name: 'full_name', type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    fullName: string;

    /** Trade name (for wholesalers) */
    @Column({ name: 'trade_name', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    tradeName?: string;

    /** Tax ID */
    @Column({ name: 'tax_id', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    taxId?: string;

    /** Document type: CC, NIT, CE, PASAPORTE */
    @Column({ name: 'document_type', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    documentType?: string;

    /** Document number */
    @Column({ name: 'document_number', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    documentNumber?: string;

    /** Email */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsEmail()
    email?: string;

    /** Phone */
    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    phone?: string;

    /** WhatsApp */
    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    whatsapp?: string;

    /** Address */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    address?: string;

    /** City */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    city?: string;

    /** Delivery zone */
    @Column({ name: 'delivery_zone', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    deliveryZone?: string;

    /** Credit limit */
    @Column({ name: 'credit_limit', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    creditLimit: number;

    /** Credit days */
    @Column({ name: 'credit_days', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    creditDays: number;

    /** Current credit balance */
    @Column({ name: 'current_credit', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    currentCredit: number;

    /** Status: active, suspended, blocked */
    @Column({ type: 'varchar', length: 20, default: 'active' })
    @IsString()
    status: string;

    /** App user ID (if customer has app access) */
    @Column({ name: 'app_user_id', type: 'uuid', nullable: true })
    @IsOptional()
    appUserId?: string;

    /** Approval status: pending, approved, rejected */
    @Column({ name: 'approval_status', type: 'varchar', length: 20, default: 'pending' })
    @IsString()
    approvalStatus: string;

    /** Approved by user ID */
    @Column({ name: 'approved_by', type: 'uuid', nullable: true })
    @IsOptional()
    approvedBy?: string;

    /** Approval timestamp */
    @Column({ name: 'approved_at', type: 'timestamptz', nullable: true })
    approvedAt?: Date;

    /** Total purchases amount */
    @Column({ name: 'total_purchases', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    totalPurchases: number;

    /** Total orders count */
    @Column({ name: 'total_orders', type: 'int', default: 0 })
    @IsInt()
    totalOrders: number;

    /** Last purchase date */
    @Column({ name: 'last_purchase_date', type: 'date', nullable: true })
    lastPurchaseDate?: Date;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;
}
