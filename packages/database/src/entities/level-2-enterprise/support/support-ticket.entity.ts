import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
    UpdateDateColumn,
    DeleteDateColumn,
} from 'typeorm';
import { IsString, IsOptional, IsInt, MaxLength, Min, Max } from 'class-validator';

/**
 * SupportTicket - Support tickets from tenants
 * 
 * For Admin Platform support management.
 * 
 * @table support_tickets
 */
@Entity('support_tickets')
@Index(['tenantId', 'status'])
@Index(['assignedTo', 'status'])
@Index(['slaDueAt'], { where: "status NOT IN ('resolved', 'closed')" })
export class SupportTicket {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    /** Ticket number: TK-2026-00001 */
    @Column({ name: 'ticket_number', type: 'varchar', length: 50, unique: true })
    @Index()
    @IsString()
    @MaxLength(50)
    ticketNumber: string;

    /** Tenant ID */
    @Column({ name: 'tenant_id', type: 'uuid' })
    @Index()
    tenantId: string;

    /** Customer user ID (tenant user who created) */
    @Column({ name: 'customer_user_id', type: 'uuid', nullable: true })
    @IsOptional()
    customerUserId?: string;

    /** Category: technical, billing, feature_request, bug, general */
    @Column({ type: 'varchar', length: 50 })
    @IsString()
    category: string;

    /** Priority: low, medium, high, critical */
    @Column({ type: 'varchar', length: 20 })
    @IsString()
    priority: string;

    /** Subject */
    @Column({ type: 'varchar', length: 200 })
    @IsString()
    @MaxLength(200)
    subject: string;

    /** Description */
    @Column({ type: 'text' })
    @IsString()
    description: string;

    /** Status: open, in_progress, waiting_customer, resolved, closed */
    @Column({ type: 'varchar', length: 30, default: 'open' })
    @IsString()
    status: string;

    /** Assigned agent (QFlow Pro staff) */
    @Column({ name: 'assigned_to', type: 'uuid', nullable: true })
    @IsOptional()
    assignedTo?: string;

    /** SLA due date */
    @Column({ name: 'sla_due_at', type: 'timestamptz', nullable: true })
    slaDueAt?: Date;

    /** First response timestamp */
    @Column({ name: 'first_response_at', type: 'timestamptz', nullable: true })
    firstResponseAt?: Date;

    /** Resolution timestamp */
    @Column({ name: 'resolved_at', type: 'timestamptz', nullable: true })
    resolvedAt?: Date;

    /** Customer rating (1-5) */
    @Column({ name: 'customer_rating', type: 'int', nullable: true })
    @IsOptional()
    @IsInt()
    @Min(1)
    @Max(5)
    customerRating?: number;

    /** Customer feedback text */
    @Column({ name: 'customer_feedback', type: 'text', nullable: true })
    @IsOptional()
    @IsString()
    customerFeedback?: string;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;

    @UpdateDateColumn({ name: 'updated_at', type: 'timestamptz' })
    updatedAt: Date;

    @DeleteDateColumn({ name: 'deleted_at', type: 'timestamptz', nullable: true })
    deletedAt?: Date;
}
