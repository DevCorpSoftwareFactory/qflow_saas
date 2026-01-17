/**
 * Sync DTOs
 * Data transfer objects for offline data synchronization.
 */

import { UUID } from '../types/common.types';

export interface OfflineSaleDto {
    id: UUID; // Original UUID generated offline
    saleNumber?: string;
    createdAt: string; // Original offline timestamp
    branchId: UUID;
    items: any[];
    payments: any[];
    totals: {
        subtotal: number;
        tax: number;
        total: number;
    };
    customerId?: UUID;
    cashierId: UUID;
    cashSessionId?: UUID;
}

/**
 * Cash Session DTO for offline-to-server sync.
 * Represents a cash session created/closed on the POS device.
 */
export interface OfflineCashSessionDto {
    id: UUID;
    cashRegisterId: UUID;
    branchId: UUID;
    userId: UUID;
    status: 'open' | 'closed';
    openingDate: string;
    closingDate?: string;
    initialAmount: number;
    systemAmount?: number;
    declaredAmount?: number;
    difference?: number;
    closingNotes?: string;
    differenceJustification?: string;
    createdAt: string;
    updatedAt: string;
}

/**
 * Cash Movement DTO for offline-to-server sync.
 * Represents income, expenses, and withdrawals recorded on POS.
 */
export interface OfflineCashMovementDto {
    id: UUID;
    cashSessionId: UUID;
    branchId: UUID;
    movementType: 'income' | 'expense' | 'withdrawal' | 'sale';
    category: 'initial_fund' | 'sale' | 'expense' | 'withdrawal' | 'other';
    amount: number;
    concept: string;
    reference?: string;
    userId: UUID;
    movementDate: string;
    createdAt: string;
}

export interface SyncPushDto {
    deviceId: string;
    timestamp: string;
    sales?: OfflineSaleDto[];
    cashMovements?: OfflineCashMovementDto[];
    cashSessions?: OfflineCashSessionDto[];
}

export interface SyncResultDto {
    success: boolean;
    syncedSales: number;
    syncedMovements: number;
    syncedSessions: number;
    errors?: string[];
}
