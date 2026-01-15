import {
    Entity,
    Column,
    Index,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, MaxLength } from 'class-validator';

/**
 * AuditLog - Global audit log
 * 
 * Records all important changes.
 * tenant_id can be NULL for global SaaS actions.
 * 
 * @table audit_logs
 */
@Entity('audit_logs')
@Index(['tenantId', 'entityType', 'entityId'], { where: 'tenant_id IS NOT NULL' })
@Index(['userId'])
@Index(['createdAt'])
@Index(['action', 'entityType'])
export class AuditLog {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    /** Tenant ID (null for global actions) */
    @Column({ name: 'tenant_id', type: 'uuid', nullable: true })
    tenantId?: string;

    /** User ID */
    @Column({ name: 'user_id', type: 'uuid', nullable: true })
    userId?: string;

    /** User email (for history) */
    @Column({ name: 'user_email', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    userEmail?: string;

    /** Action: create, update, delete, login, logout, approve, reject */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    action: string;

    /** Entity type: product, sale, customer, etc. */
    @Column({ name: 'entity_type', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    entityType: string;

    /** Entity ID */
    @Column({ name: 'entity_id', type: 'uuid', nullable: true })
    @IsOptional()
    entityId?: string;

    /** Value before change (null for create) */
    @Column({ name: 'old_value', type: 'jsonb', nullable: true })
    oldValue?: Record<string, any>;

    /** Value after change (null for delete) */
    @Column({ name: 'new_value', type: 'jsonb', nullable: true })
    newValue?: Record<string, any>;

    /** IP address */
    @Column({ name: 'ip_address', type: 'inet', nullable: true })
    @IsOptional()
    ipAddress?: string;

    /** User agent */
    @Column({ name: 'user_agent', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    userAgent?: string;

    /** Device info: { platform, app_version } */
    @Column({ name: 'device_info', type: 'jsonb', nullable: true })
    deviceInfo?: Record<string, any>;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
