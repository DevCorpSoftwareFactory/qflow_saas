import {
    Entity,
    Column,
    Index,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, IsUrl, MaxLength, Min } from 'class-validator';

/**
 * CustomerPayment - Customer payment records
 * 
 * Includes payments registered by customers via app.
 * 
 * @table customer_payments
 */
@Entity('customer_payments')
@Index(['customerId'])
@Index(['status'])
@Index(['verifiedBy'])
export class CustomerPayment {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Customer ID */
    @Column({ name: 'customer_id', type: 'uuid' })
    customerId: string;

    /** Payment date */
    @Column({ name: 'payment_date', type: 'date' })
    paymentDate: Date;

    /** Amount */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    amount: number;

    /** Payment method: cash, transfer, nequi, card */
    @Column({ name: 'payment_method', type: 'varchar', length: 30 })
    @IsString()
    paymentMethod: string;

    /** Reference */
    @Column({ type: 'varchar', length: 200, nullable: true })
    @IsOptional()
    @IsString()
    @MaxLength(200)
    reference?: string;

    /** Proof URL (customer uploaded) */
    @Column({ name: 'proof_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    proofUrl?: string;

    /** Status: pending_verification, verified, rejected */
    @Column({ type: 'varchar', length: 20, default: 'pending_verification' })
    @IsString()
    status: string;

    /** Verified by user ID */
    @Column({ name: 'verified_by', type: 'uuid', nullable: true })
    @IsOptional()
    verifiedBy?: string;

    /** Verification timestamp */
    @Column({ name: 'verified_at', type: 'timestamptz', nullable: true })
    verifiedAt?: Date;

    /** Verification notes */
    @Column({ name: 'verification_notes', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    verificationNotes?: string;

    /** Applied to invoices: [{ invoice_id, amount }] */
    @Column({ name: 'applied_to', type: 'jsonb', nullable: true })
    appliedTo?: Array<{ invoice_id: string; amount: number }>;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;
}
