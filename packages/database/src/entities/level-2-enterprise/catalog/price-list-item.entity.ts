import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import {
    IsBoolean,
    IsOptional,
    IsInt,
    IsNumber,
    Min,
    IsUUID,
} from 'class-validator';
import { PriceList } from './price-list.entity';
import { ProductVariant } from './product-variant.entity';

/**
 * Precio de cada variante en cada lista de precios. Permite descuentos por volumen
 * @table price_list_items
 */
@Entity({ name: 'price_list_items' })
@Index('idx_priceitems_tenant_list_variant', ['tenantId', 'priceListId', 'variantId'], { unique: true })
@Index('idx_priceitems_tenant_variant', ['tenantId', 'variantId'])
@Index('idx_priceitems_price', ['price'], { where: 'is_active = true' })
export class PriceListItem {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @IsUUID()
    tenantId: string;

    @Column({ name: 'price_list_id', type: 'uuid' })
    @IsUUID()
    priceListId: string;

    @ManyToOne(() => PriceList, (list) => list.items, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'price_list_id' })
    priceList: PriceList;

    @Column({ name: 'variant_id', type: 'uuid' })
    @IsUUID()
    variantId: string;

    @ManyToOne(() => ProductVariant, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'variant_id' })
    variant: ProductVariant;

    /** 
     * Precio de venta
     * @validation CHECK (price >= 0)
     */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    price: number;

    /** Precio de costo (para márgenes) */
    @Column({ name: 'cost_price', type: 'decimal', precision: 15, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    @Min(0)
    costPrice?: number;

    // Descuento por volumen
    /** 
     * Cantidad mínima para aplicar este precio. Ej: 1 = precio unitario
     * @validation CHECK (min_quantity >= 1)
     */
    @Column({ name: 'min_quantity', type: 'int', default: 1 })
    @IsInt()
    @Min(1)
    minQuantity: number;

    /** Máxima cantidad (NULL = ilimitado) */
    @Column({ name: 'max_quantity', type: 'int', nullable: true })
    @IsOptional()
    @IsInt()
    @Min(1)
    maxQuantity?: number;

    /** Descuento adicional si compra más de min_quantity */
    @Column({ name: 'volume_discount_percent', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    volumeDiscountPercent: number;

    // Estado
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;
}
