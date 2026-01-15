import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsBoolean, IsOptional, IsNumber, Min, MaxLength, IsIn, IsUUID } from 'class-validator';
import { Sale } from './sale.entity';

export enum PaymentMethod {
    CASH = 'cash',
    CARD = 'card',
    TRANSFER = 'transfer',
    NEQUI = 'nequi',
    CREDIT = 'credit',
}

/**
 * Métodos de pago en cada venta. Una venta puede tener múltiples pagos.
 * @table sales_payments
 */
@Entity('sales_payments')
@Index(['saleId'])
export class SalePayment {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    @Column({ name: 'sale_id', type: 'uuid' })
    @IsUUID()
    saleId: string;

    @ManyToOne(() => Sale, (sale) => sale.payments, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'sale_id' })
    sale: Sale;

    /** Payment method: cash, card, transfer, nequi, credit */
    @Column({ name: 'payment_method', type: 'varchar', length: 30 })
    @IsString()
    @IsIn(Object.values(PaymentMethod))
    paymentMethod: string;

    /** 
     * Amount
     * @validation CHECK (amount > 0)
     */
    @Column({ type: 'decimal', precision: 15, scale: 2 })
    @IsNumber()
    @Min(0)
    amount: number;

    // Referencia
    @Column({ type: 'varchar', length: 100, nullable: true })
    @IsOptional()
    @IsString()
    @MaxLength(100)
    reference?: string;

    @Column({ name: 'card_last_four', type: 'varchar', length: 4, nullable: true })
    @IsOptional()
    @IsString()
    cardLastFour?: string;

    // Offline sync
    @Column({ type: 'boolean', default: false })
    @IsBoolean()
    synced: boolean;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
