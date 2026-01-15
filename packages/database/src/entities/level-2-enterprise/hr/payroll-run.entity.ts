import {
    Entity,
    Column,
    Index,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, MaxLength, Min } from 'class-validator';

/**
 * PayrollRun - Processed payroll runs
 * 
 * @table payroll_runs
 */
@Entity('payroll_runs')
@Index(['tenantId', 'payrollNumber'], { unique: true })
@Index(['tenantId', 'periodStart', 'periodEnd'])
export class PayrollRun {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Payroll number */
    @Column({ name: 'payroll_number', type: 'varchar', length: 50 })
    @IsString()
    @MaxLength(50)
    payrollNumber: string;

    /** Period start */
    @Column({ name: 'period_start', type: 'date' })
    periodStart: Date;

    /** Period end */
    @Column({ name: 'period_end', type: 'date' })
    periodEnd: Date;

    /** Payment date */
    @Column({ name: 'payment_date', type: 'date' })
    paymentDate: Date;

    /** Total gross */
    @Column({ name: 'total_gross', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalGross: number;

    /** Total deductions */
    @Column({ name: 'total_deductions', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalDeductions: number;

    /** Total net */
    @Column({ name: 'total_net', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    totalNet: number;

    /** Status: draft, approved, paid */
    @Column({ type: 'varchar', length: 20, default: 'draft' })
    @IsString()
    status: string;

    /** Approved by user ID */
    @Column({ name: 'approved_by', type: 'uuid', nullable: true })
    @IsOptional()
    approvedBy?: string;

    /** Approval timestamp */
    @Column({ name: 'approved_at', type: 'timestamptz', nullable: true })
    approvedAt?: Date;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;
}
