import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { IsString, IsNumber, IsInt, Min } from 'class-validator';

/**
 * CreditAccount - Customer credit accounts
 * 
 * @table credit_accounts
 */
@Entity('credit_accounts')
@Index(['tenantId', 'customerId'], { unique: true })
export class CreditAccount {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Customer ID */
    @Column({ name: 'customer_id', type: 'uuid' })
    customerId: string;

    /** Credit limit */
    @Column({ name: 'credit_limit', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    creditLimit: number;

    /** Current balance (debt) */
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    balance: number;

    /** Credit days */
    @Column({ name: 'credit_days', type: 'int', default: 30 })
    @IsInt()
    creditDays: number;

    /** Monthly interest rate */
    @Column({ name: 'interest_rate', type: 'decimal', precision: 5, scale: 2, default: 0 })
    @IsNumber()
    interestRate: number;

    /** Grace days */
    @Column({ name: 'grace_days', type: 'int', default: 0 })
    @IsInt()
    graceDays: number;

    /** Status: active, suspended, blocked */
    @Column({ type: 'varchar', length: 20, default: 'active' })
    @IsString()
    status: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;
}
