import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    OneToMany,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    DeleteDateColumn
} from 'typeorm';
import { IsString, IsOptional, MaxLength, IsNumber, IsInt, Min, IsIn, IsUUID } from 'class-validator';
import { ProductVariant } from '../catalog/product-variant.entity';
import { Branch } from '../organization/branch.entity';
import { InventoryMovement } from './inventory-movement.entity';

export enum LotStatus {
    ACTIVE = 'active',
    DEPLETED = 'depleted',
    EXPIRED = 'expired',
    RETURNED = 'returned',
    WASTE = 'waste',
}

/**
 * Lotes de inventario y Stock Actual.
 * CUMPLE REQUISITO: NO usar @UpdateDateColumn (se actualiza por triggers de movimiento).
 * @table inventory_lots
 */
@Entity('inventory_lots')
@Index(['tenantId', 'lotNumber'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'variantId', 'branchId'], { where: "deleted_at IS NULL AND status = 'active'" })
@Index(['tenantId', 'expiryDate'], { where: "deleted_at IS NULL AND status = 'active'" })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class InventoryLot {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Número de lote. Puede ser el del proveedor o generado internamente */
    @Column({ name: 'lot_number', type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    lotNumber: string;

    @Column({ name: 'variant_id', type: 'uuid' })
    @IsUUID()
    variantId: string;

    @ManyToOne(() => ProductVariant)
    @JoinColumn({ name: 'variant_id' })
    variant: ProductVariant;

    @Column({ name: 'purchase_invoice_id', type: 'uuid', nullable: true })
    @IsOptional()
    purchaseInvoiceId?: string;

    @Column({ name: 'branch_id', type: 'uuid' })
    @IsUUID()
    branchId: string;

    @ManyToOne(() => Branch)
    @JoinColumn({ name: 'branch_id' })
    branch: Branch;

    // Cantidades
    /** 
     * Cantidad al recibir el lote
     * @validation CHECK (initial_quantity > 0)
     */
    @Column({ name: 'initial_quantity', type: 'int' })
    @IsInt()
    @Min(1)
    initialQuantity: number;

    /** 
     * Stock actual (actualizado por movimientos/triggers)
     * @validation CHECK (current_quantity >= 0)
     */
    @Column({ name: 'current_quantity', type: 'int' })
    @IsInt()
    @Min(0)
    currentQuantity: number;

    // Precios
    /** 
     * PRECIO TOTAL de compra de este lote (NO precio unitario)
     * @validation CHECK (purchase_price >= 0)
     */
    @Column({ name: 'purchase_price', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    purchasePrice: number;

    /** Costo unitario = purchase_price / initial_quantity. USAR para COGS */
    @Column({
        name: 'unit_cost',
        type: 'decimal',
        precision: 15,
        scale: 2,
        generatedType: 'STORED',
        asExpression: 'CASE WHEN initial_quantity > 0 THEN purchase_price / initial_quantity ELSE 0 END'
    })
    unitCost: number;

    // Fechas críticas
    @Column({ name: 'production_date', type: 'date', nullable: true })
    @IsOptional()
    productionDate?: Date;

    /** Fecha de vencimiento. CRÍTICO para alertas de productos perecederos */
    @Column({ name: 'expiry_date', type: 'date', nullable: true })
    @IsOptional()
    expiryDate?: Date;

    // Estado
    @Column({
        type: 'varchar',
        length: 20,
        default: LotStatus.ACTIVE
    })
    @IsString()
    @IsIn(Object.values(LotStatus))
    status: string;

    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    // Solo Create y Delete - NO UpdateDate
    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @DeleteDateColumn({ name: 'deleted_at', type: 'timestamptz', nullable: true })
    deletedAt?: Date;

    @OneToMany(() => InventoryMovement, (movement) => movement.lot)
    movements: InventoryMovement[];
}

