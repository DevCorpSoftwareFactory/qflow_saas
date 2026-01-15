import {
    Entity,
    Column,
    Index,
    OneToMany,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsUrl } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Product } from './product.entity';

/**
 * Brand - Product brands
 * 
 * Examples: Alpina, Colanta, Zenú
 * 
 * @table brands
 */
@Entity('brands')
@Index(['tenantId', 'name'], { where: 'deleted_at IS NULL' })
export class Brand extends TenantBaseEntity {
    /** Brand name */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    name: string;

    /** Brand description */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /** Logo URL */
    @Column({ name: 'logo_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    logoUrl?: string;

    /** Brand website */
    @Column({ type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsUrl()
    website?: string;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    @OneToMany(() => Product, (product) => product.brand)
    products: Product[];
}
