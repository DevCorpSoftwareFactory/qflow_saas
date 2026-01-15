import {
    Entity,
    Column,
    Index,
    ManyToOne,
    JoinColumn,
    PrimaryGeneratedColumn,
    CreateDateColumn,
} from 'typeorm';
import { IsString, IsBoolean } from 'class-validator';
import { SupportTicket } from './support-ticket.entity';

/**
 * TicketMessage - Ticket conversation messages
 * 
 * @table ticket_messages
 */
@Entity('ticket_messages')
@Index(['ticketId'])
export class TicketMessage {
    @PrimaryGeneratedColumn('uuid')
    id: string;

    /** Ticket ID */
    @Column({ name: 'ticket_id', type: 'uuid' })
    ticketId: string;

    @ManyToOne(() => SupportTicket, { onDelete: 'CASCADE' })
    @JoinColumn({ name: 'ticket_id' })
    ticket: SupportTicket;

    /** Author type: customer, agent, system */
    @Column({ name: 'author_type', type: 'varchar', length: 20 })
    @IsString()
    authorType: string;

    /** Author user ID */
    @Column({ name: 'author_id', type: 'uuid', nullable: true })
    authorId?: string;

    /** Message content */
    @Column({ type: 'text' })
    @IsString()
    message: string;

    /** Attachments: array of URLs */
    @Column({ type: 'jsonb', default: '[]' })
    attachments: string[];

    /** Internal message (agents only) */
    @Column({ name: 'is_internal', type: 'boolean', default: false })
    @IsBoolean()
    isInternal: boolean;

    @CreateDateColumn({ name: 'created_at', type: 'timestamptz' })
    createdAt: Date;
}
