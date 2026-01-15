import {
    Entity,
    Column,
    Index,
    OneToMany,
} from 'typeorm';
import {
    IsString,
    IsBoolean,
    IsOptional,
    IsIn,
    IsDate,
} from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { PriceListItem } from './price-list-item.entity';

/**
 * Listas de precios según tipo de cliente. Evita tener precio fijo en products
 * @table price_lists
 */
@Entity({ name: 'price_lists' })
@Index('idx_pricelists_tenant', ['tenantId', 'name'], { where: 'deleted_at IS NULL' })
@Index('idx_pricelists_tenant_type', ['tenantId', 'customerType'], { where: 'deleted_at IS NULL' })
@Index('idx_pricelists_tenant_active', ['tenantId', 'isActive'], { where: 'deleted_at IS NULL' })
@Index('idx_pricelists_validity', ['validFrom', 'validTo'], { where: 'deleted_at IS NULL AND is_active = true' })
export class PriceList extends TenantBaseEntity {
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    name: string; // "Minorista", "Mayorista", "VIP", "Promo Navideña"

    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /** Tipo de cliente al que aplica: retail=minorista, wholesale=mayorista, vip=preferencial */
    @Column({ name: 'customer_type', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    @IsIn(['retail', 'wholesale', 'vip', 'distributor'])
    customerType?: string;

    /** Lista por defecto */
    @Column({ name: 'is_default', type: 'boolean', default: false })
    @IsBoolean()
    isDefault: boolean;

    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    // Validez temporal
    /** 
     * Fecha desde la que aplica (NULL = siempre)
     * @validation CHECK (valid_from <= valid_to)
     */
    @Column({ name: 'valid_from', type: 'date', nullable: true })
    @IsOptional()
    @IsDate()
    validFrom?: Date;

    /** Fecha hasta la que aplica (NULL = sin límite) */
    @Column({ name: 'valid_to', type: 'date', nullable: true })
    @IsOptional()
    @IsDate()
    validTo?: Date;

    // Relaciones
    @OneToMany(() => PriceListItem, (item) => item.priceList)
    items: PriceListItem[];
}
