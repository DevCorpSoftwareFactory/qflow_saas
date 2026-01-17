import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, IsInt, IsBoolean, IsIn, IsUUID } from 'class-validator';
import { InventoryLot } from './inventory-lot.entity';
import { Branch } from '../organization/branch.entity';
import { ProductVariant } from '../catalog/product-variant.entity';
import { User } from '../organization/user.entity';

export enum MovementType {
    PURCHASE = 'purchase',
    SALE = 'sale',
    TRANSFER_OUT = 'transfer_out',
    TRANSFER_IN = 'transfer_in',
    ADJUSTMENT = 'adjustment',
    RETURN_CUSTOMER = 'return_customer',
    RETURN_SUPPLIER = 'return_supplier',
    WASTE = 'waste',
    INTERNAL_CONSUMPTION = 'internal_consumption',
}

/**
 * Kardex de inventario - REGISTRO INMUTABLE de todos los movimientos.
 * PROHIBIDO UPDATE/DELETE - Para corregir, hacer movimiento de ajuste.
 * @table inventory_movements
 */
@Entity('inventory_movements')
@Index(['tenantId', 'lotId', 'movementDate'])
@Index(['tenantId', 'variantId', 'movementDate'])
@Index(['tenantId', 'branchId', 'movementDate'])
@Index(['tenantId', 'referenceType', 'referenceId'])
@Index(['localId'], { where: 'synced = false' })
export class InventoryMovement {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    // Referencia al lote
    @Column({ name: 'lot_id', type: 'uuid' })
    @IsUUID()
    lotId: string;

    @ManyToOne(() => InventoryLot, (lot) => lot.movements)
    @JoinColumn({ name: 'lot_id' })
    lot: InventoryLot;

    @Column({ name: 'branch_id', type: 'uuid' })
    @IsUUID()
    branchId: string;

    @ManyToOne(() => Branch)
    @JoinColumn({ name: 'branch_id' })
    branch: Branch;

    @Column({ name: 'variant_id', type: 'uuid' })
    @IsUUID()
    variantId: string;

    @ManyToOne(() => ProductVariant)
    @JoinColumn({ name: 'variant_id' })
    variant: ProductVariant;

    /** 
     * Tipo de movimiento (varchar in init.sql)
     */
    @Column({
        name: 'movement_type',
        type: 'varchar',
        length: 30,
    })
    @IsString()
    @IsIn(['purchase', 'sale', 'transfer_out', 'transfer_in', 'adjustment', 'return_customer', 'return_supplier', 'waste', 'internal_consumption'])
    movementType: string;

    /** Cantidad: positiva para entradas, negativa para salidas */
    @Column({ type: 'int' })
    @IsInt()
    quantity: number;

    // Referencia a transacción origen
    @Column({ name: 'reference_type', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    referenceType?: string;

    @Column({ name: 'reference_id', type: 'uuid', nullable: true })
    @IsOptional()
    referenceId?: string;

    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    // Costos
    /** Costo unitario al momento del movimiento (para COGS y trazabilidad) */
    @Column({ name: 'unit_cost', type: 'decimal', precision: 15, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    unitCost?: number;

    @Column({ name: 'total_cost', type: 'decimal', precision: 15, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    totalCost?: number;

    // Usuario
    @Column({ name: 'created_by', type: 'uuid', nullable: true })
    @IsOptional()
    createdBy?: string;

    @ManyToOne(() => User)
    @JoinColumn({ name: 'created_by' })
    creator?: User;

    @Column({ name: 'movement_date', type: 'timestamptz', default: () => 'NOW()' })
    movementDate: Date;

    // Sincronización offline
    @Column({ name: 'local_id', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    localId?: string;

    @Column({ type: 'boolean', default: false })
    @IsBoolean()
    synced: boolean;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
