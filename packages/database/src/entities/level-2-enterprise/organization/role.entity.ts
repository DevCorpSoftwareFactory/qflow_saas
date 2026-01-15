import {
    Entity,
    Column,
    Index,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * Role - User roles with permissions
 * 
 * Includes system roles (owner, admin) that cannot be deleted.
 * Permissions stored as JSONB: { inventory: { read: true, write: true } }
 * 
 * @table roles
 */
@Entity('roles')
@Index(['tenantId', 'name'], { where: 'deleted_at IS NULL' })
export class Role extends TenantBaseEntity {
    /** Role name: owner, admin, supervisor, cashier, accountant */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    name: string;

    /** Role description */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /**
     * Granular permissions as JSONB
     * Structure: { module: { read: bool, write: bool, delete: bool } }
     * Example: { inventory: { read: true, write: true }, pos: { read: true } }
     */
    @Column({ type: 'jsonb', default: '{}' })
    permissions: Record<string, Record<string, boolean>>;

    /** System role flag - cannot be deleted */
    @Column({ name: 'is_system_role', type: 'boolean', default: false })
    @IsBoolean()
    isSystemRole: boolean;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;
}
