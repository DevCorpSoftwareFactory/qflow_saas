import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    OneToMany,
} from 'typeorm';
import {
    IsString,
    IsBoolean,
    IsOptional,
    MaxLength,
    IsNumber,
    Min,
    IsIn,
} from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Customer } from './customer.entity';
import { SaleDetail } from './sale-detail.entity';
import { SalePayment } from './sale-payment.entity';
import { Branch } from '../organization/branch.entity';
import { User } from '../organization/user.entity';

// Export as string literals for type safety while matching varchar in DB
export enum SaleStatus {
    DRAFT = 'draft',
    COMPLETED = 'completed',
    CANCELLED = 'cancelled',
    RETURNED = 'returned',
}

export enum SaleType {
    RETAIL = 'retail',
    WHOLESALE = 'wholesale',
    ORDER = 'order',
}

/**
 * Encabezado de venta POS
 * Aligned with init.sql schema (uses varchar, not enum types)
 * @table sales
 */
@Entity('sales')
@Index(['tenantId', 'branchId', 'saleDate'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'customerId'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
@Index(['localId'], { where: 'synced = false' })
export class Sale extends TenantBaseEntity {
    /** 
     * Sale number (generated on sync)
     * ID único legible por humanos
     */
    @Column({ name: 'sale_number', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    saleNumber: string;

    @Column({ name: 'branch_id', type: 'uuid' })
    branchId: string;

    @ManyToOne(() => Branch)
    @JoinColumn({ name: 'branch_id' })
    branch: Branch;

    @Column({ name: 'customer_id', type: 'uuid', nullable: true })
    @IsOptional()
    customerId?: string;

    @ManyToOne(() => Customer)
    @JoinColumn({ name: 'customer_id' })
    customer?: Customer;

    @Column({ name: 'sale_date', type: 'timestamptz', default: () => 'NOW()' })
    saleDate: Date;

    /** Tipo de venta: retail=contado mostrador, wholesale=mayorista, order=pedido (varchar in init.sql) */
    @Column({
        name: 'sale_type',
        type: 'varchar',
        length: 20,
        default: 'retail'
    })
    @IsIn(['retail', 'wholesale', 'order'])
    saleType: string;

    /** Status: draft, completed, cancelled, returned (varchar in init.sql) */
    @Column({
        type: 'varchar',
        length: 20,
        default: 'completed'
    })
    @IsIn(['draft', 'completed', 'cancelled', 'returned'])
    status: string;

    // Totales
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    subtotal: number;

    @Column({ name: 'discount_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    discountPercent: number;

    @Column({ name: 'discount_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    discountAmount: number;

    @Column({ name: 'tax_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    taxAmount: number;

    @Column({ name: 'total_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalAmount: number;

    // Usuario
    @Column({ name: 'cashier_id', type: 'uuid', nullable: true })
    @IsOptional()
    cashierId?: string;

    @ManyToOne(() => User)
    @JoinColumn({ name: 'cashier_id' })
    cashier?: User;

    // Offline sync
    @Column({ name: 'local_id', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    localId?: string;

    @Column({ type: 'boolean', default: false })
    @IsBoolean()
    synced: boolean;

    @Column({ name: 'synced_at', type: 'timestamptz', nullable: true })
    syncedAt?: Date;

    // Notas
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    @Column({ name: 'internal_notes', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    internalNotes?: string;

    // Relaciones inversas
    @OneToMany(() => SaleDetail, (detail) => detail.sale)
    details: SaleDetail[];

    @OneToMany(() => SalePayment, (payment) => payment.sale)
    payments: SalePayment[];
}
