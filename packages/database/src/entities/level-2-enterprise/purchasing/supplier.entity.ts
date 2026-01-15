import {
    Entity,
    Column,
    Index,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsNumber, IsInt, IsEmail, Min, Max, IsUrl } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * Supplier - Product suppliers for the tenant
 * 
 * Includes evaluation metrics (rating, on-time delivery).
 * 
 * @table suppliers
 */
@Entity('suppliers')
@Index(['tenantId', 'code'], { unique: true, where: 'deleted_at IS NULL AND code IS NOT NULL' })
@Index(['tenantId', 'taxId'], { unique: true, where: 'deleted_at IS NULL AND tax_id IS NOT NULL' })
@Index(['tenantId', 'name'], { where: 'deleted_at IS NULL' })
export class Supplier extends TenantBaseEntity {
    /** Internal code */
    @Column({ type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    code?: string;

    /** Legal name */
    @Column({ type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    name: string;

    /** Trade name */
    @Column({ name: 'trade_name', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    tradeName?: string;

    /** Tax ID */
    @Column({ name: 'tax_id', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    taxId?: string;

    /** Contact person name */
    @Column({ name: 'contact_name', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    contactName?: string;

    /** Contact email */
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

    /** Website */
    @Column({ type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsUrl()
    website?: string;

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

    /** Region */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    region?: string;

    /** Country */
    @Column({ type: 'varchar', length: 100, default: 'Colombia' })
    @IsString()
    country: string;

    /** Payment terms in days */
    @Column({ name: 'payment_terms', type: 'int', default: 30 })
    @IsInt()
    paymentTerms: number;

    /** Currency code */
    @Column({ type: 'varchar', length: 3, default: 'COP' })
    @IsString()
    currency: string;

    /** Rating 0-5 stars */
    @Column({ type: 'decimal', precision: 3, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    @Max(5)
    rating: number;

    /** Total orders count */
    @Column({ name: 'total_orders', type: 'int', default: 0 })
    @IsInt()
    totalOrders: number;

    /** On-time delivery percentage */
    @Column({ name: 'on_time_delivery_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    onTimeDeliveryPercent: number;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** Blocked flag */
    @Column({ name: 'is_blocked', type: 'boolean', default: false })
    @IsBoolean()
    isBlocked: boolean;
}
