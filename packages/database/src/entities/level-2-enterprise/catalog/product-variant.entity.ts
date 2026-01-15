import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import {
    IsString,
    IsBoolean,
    IsOptional,
    IsNumber,
    IsObject,
    IsUUID,
} from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Product } from './product.entity';

/**
 * Entidad FÍSICA del producto - SKU real en inventario. Ej: "Queso Fresco 500g" vs "Queso Fresco 1kg"
 * @table product_variants
 */
@Entity({ name: 'product_variants' })
@Index('idx_variants_tenant_sku', ['tenantId', 'sku'], { unique: true, where: 'deleted_at IS NULL' })
@Index('idx_variants_tenant_barcode', ['tenantId', 'barcode'], { unique: true, where: 'deleted_at IS NULL' })
@Index('idx_variants_tenant_product', ['tenantId', 'productId'], { where: 'deleted_at IS NULL' })
export class ProductVariant extends TenantBaseEntity {
    // Referencia al producto lógico
    @Column({ name: 'product_id', type: 'uuid' })
    @IsUUID()
    productId: string;

    @ManyToOne(() => Product, (product) => product.variants, { nullable: false })
    @JoinColumn({ name: 'product_id' })
    product: Product;

    // Identificación
    /** Código de inventario único por variante. Ej: QS-FRESCO-500G */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    sku: string;

    /** Código de barras para escáner en POS. CRÍTICO para velocidad de caja */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    barcode?: string;

    // Atributos de variante
    /** Atributos diferenciadores: {presentation: "500g", flavor: "natural", organic: true} */
    @Column({ type: 'jsonb', default: {} })
    @IsObject()
    attributes: Record<string, any>;

    // Configuración de venta
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** Variante por defecto del producto */
    @Column({ name: 'is_default', type: 'boolean', default: false })
    @IsBoolean()
    isDefault: boolean;

    // Peso/Volumen (para logística)
    @Column({ name: 'weight_kg', type: 'decimal', precision: 10, scale: 3, nullable: true })
    @IsOptional()
    @IsNumber()
    weightKg?: number;

    @Column({ name: 'volume_liters', type: 'decimal', precision: 10, scale: 3, nullable: true })
    @IsOptional()
    @IsNumber()
    volumeLiters?: number;
}
