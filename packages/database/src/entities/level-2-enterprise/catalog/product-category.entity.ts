import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    OneToMany,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsInt, Min, IsUrl } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';
import { Product } from './product.entity';

/**
 * ProductCategory - Hierarchical product categories
 * 
 * Self-referential tree structure. Example: Lácteos > Quesos > Queso Fresco
 * 
 * @table product_categories
 */
@Entity('product_categories')
@Index(['tenantId', 'name'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'parentId'], { where: 'deleted_at IS NULL' })
export class ProductCategory extends TenantBaseEntity {
    /** Category name */
    @Column({ type: 'varchar', length: 100 })
    @IsString()
    @MaxLength(100)
    name: string;

    /** Category description */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /** Internal code */
    @Column({ type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    code?: string;

    /** Parent category ID (self-reference) */
    @Column({ name: 'parent_id', type: 'uuid', nullable: true })
    @IsOptional()
    parentId?: string;

    @ManyToOne(() => ProductCategory, { onDelete: 'SET NULL' })
    @JoinColumn({ name: 'parent_id' })
    parent?: ProductCategory;

    /** Hierarchy level: 0=root, 1=first, etc. */
    @Column({ type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    level: number;

    /** Display order */
    @Column({ name: 'display_order', type: 'int', default: 0 })
    @IsInt()
    displayOrder: number;

    /** Category image URL */
    @Column({ name: 'image_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    imageUrl?: string;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;

    @OneToMany(() => Product, (product) => product.category)
    products: Product[];

}
