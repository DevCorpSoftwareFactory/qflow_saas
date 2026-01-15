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
    IsInt,
    IsNumber,
    Min,
    IsObject,
    IsUUID,
    IsIn,
} from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { ProductCategory } from './product-category.entity';
import { Brand } from './brand.entity';
import { UnitOfMeasure } from './unit-of-measure.entity';
import { ProductVariant } from './product-variant.entity';

/**
 * Entidad LÓGICA del producto. NO tiene precio NI stock. Solo define qué es el producto.
 * @table products
 */
@Entity({ name: 'products' })
@Index('idx_products_tenant_code', ['tenantId', 'code'], { unique: true, where: 'deleted_at IS NULL' })
@Index('idx_products_tenant_category', ['tenantId', 'categoryId'], { where: 'deleted_at IS NULL' })
@Index('idx_products_tenant_brand', ['tenantId', 'brandId'], { where: 'deleted_at IS NULL' })
@Index('idx_products_tenant_active', ['tenantId', 'isActive'], { where: 'deleted_at IS NULL' })
export class Product extends TenantBaseEntity {
    // Identificación
    /** 
     * Código interno del producto
     * @validation CHECK (code IS NOT NULL AND code <> '') - Validar en servicio
     */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    code: string;

    /** EAN13, CODE128, QR */
    @Column({ name: 'barcode_type', type: 'varchar', length: 20, default: 'EAN13', nullable: true })
    @IsOptional()
    @IsString()
    @IsIn(['EAN13', 'CODE128', 'QR', 'UPC'])
    barcodeType?: string;

    // Datos básicos
    @Column({ type: 'varchar', length: 200 })
    @IsString()
    name: string;

    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    @Column({ name: 'short_name', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    shortName?: string;

    // Clasificación
    @Column({ name: 'category_id', type: 'uuid', nullable: true })
    @IsOptional()
    @IsUUID()
    categoryId?: string;

    @ManyToOne(() => ProductCategory, (category) => category.products)
    @JoinColumn({ name: 'category_id' })
    category?: ProductCategory;

    @Column({ name: 'brand_id', type: 'uuid', nullable: true })
    @IsOptional()
    @IsUUID()
    brandId?: string;

    @ManyToOne(() => Brand, (brand) => brand.products)
    @JoinColumn({ name: 'brand_id' })
    brand?: Brand;

    @Column({ name: 'unit_id', type: 'uuid' })
    @IsUUID()
    unitId: string;

    @ManyToOne(() => UnitOfMeasure)
    @JoinColumn({ name: 'unit_id' })
    unit: UnitOfMeasure;

    // Características de inventario
    /** TRUE para productos perecederos (lácteos, carnes) que requieren fecha de vencimiento */
    @Column({ name: 'has_expiry', type: 'boolean', default: false })
    @IsBoolean()
    hasExpiry: boolean;

    /** TRUE si se debe controlar por lotes (trazabilidad) */
    @Column({ name: 'has_batch_control', type: 'boolean', default: true })
    @IsBoolean()
    hasBatchControl: boolean;

    /** ¿Controla inventario? */
    @Column({ name: 'track_inventory', type: 'boolean', default: true })
    @IsBoolean()
    trackInventory: boolean;

    // Umbrales
    /** Stock mínimo antes de alertar reorder */
    @Column({ name: 'min_stock', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    minStock: number;

    /** Stock máximo para alertas */
    @Column({ name: 'max_stock', type: 'int', nullable: true })
    @IsOptional()
    @IsInt()
    @Min(0)
    maxStock?: number;

    /** Punto de reorden */
    @Column({ name: 'reorder_point', type: 'int', nullable: true })
    @IsOptional()
    @IsInt()
    @Min(0)
    reorderPoint?: number;

    // Atributos adicionales
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    /** ¿Se puede vender? */
    @Column({ name: 'is_salable', type: 'boolean', default: true })
    @IsBoolean()
    isSalable: boolean;

    /** ¿Se puede comprar? */
    @Column({ name: 'is_purchasable', type: 'boolean', default: true })
    @IsBoolean()
    isPurchasable: boolean;

    @Column({ name: 'is_returnable', type: 'boolean', default: true })
    @IsBoolean()
    isReturnable: boolean;

    // Atributos para alimentación
    @Column({ name: 'requires_cooling', type: 'boolean', default: false })
    @IsBoolean()
    requiresCooling: boolean;

    @Column({ name: 'storage_temperature_min', type: 'decimal', precision: 5, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    storageTemperatureMin?: number;

    @Column({ name: 'storage_temperature_max', type: 'decimal', precision: 5, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    storageTemperatureMax?: number;

    // Información nutricional (opcional)
    /** JSON con {calorias, proteinas, grasas, etc.} para etiquetas */
    @Column({ name: 'nutritional_info', type: 'jsonb', nullable: true })
    @IsOptional()
    @IsObject()
    nutritionalInfo?: Record<string, any>;

    // Relaciones inversas
    @OneToMany(() => ProductVariant, (variant) => variant.product)
    variants: ProductVariant[];
}
