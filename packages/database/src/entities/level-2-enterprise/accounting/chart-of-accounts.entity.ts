import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsInt, Min, Max } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * ChartOfAccounts - Colombian PUC chart of accounts
 * 
 * Hierarchical structure with self-reference.
 * 
 * @table chart_of_accounts
 */
@Entity('chart_of_accounts')
@Index(['tenantId', 'code'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'accountType'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'parentId'], { where: 'deleted_at IS NULL' })
export class ChartOfAccounts extends TenantBaseEntity {
    /** PUC code: 1105, 2105, 4135, etc. */
    @Column({ type: 'varchar', length: 20 })
    @IsString()
    @MaxLength(20)
    code: string;

    /** Account name */
    @Column({ type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    name: string;

    /** Account type: asset, liability, equity, income, expense */
    @Column({ name: 'account_type', type: 'varchar', length: 30 })
    @IsString()
    accountType: string;

    /** Nature: debit or credit */
    @Column({ type: 'varchar', length: 10, nullable: true })
    @IsOptional()
    @IsString()
    nature?: string;

    /** Hierarchy level: 1=Class, 2=Group, 3=Account, 4=Subaccount */
    @Column({ type: 'int', default: 1 })
    @IsInt()
    @Min(1)
    @Max(6)
    level: number;

    /** Parent account ID */
    @Column({ name: 'parent_id', type: 'uuid', nullable: true })
    @IsOptional()
    parentId?: string;

    @ManyToOne(() => ChartOfAccounts)
    @JoinColumn({ name: 'parent_id' })
    parent?: ChartOfAccounts;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** Allows movements */
    @Column({ name: 'allow_movement', type: 'boolean', default: true })
    @IsBoolean()
    allowMovement: boolean;

    /** NIIF code */
    @Column({ name: 'niif_code', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    niifCode?: string;
}
