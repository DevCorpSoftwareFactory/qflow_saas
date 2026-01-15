import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsEmail, IsIP, IsInt } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * Branch - Physical locations of the tenant's business
 * 
 * Each tenant can have multiple independent branches with separate inventory.
 * 
 * @table branches
 */
@Entity('branches')
@Index(['tenantId', 'code'], { unique: true, where: 'deleted_at IS NULL' })
export class Branch extends TenantBaseEntity {
    /** Internal branch code: SUC-001 */
    @Column({ type: 'varchar', length: 20 })
    @IsString()
    @MaxLength(20)
    code: string;

    /** Branch display name */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    name: string;

    /** Physical address */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    address?: string;

    /** City */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    city?: string;

    /** Region/State */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    region?: string;

    /** Country */
    @Column({ type: 'varchar', length: 100, default: 'Colombia' })
    @IsString()
    country: string;

    /** Postal code */
    @Column({ name: 'postal_code', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    postalCode?: string;

    /** Contact phone */
    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    phone?: string;

    /** Contact email */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsEmail()
    email?: string;

    /** WhatsApp number */
    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    whatsapp?: string;

    /** Manager user ID (FK to users) */
    @Column({ name: 'manager_id', type: 'uuid', nullable: true })
    @IsOptional()
    managerId?: string;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** Main branch flag (headquarters) */
    @Column({ name: 'is_main_branch', type: 'boolean', default: false })
    @IsBoolean()
    isMainBranch: boolean;

    /** POS printer IP address */
    @Column({ name: 'pos_printer_ip', type: 'inet', nullable: true })
    @IsOptional()
    posPrinterIp?: string;

    /** POS printer port (default: 9100) */
    @Column({ name: 'pos_printer_port', type: 'int', default: 9100 })
    @IsOptional()
    @IsInt()
    posPrinterPort: number;

    /** Receipt header text */
    @Column({ name: 'pos_receipt_header', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    posReceiptHeader?: string;

    /** Receipt footer text */
    @Column({ name: 'pos_receipt_footer', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    posReceiptFooter?: string;

    /** Opening time */
    @Column({ name: 'opening_time', type: 'time', nullable: true })
    openingTime?: string;

    /** Closing time */
    @Column({ name: 'closing_time', type: 'time', nullable: true })
    closingTime?: string;
}
