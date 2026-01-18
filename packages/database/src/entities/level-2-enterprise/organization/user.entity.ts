import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsEmail, IsBoolean, IsOptional, MaxLength, IsInt, Min, Max } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Role } from './role.entity';

/**
 * User - System users who access the ERP
 * 
 * Each user belongs to a tenant and has a role with permissions.
 * Supports 2FA, security PIN for fast POS access, and session management.
 * 
 * @table users
 */
@Entity('users')
@Index(['tenantId', 'email'], { unique: true, where: 'deleted_at IS NULL' })
export class User extends TenantBaseEntity {
    /** Login email (unique per tenant) */
    @Column({ type: 'varchar', length: 100 })
    @IsEmail()
    @MaxLength(100)
    email: string;

    /** Hashed password */
    @Column({ name: 'password_hash', type: 'varchar', length: 255 })
    @IsString()
    passwordHash: string;

    /** Full name */
    @Column({ name: 'full_name', type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    fullName: string;

    @Column({ type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    phone?: string;

    /** Avatar URL */
    @Column({ name: 'avatar_url', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    avatarUrl?: string;

    /** Preferred language */
    @Column({ type: 'varchar', length: 10, default: 'es' })
    @IsOptional()
    @IsString()
    language: string;

    /** Preferred timezone */
    @Column({ type: 'varchar', length: 50, default: 'America/Bogota' })
    @IsOptional()
    @IsString()
    timezone: string;

    /** 4-6 digit PIN for quick POS access */
    @Column({ name: 'pin_security', type: 'varchar', length: 6, nullable: true })
    @IsOptional()
    @IsString()
    pinSecurity?: string;

    /** 2FA enabled flag */
    @Column({ name: 'two_factor_enabled', type: 'boolean', default: false })
    @IsBoolean()
    twoFactorEnabled: boolean;

    /** 2FA secret (encrypted) */
    @Column({ name: 'two_factor_secret', type: 'varchar', length: 255, nullable: true })
    @IsOptional()
    @IsString()
    twoFactorSecret?: string;

    /** Role ID */
    @Column({ name: 'role_id', type: 'uuid' })
    roleId: string;

    @ManyToOne(() => Role)
    @JoinColumn({ name: 'role_id' })
    role: Role;

    /** Array of branch UUIDs the user can access */
    @Column({ name: 'branch_ids', type: 'jsonb', default: '[]' })
    branchIds: string[];

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** Account blocked flag */
    @Column({ name: 'is_blocked', type: 'boolean', default: false })
    @IsBoolean()
    isBlocked: boolean;

    /** Failed login attempts counter */
    @Column({ name: 'failed_login_attempts', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    failedLoginAttempts: number;

    /** Block timestamp */
    @Column({ name: 'blocked_at', type: 'timestamptz', nullable: true })
    blockedAt?: Date;

    /** Last login timestamp */
    @Column({ name: 'last_login_at', type: 'timestamptz', nullable: true })
    lastLoginAt?: Date;

    /** Last login IP address */
    @Column({ name: 'last_login_ip', type: 'inet', nullable: true })
    lastLoginIp?: string;

    /** Current session token */
    @Column({ name: 'session_token', type: 'varchar', length: 255, nullable: true })
    @IsOptional()
    @IsString()
    sessionToken?: string;

    /** Session expiration */
    @Column({ name: 'session_expires_at', type: 'timestamptz', nullable: true })
    sessionExpiresAt?: Date;

    /** Password reset token */
    @Column({ name: 'password_reset_token', type: 'varchar', length: 255, nullable: true })
    @IsOptional()
    @IsString()
    passwordResetToken?: string;

    /** Password reset token expiration */
    @Column({ name: 'password_reset_expires_at', type: 'timestamptz', nullable: true })
    passwordResetExpiresAt?: Date;
}
