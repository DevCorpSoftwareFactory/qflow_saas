import {
    Entity,
    Column,
    Index,
    OneToMany,
} from 'typeorm';
import { IsString, IsEmail, IsOptional, IsBoolean, IsNumber, MaxLength, IsUrl } from 'class-validator';
import { BaseEntity } from '../base/base.entity';

/**
 * Tenant - Enterprise customers of the SaaS
 * 
 * Global table (no tenant_id) - Each row is a business customer.
 * Example: Quesera D&G (tenant_id = 'abc123...')
 * 
 * @table tenants
 */
@Entity('tenants')
export class Tenant extends BaseEntity {
    /** URL-friendly identifier: 'queseria-dg' */
    @Column({ type: 'varchar', length: 50, unique: true })
    @Index()
    @IsString()
    @MaxLength(50)
    slug: string;

    /** Legal company name (razón social) */
    @Column({ name: 'company_name', type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    companyName: string;

    /** Trade name (nombre comercial) */
    @Column({ name: 'trade_name', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    @MaxLength(200)
    tradeName?: string;

    /** Tax ID (NIT in Colombia) */
    @Column({ name: 'tax_id', type: 'varchar', length: 50, unique: true })
    @Index()
    @IsString()
    @MaxLength(50)
    taxId: string;

    /** Primary contact email */
    @Column({ type: 'varchar', length: 100 })
    @IsEmail()
    @MaxLength(100)
    email: string;

    /** Contact phone */
    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    phone?: string;

    /** Company website */
    @Column({ type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsUrl()
    website?: string;

    /** Legal address */
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

    /** Country (default: Colombia) */
    @Column({ type: 'varchar', length: 100, default: 'Colombia' })
    @IsString()
    country: string;

    /** Logo URL in Supabase Storage */
    @Column({ name: 'logo_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    logoUrl?: string;

    /** Hex color for branding: #FF5733 */
    @Column({ name: 'primary_color', type: 'varchar', length: 7, nullable: true })
    @IsOptional()
    @IsString()
    primaryColor?: string;

    /** Current plan slug: trial, basic, pro, enterprise */
    @Column({ type: 'varchar', length: 50, default: 'trial' })
    @Index()
    @IsString()
    plan: string;

    /** Status: active, suspended, cancelled, churned */
    @Column({ type: 'varchar', length: 20, default: 'active' })
    @Index()
    @IsString()
    status: string;

    /** Max branches (denormalized from plan) */
    @Column({ name: 'max_branches', type: 'int', default: 1 })
    @IsNumber()
    maxBranches: number;

    /** Max users (denormalized from plan) */
    @Column({ name: 'max_users', type: 'int', default: 5 })
    @IsNumber()
    maxUsers: number;

    /** Max storage GB (denormalized from plan) */
    @Column({ name: 'max_storage_gb', type: 'int', default: 10 })
    @IsNumber()
    maxStorageGb: number;

    /** Max monthly transactions (denormalized from plan) */
    @Column({ name: 'max_transactions_monthly', type: 'int', default: 1000 })
    @IsNumber()
    maxTransactionsMonthly: number;

    /** Timezone: America/Bogota */
    @Column({ type: 'varchar', length: 50, default: 'America/Bogota' })
    @IsString()
    timezone: string;

    /** Currency code: COP */
    @Column({ type: 'varchar', length: 3, default: 'COP' })
    @IsString()
    currency: string;

    /** Language code: es */
    @Column({ type: 'varchar', length: 10, default: 'es' })
    @IsString()
    language: string;

    /** Current branches count (denormalized) */
    @Column({ name: 'current_branches_count', type: 'int', default: 0 })
    currentBranchesCount: number;

    /** Current users count (denormalized) */
    @Column({ name: 'current_users_count', type: 'int', default: 0 })
    currentUsersCount: number;

    /** Trial end date */
    @Column({ name: 'trial_ends_at', type: 'timestamptz', nullable: true })
    trialEndsAt?: Date;

    /** Subscription start date */
    @Column({ name: 'subscribed_at', type: 'timestamptz', nullable: true })
    subscribedAt?: Date;

    /** Last activity timestamp */
    @Column({ name: 'last_activity_at', type: 'timestamptz', nullable: true })
    lastActivityAt?: Date;

    /** Onboarding completion date */
    @Column({ name: 'onboarded_at', type: 'timestamptz', nullable: true })
    onboardedAt?: Date;

    /** Onboarding completed flag */
    @Column({ name: 'onboarding_completed', type: 'boolean', default: false })
    @IsBoolean()
    onboardingCompleted: boolean;

    /** Primary contact name */
    @Column({ name: 'primary_contact_name', type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    primaryContactName?: string;

    /** Primary contact email */
    @Column({ name: 'primary_contact_email', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsEmail()
    primaryContactEmail?: string;

    /** Primary contact phone */
    @Column({ name: 'primary_contact_phone', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    primaryContactPhone?: string;
}
