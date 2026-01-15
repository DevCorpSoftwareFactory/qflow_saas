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

export enum CashMovementType {
    CASH_IN = 'cash_in',
    CASH_OUT = 'cash_out',
    CASH_TRANSFER = 'cash_transfer',
}

export enum CashMovementCategory {
    // Ingresos
    CREDIT_GRANTED = 'credit_granted',
    CREDIT_PAYMENT = 'credit_payment',
    ONLINE_PAYMENT_RECEIVED = 'online_payment_received',
    SALES_CASH = 'sales_cash',

    // Egresos
    EXPENSE = 'expense',
    PURCHASE = 'purchase',
    WITHDRAWAL = 'withdrawal',
    TRANSFER_TO_BANK = 'transfer_to_bank',
    OTHER = 'other',
}

/**
 * Registro de ingresos y egresos de dinero durante una sesión de caja.
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

    /** Movement type: income, expense, withdrawal, transfer_in, transfer_out */
    @Column({
        name: 'movement_type',
        type: 'enum',
        enum: CashMovementType
    })
    @IsIn(Object.values(CashMovementType))
    movementType: CashMovementType;

    /** Amount */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    amount: number;

    /** Category */
    @Column({
        type: 'enum',
        enum: CashMovementCategory,
        nullable: true
    })
    @IsOptional()
    @IsIn(Object.values(CashMovementCategory))
    category?: CashMovementCategory;

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
