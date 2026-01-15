import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsIP } from 'class-validator';
import { BaseEntity } from '../base/base.entity';
import { Tenant } from './tenant.entity';
import { SubscriptionPlan } from './subscription-plan.entity';

/**
 * License - SaaS license for each tenant
 * 
 * Global table (no tenant_id) - Controls access and limits.
 * Format: QFLOW-XXXX-XXXX-XXXX-XXXX
 * 
 * @table licenses
 */
@Entity('licenses')
export class License extends BaseEntity {
    /** License key: QFLOW-XXXX-XXXX-XXXX-XXXX */
    @Column({ name: 'license_key', type: 'varchar', length: 100, unique: true })
    @Index()
    @IsString()
    @MaxLength(100)
    licenseKey: string;

    /** Tenant this license belongs to */
    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @ManyToOne(() => Tenant, { onDelete: 'RESTRICT' })
    @JoinColumn({ name: 'tenant_id' })
    tenant: Tenant;

    /** Subscription plan */
    @Column({ name: 'plan_id', type: 'uuid' })
    planId: string;

    @ManyToOne(() => SubscriptionPlan)
    @JoinColumn({ name: 'plan_id' })
    plan: SubscriptionPlan;

    /** Type: trial, commercial, demo, internal, partner */
    @Column({ type: 'varchar', length: 20, default: 'commercial' })
    @IsString()
    type: string;

    /** Status: pending, active, expired, suspended, cancelled, revoked */
    @Column({ type: 'varchar', length: 20, default: 'pending' })
    @Index()
    @IsString()
    status: string;

    /** Current billing period start */
    @Column({ name: 'current_period_start', type: 'date' })
    currentPeriodStart: Date;

    /** Current billing period end (license expiry) */
    @Column({ name: 'current_period_end', type: 'date' })
    @Index()
    currentPeriodEnd: Date;

    /** Auto-renew enabled */
    @Column({ name: 'auto_renew', type: 'boolean', default: true })
    @IsBoolean()
    autoRenew: boolean;

    /** Next renewal date */
    @Column({ name: 'renews_at', type: 'timestamptz', nullable: true })
    renewsAt?: Date;

    /** Activation timestamp */
    @Column({ name: 'activated_at', type: 'timestamptz', nullable: true })
    activatedAt?: Date;

    /** IP address used for activation */
    @Column({ name: 'activated_from_ip', type: 'inet', nullable: true })
    @IsOptional()
    activatedFromIp?: string;

    /** API token for integrations */
    @Column({ name: 'api_token', type: 'varchar', length: 255, nullable: true, unique: true })
    @IsOptional()
    @IsString()
    apiToken?: string;

    /** API token expiration */
    @Column({ name: 'api_token_expires_at', type: 'timestamptz', nullable: true })
    apiTokenExpiresAt?: Date;
}
