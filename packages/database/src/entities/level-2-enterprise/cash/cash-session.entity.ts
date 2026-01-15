import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    OneToMany,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, Min, IsIn, IsUUID } from 'class-validator';
import { CashRegister } from './cash-register.entity';
import { User } from '../organization/user.entity';
import { CashMovement } from './cash-movement.entity';

export enum SessionStatus {
    OPEN = 'open',
    CLOSED = 'closed',
}

/**
 * Sesiones de caja - CIERRE CIEGO
 * CRITICAL: system_amount vs declared_amount separation.
 * @table cash_sessions
 */
@Entity('cash_sessions')
@Index(['tenantId', 'userId'])
@Index(['tenantId', 'status'])
@Index(['tenantId', 'cashRegisterId'])
export class CashSession {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @Column({ name: 'cash_register_id', type: 'uuid' })
    @IsUUID()
    cashRegisterId: string;

    @ManyToOne(() => CashRegister)
    @JoinColumn({ name: 'cash_register_id' })
    cashRegister: CashRegister;

    /** Cashier user ID */
    @Column({ name: 'user_id', type: 'uuid' })
    @IsUUID()
    userId: string;

    @ManyToOne(() => User)
    @JoinColumn({ name: 'user_id' })
    user: User;

    @Column({ name: 'opening_date', type: 'timestamptz', default: () => 'NOW()' })
    openingDate: Date;

    @Column({ name: 'closing_date', type: 'timestamptz', nullable: true })
    closingDate?: Date;

    // Fondo inicial
    @Column({ name: 'initial_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    initialAmount: number;

    // 💰 SEPARACIÓN CIEGA (PROPÓSITO DEL MÓDULO)
    /** Lo que dice el sistema */
    @Column({ name: 'system_amount', type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    systemAmount: number;

    /** Lo que cuenta el cajero */
    @Column({ name: 'declared_amount', type: 'decimal', precision: 15, scale: 2, nullable: true })
    @IsOptional()
    @IsNumber()
    declaredAmount?: number;

    /** Difference (generated: declared - system) */
    @Column({
        type: 'decimal',
        precision: 15,
        scale: 2,
        generatedType: 'STORED',
        asExpression: 'COALESCE(declared_amount, 0) - system_amount'
    })
    difference: number;

    @Column({ name: 'difference_justification', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    differenceJustification?: string;

    /** Status: open, closed */
    @Column({
        type: 'enum',
        enum: SessionStatus,
        default: SessionStatus.OPEN
    })
    @IsIn(Object.values(SessionStatus))
    status: SessionStatus;

    // Aprobación
    @Column({ name: 'approved_by', type: 'uuid', nullable: true })
    @IsOptional()
    approvedBy?: string;

    @Column({ name: 'approved_at', type: 'timestamptz', nullable: true })
    approvedAt?: Date;

    @Column({ name: 'approval_notes', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    approvalNotes?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;

    @OneToMany(() => CashMovement, (movement) => movement.cashSession)
    movements: CashMovement[];
}
