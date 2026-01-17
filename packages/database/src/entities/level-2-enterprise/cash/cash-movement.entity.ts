import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, IsUrl, MaxLength, Min, IsIn, IsUUID } from 'class-validator';
import { CashSession } from './cash-session.entity';
import { User } from '../organization/user.entity';

// Type aliases for movement types - matching init.sql varchar values
export enum CashMovementType {
    INCOME = 'income',
    EXPENSE = 'expense',
    WITHDRAWAL = 'withdrawal',
    TRANSFER_IN = 'transfer_in',
    TRANSFER_OUT = 'transfer_out',
}

export enum CashMovementCategory {
    // init.sql categories (varchar(50))
    OPERATIONAL_EXPENSE = 'operational_expense',
    SUPPLIER_PAYMENT = 'supplier_payment',
    OWNER_WITHDRAWAL = 'owner_withdrawal',
    INITIAL_FUND = 'initial_fund',
    SALES_CASH = 'sales_cash',
    EXPENSE = 'expense',
    WITHDRAWAL = 'withdrawal',
    OTHER = 'other',
    CREDIT_GRANTED = 'credit_granted',
    CREDIT_PAYMENT = 'credit_payment',
    ONLINE_PAYMENT_RECEIVED = 'online_payment_received',
    PURCHASE = 'purchase',
    TRANSFER_TO_BANK = 'transfer_to_bank',
}

/**
 * Registro de ingresos y egresos de dinero durante una sesión de caja.
 * Aligned with init.sql schema.
 * @table cash_movements
 */
@Entity('cash_movements')
@Index(['tenantId', 'branchId'])
@Index(['cashSessionId'])
@Index(['category'])
export class CashMovement {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @Column({ name: 'branch_id', type: 'uuid' })
    @IsUUID()
    branchId: string;

    @Column({ name: 'cash_session_id', type: 'uuid', nullable: true })
    @IsOptional()
    cashSessionId?: string;

    @ManyToOne(() => CashSession, (session) => session.movements, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'cash_session_id' })
    cashSession?: CashSession;

    /** Movement type: income, expense, withdrawal, transfer_in, transfer_out (varchar in init.sql) */
    @Column({
        name: 'movement_type',
        type: 'varchar',
        length: 20,
    })
    @IsString()
    @IsIn(['income', 'expense', 'withdrawal', 'transfer_in', 'transfer_out'])
    movementType: string;

    /** Amount */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    amount: number;

    /** Category (varchar in init.sql) */
    @Column({
        type: 'varchar',
        length: 50,
        nullable: true
    })
    @IsOptional()
    @IsString()
    category?: string;

    @Column({ type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    concept: string;

    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    reference?: string;

    @Column({ name: 'evidence_url', type: 'text', nullable: true })
    @IsOptional()
    @IsUrl()
    evidenceUrl?: string;

    @Column({ name: 'created_by', type: 'uuid', nullable: true })
    @IsOptional()
    createdBy?: string;

    @ManyToOne(() => User)
    @JoinColumn({ name: 'created_by' })
    creator?: User;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
