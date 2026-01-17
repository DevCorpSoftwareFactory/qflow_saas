import {
    Entity,
    Column,
    OneToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsNumber, IsBoolean, IsOptional, Min, Max } from 'class-validator';
import { BaseEntity } from '../base/base.entity';
import { Tenant } from './tenant.entity';

/**
 * TenantSettings - Configuration for a tenant
 * 
 * Separated from Tenant for cleaner architecture.
 * Contains business configuration, tax rates, and operational settings.
 * 
 * @table tenant_settings
 */
@Entity('tenant_settings')
export class TenantSettings extends BaseEntity {
    /** Tenant ID (OneToOne with Tenant) */
    @Column({ name: 'tenant_id', type: 'uuid', unique: true })
    tenantId: string;

    @OneToOne(() => Tenant)
    @JoinColumn({ name: 'tenant_id' })
    tenant: Tenant;

    /** IVA rate (default 19% for Colombia) */
    @Column({ name: 'iva_rate', type: 'decimal', precision: 5, scale: 4, default: 0.19 })
    @IsNumber()
    @Min(0)
    @Max(1)
    ivaRate: number;

    /** Date format: 'DD/MM/YYYY', 'YYYY-MM-DD', 'MM/DD/YYYY' */
    @Column({ name: 'date_format', type: 'varchar', length: 20, default: 'DD/MM/YYYY' })
    @IsString()
    dateFormat: string;

    /** Time format: '12h', '24h' */
    @Column({ name: 'time_format', type: 'varchar', length: 5, default: '24h' })
    @IsString()
    timeFormat: string;

    /** Decimal precision for quantities */
    @Column({ name: 'decimal_precision', type: 'int', default: 2 })
    @IsNumber()
    @Min(0)
    @Max(6)
    decimalPrecision: number;

    /** Allow negative stock levels */
    @Column({ name: 'allow_negative_stock', type: 'boolean', default: false })
    @IsBoolean()
    allowNegativeStock: boolean;

    /** Require cash session to be open for POS sales */
    @Column({ name: 'require_cash_session', type: 'boolean', default: true })
    @IsBoolean()
    requireCashSession: boolean;

    /** Enable blind counting for cash sessions */
    @Column({ name: 'enable_blind_counting', type: 'boolean', default: true })
    @IsBoolean()
    enableBlindCounting: boolean;

    /** Default price list ID */
    @Column({ name: 'default_price_list_id', type: 'uuid', nullable: true })
    @IsOptional()
    defaultPriceListId?: string;

    /** Receipt header text */
    @Column({ name: 'receipt_header', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    receiptHeader?: string;

    /** Receipt footer text */
    @Column({ name: 'receipt_footer', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    receiptFooter?: string;

    /** Low stock threshold (percentage) */
    @Column({ name: 'low_stock_threshold', type: 'int', default: 10 })
    @IsNumber()
    @Min(0)
    lowStockThreshold: number;

    /** Enable email notifications */
    @Column({ name: 'email_notifications', type: 'boolean', default: true })
    @IsBoolean()
    emailNotifications: boolean;

    /** Enable low stock alerts */
    @Column({ name: 'low_stock_alerts', type: 'boolean', default: true })
    @IsBoolean()
    lowStockAlerts: boolean;

    /** Enable daily reports */
    @Column({ name: 'daily_reports', type: 'boolean', default: false })
    @IsBoolean()
    dailyReports: boolean;

    /** FIFO enforcement for inventory */
    @Column({ name: 'enable_fifo', type: 'boolean', default: true })
    @IsBoolean()
    enableFifo: boolean;

    /** Lot tracking enabled */
    @Column({ name: 'enable_lot_tracking', type: 'boolean', default: true })
    @IsBoolean()
    enableLotTracking: boolean;

    /** Expiration tracking enabled */
    @Column({ name: 'enable_expiration_tracking', type: 'boolean', default: true })
    @IsBoolean()
    enableExpirationTracking: boolean;
}
