import {
    Entity,
    Column,
    Index,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * CashRegister - Physical cash registers
 * 
 * @table cash_registers
 */
@Entity('cash_registers')
@Index(['tenantId', 'branchId', 'code'], { unique: true, where: 'deleted_at IS NULL' })
export class CashRegister extends TenantBaseEntity {
    /** Branch ID */
    @Column({ name: 'branch_id', type: 'uuid' })
    branchId: string;

    /** Register code */
    @Column({ type: 'varchar', length: 20 })
    @IsString()
    @MaxLength(20)
    code: string;

    /** Register name */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    name: string;

    /** Printer configuration: { ip, port, model } */
    @Column({ name: 'printer_config', type: 'jsonb', nullable: true })
    printerConfig?: Record<string, any>;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;
}
