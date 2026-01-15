import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, MaxLength, IsNumber, Min } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * UnitOfMeasure - Measurement units for products
 * 
 * Examples: kg, g, lb, oz, L, mL, unidad
 * Supports conversion between units via conversion_factor
 * 
 * @table units_of_measure
 */
@Entity('units_of_measure')
@Index(['tenantId', 'name'], { where: 'deleted_at IS NULL' })
export class UnitOfMeasure extends TenantBaseEntity {
    /** Unit name: kilogramo, litro, unidad */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    name: string;

    /** Abbreviation: kg, L, un */
    @Column({ type: 'varchar', length: 10 })
    @IsString()
    @MaxLength(10)
    abbreviation: string;

    /** Unit type: weight, volume, quantity, length */
    @Column({ name: 'unit_type', type: 'varchar', length: 20 })
    @IsString()
    unitType: string;

    /** Conversion factor to base unit */
    @Column({ name: 'conversion_factor', type: 'decimal', precision: 10, scale: 4, nullable: true })
    @IsOptional()
    @IsNumber()
    conversionFactor?: number;

    /** Base unit ID for conversion */
    @Column({ name: 'base_unit_id', type: 'uuid', nullable: true })
    @IsOptional()
    baseUnitId?: string;

    @ManyToOne(() => UnitOfMeasure)
    @JoinColumn({ name: 'base_unit_id' })
    baseUnit?: UnitOfMeasure;

    /** Active status */
    @Column({ name: 'is_active', type: 'boolean', default: true })
    @IsBoolean()
    isActive: boolean;
}
