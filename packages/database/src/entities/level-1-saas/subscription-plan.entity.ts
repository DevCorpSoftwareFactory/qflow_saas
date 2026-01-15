import {
    Entity,
    Column,
    Index,
    OneToMany,
} from 'typeorm';
import { IsString, IsNumber, IsBoolean, IsOptional, MaxLength, Min } from 'class-validator';
import { BaseEntity } from '../base/base.entity';

/**
 * Subscription Plans - SaaS pricing tiers
 * 
 * Global table (no tenant_id) - Defines available plans for all tenants.
 * Plans: trial, basic, pro, enterprise
 * 
 * @table subscription_plans
 */
@Entity('subscription_plans')
export class SubscriptionPlan extends BaseEntity {
    /** URL-friendly identifier: 'trial', 'basic', 'pro', 'enterprise' */
    @Column({ type: 'varchar', length: 50, unique: true })
    @Index()
    @IsString()
    @MaxLength(50)
    slug: string;

    /** Display name of the plan */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    name: string;

    /** Plan description for marketing */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /** Monthly price in COP */
    @Column({ name: 'monthly_price', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    monthlyPrice: number;

    /** Annual price in COP (typically 10 months) */
    @Column({ name: 'annual_price', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    annualPrice: number;

    /** Currency code (default: COP) */
    @Column({ type: 'varchar', length: 3, default: 'COP' })
    @IsString()
    @MaxLength(3)
    currency: string;

    /** Maximum branches allowed */
    @Column({ name: 'max_branches', type: 'int', default: 1 })
    @IsNumber()
    @Min(1)
    maxBranches: number;

    /** Maximum users allowed */
    @Column({ name: 'max_users', type: 'int', default: 5 })
    @IsNumber()
    @Min(1)
    maxUsers: number;

    /** Maximum storage in GB */
    @Column({ name: 'max_storage_gb', type: 'int', default: 10 })
    @IsNumber()
    @Min(1)
    maxStorageGb: number;

    /** Maximum monthly transactions */
    @Column({ name: 'max_transactions_monthly', type: 'int', default: 1000 })
    @IsNumber()
    @Min(100)
    maxTransactionsMonthly: number;

    /** Feature flags: { api_access: true, support_24h: false } */
    @Column({ type: 'jsonb', default: '[]' })
    features: Record<string, boolean>;

    /** Enabled modules: ["inventory", "pos", "accounting"] */
    @Column({ name: 'enabled_modules', type: 'jsonb', default: '[]' })
    enabledModules: string[];

    /** Trial period in days (0 = no trial) */
    @Column({ name: 'trial_days', type: 'int', default: 0 })
    @IsNumber()
    @Min(0)
    trialDays: number;

    /** Visible in public pricing page */
    @Column({ name: 'is_public', type: 'boolean', default: true })
    @IsBoolean()
    isPublic: boolean;

    /** Display order in pricing page */
    @Column({ name: 'sort_order', type: 'int', default: 0 })
    @IsNumber()
    sortOrder: number;

    /** Active plan (inactive plans can't be purchased) */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;
}
