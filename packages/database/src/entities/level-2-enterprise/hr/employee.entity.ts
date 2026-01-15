import {
    Entity,
    Column,
    Index,
} from 'typeorm';
import { IsString, IsOptional, MaxLength, IsNumber, Min } from 'class-validator';
import { TenantBaseEntity } from '../../base/tenant-base.entity';

/**
 * Employee - Company employees
 * 
 * @table employees
 */
@Entity('employees')
@Index(['tenantId', 'employeeCode'], { unique: true, where: 'deleted_at IS NULL' })
@Index(['tenantId', 'branchId'], { where: 'deleted_at IS NULL' })
@Index(['tenantId', 'status'], { where: 'deleted_at IS NULL' })
export class Employee extends TenantBaseEntity {
    /** User ID link (optional) */
    @Column({ name: 'user_id', type: 'uuid', nullable: true })
    @IsOptional()
    userId?: string;

    /** Employee code */
    @Column({ name: 'employee_code', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    employeeCode?: string;

    /** Tax ID */
    @Column({ name: 'tax_id', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    taxId?: string;

    /** Document type */
    @Column({ name: 'document_type', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    documentType?: string;

    /** Document number */
    @Column({ name: 'document_number', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    documentNumber?: string;

    /** Full name */
    @Column({ name: 'full_name', type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    fullName: string;

    /** Position/role */
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    position?: string;

    /** Branch ID */
    @Column({ name: 'branch_id', type: 'uuid', nullable: true })
    @IsOptional()
    branchId?: string;

    /** Hire date */
    @Column({ name: 'hire_date', type: 'date' })
    hireDate: Date;

    /** Termination date */
    @Column({ name: 'termination_date', type: 'date', nullable: true })
    terminationDate?: Date;

    /** Status: active, on_leave, terminated */
    @Column({ type: 'varchar', length: 20, default: 'active' })
    @IsString()
    status: string;

    /** Salary */
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    salary: number;

    /** Payment frequency: biweekly, monthly */
    @Column({ name: 'payment_frequency', type: 'varchar', length: 20, default: 'monthly' })
    @IsString()
    paymentFrequency: string;

    /** Bank name */
    @Column({ name: 'bank_name', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    bankName?: string;

    /** Bank account */
    @Column({ name: 'bank_account', type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    bankAccount?: string;

    /** Account type: corriente, ahorros */
    @Column({ name: 'account_type', type: 'varchar', length: 20, nullable: true })
    @IsOptional()
    @IsString()
    accountType?: string;
}
