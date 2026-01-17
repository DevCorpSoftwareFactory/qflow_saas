import { Injectable, BadRequestException, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository, DataSource } from 'typeorm';
import { CashMovement, CashSession } from '@qflow/database';
import { CreateCashMovementDto } from '@qflow/shared';
import { CashSessionService } from './cash-session.service';

@Injectable()
export class CashMovementsService {
    constructor(
        private readonly dataSource: DataSource,
        @InjectRepository(CashMovement)
        private readonly movementRepo: Repository<CashMovement>,
        private readonly cashSessionService: CashSessionService,
    ) { }

    async create(
        tenantId: string,
        userId: string,
        dto: CreateCashMovementDto,
    ): Promise<CashMovement> {
        // 1. Get active session for user
        const session = await this.cashSessionService.getActiveSession({
            userId,
            tenantId,
            email: '',
        } as any);

        if (!session) {
            throw new BadRequestException('No active cash session found for user');
        }

        if (!session.cashRegister?.branchId) {
            throw new BadRequestException('Active session is not linked to a valid branch');
        }

        return this.dataSource.transaction(async (manager) => {
            // 2. Create movement
            const movement = manager.create(CashMovement, {
                tenantId,
                branchId: session.cashRegister.branchId,
                cashSessionId: session.id,
                movementType: dto.movementType,
                amount: dto.amount,
                concept: dto.concept,
                category: dto.category,
                reference: dto.reference,
                evidenceUrl: dto.evidenceUrl,
                createdBy: userId, // Assuming createdBy is the field for user tracking
            });

            const saved = await manager.save(movement);

            // 3. Update session system_amount
            // Income/Deposit increases system amount?
            // - Income: +Amount
            // - Expense: -Amount
            // - Withdrawal: -Amount
            // - Transfer In: +Amount
            // - Transfer Out: -Amount

            let delta = 0;
            switch (dto.movementType) {
                case 'income':
                case 'transfer_in':
                    delta = dto.amount;
                    break;
                case 'expense':
                case 'withdrawal':
                case 'transfer_out':
                    delta = -dto.amount;
                    break;
            }

            if (delta !== 0) {
                await manager.increment(CashSession, { id: session.id }, 'systemAmount', delta);
            }

            return saved;
        });
    }
}
