import {
    Entity,
    Column,
    Index,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    Unique,
} from 'typeorm';
import { IsBoolean, IsInt, Min, Max } from 'class-validator';

/**
 * AccountingPeriod - Monthly accounting periods
 * 
 * is_closed prevents edits to entries in that period.
 * start_date and end_date are generated columns.
 * 
 * @table accounting_periods
 */
@Entity('accounting_periods')
@Unique(['tenantId', 'year', 'month'])
@Index(['tenantId', 'year', 'month'])
export class AccountingPeriod {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Year */
    @Column({ type: 'int' })
    @IsInt()
    @Min(2020)
    @Max(2100)
    year: number;

    /** Month (1-12) */
    @Column({ type: 'int' })
    @IsInt()
    @Min(1)
    @Max(12)
    month: number;

    /** Period name (generated: 2026-01) */
    @Column({ name: 'period_name', type: 'varchar', length: 50, generatedType: 'STORED', asExpression: "year || '-' || LPAD(month::text, 2, '0')" })
    periodName: string;

    /** Closed flag */
    @Column({ name: 'is_closed', type: 'boolean', default: false })
    @IsBoolean()
    isClosed: boolean;

    /** Closed timestamp */
    @Column({ name: 'closed_at', type: 'timestamptz', nullable: true })
    closedAt?: Date;

    /** Closed by user ID */
    @Column({ name: 'closed_by', type: 'uuid', nullable: true })
    closedBy?: string;

    /** Start date (generated) */
    @Column({ name: 'start_date', type: 'date', generatedType: 'STORED', asExpression: "MAKE_DATE(year, month, 1)" })
    startDate: Date;

    /** End date (generated) */
    @Column({ name: 'end_date', type: 'date', generatedType: 'STORED', asExpression: "MAKE_DATE(year, month, 1) + INTERVAL '1 month' - INTERVAL '1 day'" })
    endDate: Date;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
