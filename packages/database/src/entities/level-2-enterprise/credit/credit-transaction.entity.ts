import {
    Entity,
    Column,
    Index,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber } from 'class-validator';

/**
 * CreditTransaction - Credit account movements
 * 
 * @table credit_transactions
 */
@Entity('credit_transactions')
@Index(['customerId'])
export class CreditTransaction {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Customer ID */
    @Column({ name: 'customer_id', type: 'uuid' })
    customerId: string;

    /** Transaction type: charge, payment, adjustment, interest, fee */
    @Column({ name: 'transaction_type', type: 'varchar', length: 20 })
    @IsString()
    transactionType: string;

    /** Amount (positive=increase debt, negative=decrease) */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    amount: number;

    /** Reference type (polymorphic) */
    @Column({ name: 'reference_type', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    referenceType?: string;

    /** Reference ID */
    @Column({ name: 'reference_id', type: 'uuid', nullable: true })
    @IsOptional()
    referenceId?: string;

    /** Balance before transaction */
    @Column({ name: 'balance_before', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    balanceBefore: number;

    /** Balance after transaction */
    @Column({ name: 'balance_after', type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    balanceAfter: number;

    /** Notes */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    notes?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
