/**
 * Cash Session DTOs
 * Aligned with init.sql schema (lines 2278-2358)
 */

import { UUID } from '../types/common.types';

/**
 * Open session request DTO
 * Matches cash_sessions table in init.sql
 */
export interface OpenSessionDto {
    cashRegisterId: UUID;
    branchId?: UUID;  // Optional, can be obtained from cash register
    openingAmount?: number;  // initial_amount in DB, defaults to 0
    openingNotes?: string;  // Not in DB schema, used for initial movement concept
}

/**
 * Close session request DTO
 * RF-007: Blind cash count - declaredAmount vs system_amount
 */
export interface CloseSessionDto {
    declaredAmount: number;  // What the cashier physically counted
    differenceJustification?: string;  // Required if difference exceeds threshold
    denominations?: Record<string, number>;  // Optional breakdown (stored in notes/audit)
}

/**
 * Cash movement request DTO
 * Matches cash_movements table (lines 2331-2358)
 */
export interface CreateCashMovementDto {
    movementType: 'income' | 'expense' | 'withdrawal' | 'transfer_in' | 'transfer_out';
    amount: number;
    concept: string;  // Required, VARCHAR(200) in DB
    category?: string;  // Optional, VARCHAR(50)
    reference?: string;  // Optional, VARCHAR(100)
    evidenceUrl?: string;  // Photo of receipt
}

/**
 * Cash Session Response DTO
 * Aligned with cash_sessions table schema
 */
export interface CashSessionResponseDto {
    id: UUID;
    tenantId: UUID;
    cashRegisterId: UUID;
    userId: UUID;

    // Dates
    openingDate: string;
    closingDate?: string;

    // Amounts - RF-007 blind close
    initialAmount: number;
    systemAmount: number;  // What the system says
    declaredAmount?: number;  // What cashier counted
    difference?: number;  // Generated: declared - system
    differenceJustification?: string;

    // Status
    status: 'open' | 'closed' | 'pending_approval';

    // Approval
    approvedBy?: UUID;
    approvedAt?: string;
    approvalNotes?: string;

    // Timestamps
    createdAt: string;
    updatedAt: string;
}
