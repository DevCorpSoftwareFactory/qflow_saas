import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsNumber, IsInt, Min } from 'class-validator';
import { PayrollRun } from './payroll-run.entity';
import { Employee } from './employee.entity';

/**
 * PayrollDetail - Payroll details per employee
 * 
 * @table payroll_details
 */
@Entity('payroll_details')
@Index(['payrollRunId'])
@Index(['employeeId'])
export class PayrollDetail {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Payroll run ID */
    @Column({ name: 'payroll_run_id', type: 'uuid' })
    payrollRunId: string;

    @ManyToOne(() => PayrollRun, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'payroll_run_id' })
    payrollRun: PayrollRun;

    /** Employee ID */
    @Column({ name: 'employee_id', type: 'uuid' })
    employeeId: string;

    @ManyToOne(() => Employee)
    @JoinColumn({ name: 'employee_id' })
    employee: Employee;

    /** Gross salary */
    @Column({ name: 'gross_salary', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    grossSalary: number;

    /** Deductions: { health: 4%, pension: 4%, tax: 0 } */
    @Column({ type: 'jsonb', default: '{}' })
    deductions: Record<string, number>;

    /** Overtime hours */
    @Column({ name: 'overtime_hours', type: 'int', default: 0 })
    @IsInt()
    @Min(0)
    overtimeHours: number;

    /** Overtime amount */
    @Column({ name: 'overtime_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    overtimeAmount: number;

    /** Bonuses array */
    @Column({ type: 'jsonb', default: '[]' })
    bonuses: Array<{ name: string; amount: number }>;

    /** Net salary */
    @Column({ name: 'net_salary', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    netSalary: number;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
