import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsNumber, Min } from 'class-validator';
import { AccountingEntry } from './accounting-entry.entity';
import { ChartOfAccounts } from './chart-of-accounts.entity';

/**
 * AccountingEntryLine - Entry line items
 * 
 * Validation: SUM(debit) = SUM(credit) per entry.
 * 
 * @table accounting_entry_lines
 */
@Entity('accounting_entry_lines')
@Index(['entryId'])
@Index(['tenantId', 'accountId'])
export class AccountingEntryLine {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Entry ID */
    @Column({ name: 'entry_id', type: 'uuid' })
    entryId: string;

    @ManyToOne(() => AccountingEntry, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'entry_id' })
    entry: AccountingEntry;

    /** Account ID */
    @Column({ name: 'account_id', type: 'uuid' })
    accountId: string;

    @ManyToOne(() => ChartOfAccounts)
    @JoinColumn({ name: 'account_id' })
    account: ChartOfAccounts;

    /** Debit amount */
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    debit: number;

    /** Credit amount */
    @Column({ type: 'decimal', precision: 15, scale: 2, default: 0 })
    @IsNumber()
    @Min(0)
    credit: number;

    /** Line description */
    @Column({ type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    description?: string;

    /** Document type for traceability */
    @Column({ name: 'document_type', type: 'varchar', length: 50, nullable: true })
    @IsOptional()
    @IsString()
    documentType?: string;

    /** Document ID */
    @Column({ name: 'document_id', type: 'uuid', nullable: true })
    @IsOptional()
    documentId?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
