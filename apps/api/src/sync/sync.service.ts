import { Injectable, Logger } from '@nestjs/common';
import { DataSource, EntityManager } from 'typeorm';
import {
    SyncPushDto,
    SyncResultDto,
    OfflineSaleDto,
    OfflineCashSessionDto,
    OfflineCashMovementDto,
} from '@qflow/shared';
import { SalesService } from '../sales/sales.service';
import { CreateSaleDto } from '../sales/dto';
import {
    CashSession,
    CashMovement,
} from '@qflow/database';

@Injectable()
export class SyncService {
    private readonly logger = new Logger(SyncService.name);

    constructor(
        private readonly dataSource: DataSource,
        private readonly salesService: SalesService,
    ) { }

    /**
     * Process a batch of offline data.
     * Each item is processed independently - partial success is allowed.
     */
    async pushBatch(dto: SyncPushDto, tenantId: string): Promise<SyncResultDto> {
        const result: SyncResultDto = {
            success: true,
            syncedSales: 0,
            syncedMovements: 0,
            syncedSessions: 0,
            errors: [],
        };

        this.logger.log(`Processing sync batch from device ${dto.deviceId}`);

        // Process Cash Sessions FIRST (movements reference sessions)
        if (dto.cashSessions && dto.cashSessions.length > 0) {
            for (const sessionDto of dto.cashSessions) {
                try {
                    await this.processOfflineCashSession(sessionDto, tenantId);
                    result.syncedSessions++;
                } catch (error) {
                    this.logger.error(`Failed to sync cash session ${sessionDto.id}`, error);
                    result.errors!.push(
                        `CashSession ${sessionDto.id}: ${error instanceof Error ? error.message : 'Unknown error'}`,
                    );
                }
            }
        }

        // Process Cash Movements
        if (dto.cashMovements && dto.cashMovements.length > 0) {
            for (const movementDto of dto.cashMovements) {
                try {
                    await this.processOfflineCashMovement(movementDto, tenantId);
                    result.syncedMovements++;
                } catch (error) {
                    this.logger.error(`Failed to sync cash movement ${movementDto.id}`, error);
                    result.errors!.push(
                        `CashMovement ${movementDto.id}: ${error instanceof Error ? error.message : 'Unknown error'}`,
                    );
                }
            }
        }

        // Process Sales
        if (dto.sales && dto.sales.length > 0) {
            for (const saleDto of dto.sales) {
                try {
                    await this.processOfflineSale(saleDto, tenantId);
                    result.syncedSales++;
                } catch (error) {
                    this.logger.error(`Failed to sync sale ${saleDto.id}`, error);
                    result.errors!.push(
                        `Sale ${saleDto.id}: ${error instanceof Error ? error.message : 'Unknown error'}`,
                    );
                }
            }
        }

        result.success = result.errors!.length === 0;
        return result;
    }

    /**
     * Process an offline sale.
     */
    private async processOfflineSale(
        offlineSale: OfflineSaleDto,
        tenantId: string,
    ): Promise<void> {
        const createSaleDto: CreateSaleDto = {
            saleNumber: offlineSale.saleNumber,
            saleDate: offlineSale.createdAt,
            customerId: offlineSale.customerId,
            cashierId: offlineSale.cashierId,
            cashSessionId: offlineSale.cashSessionId,
            items: offlineSale.items,
            paymentMethod: 'cash',
            discountAmount: 0,
            branchId: offlineSale.branchId,
        };

        await this.salesService.createSale(createSaleDto, tenantId);
    }

    /**
     * Process an offline cash session.
     * Uses upsert logic - if session already exists, update it.
     */
    private async processOfflineCashSession(
        dto: OfflineCashSessionDto,
        tenantId: string,
    ): Promise<void> {
        await this.dataSource.transaction(async (manager: EntityManager) => {
            const sessionRepo = manager.getRepository(CashSession);

            // Check if session already exists (idempotency)
            const existing = await sessionRepo.findOne({
                where: { id: dto.id, tenantId },
            });

            const status = dto.status === 'closed' ? 'closed' : 'open';

            if (existing) {
                // Update existing session
                this.logger.log(`Updating existing cash session ${dto.id}`);
                await sessionRepo.update(
                    { id: dto.id },
                    {
                        status,
                        systemAmount: dto.systemAmount ?? 0,
                        closingDate: dto.closingDate ? new Date(dto.closingDate) : undefined,
                        declaredAmount: dto.declaredAmount,
                        differenceJustification: dto.differenceJustification,
                        updatedAt: new Date(dto.updatedAt),
                    },
                );
            } else {
                // Create new session
                this.logger.log(`Creating new cash session ${dto.id}`);
                const session = sessionRepo.create({
                    id: dto.id,
                    tenantId,
                    cashRegisterId: dto.cashRegisterId,
                    userId: dto.userId,
                    status,
                    openingDate: new Date(dto.openingDate),
                    closingDate: dto.closingDate ? new Date(dto.closingDate) : undefined,
                    initialAmount: dto.initialAmount,
                    systemAmount: dto.systemAmount ?? dto.initialAmount,
                    declaredAmount: dto.declaredAmount,
                    differenceJustification: dto.differenceJustification,
                    createdAt: new Date(dto.createdAt),
                    updatedAt: new Date(dto.updatedAt),
                });
                await sessionRepo.save(session);
            }
        });
    }

    /**
     * Process an offline cash movement.
     * Uses insert-if-not-exists logic for idempotency.
     */
    private async processOfflineCashMovement(
        dto: OfflineCashMovementDto,
        tenantId: string,
    ): Promise<void> {
        await this.dataSource.transaction(async (manager: EntityManager) => {
            const movementRepo = manager.getRepository(CashMovement);

            // Check if movement already exists (idempotency)
            const existing = await movementRepo.findOne({
                where: { id: dto.id, tenantId },
            });

            if (existing) {
                this.logger.log(`Cash movement ${dto.id} already exists, skipping`);
                return;
            }

            this.logger.log(`Creating cash movement ${dto.id}`);
            const movement = movementRepo.create({
                id: dto.id,
                tenantId,
                branchId: dto.branchId,
                cashSessionId: dto.cashSessionId,
                movementType: dto.movementType,
                category: dto.category,
                amount: dto.amount,
                concept: dto.concept,
                reference: dto.reference,
                createdBy: dto.userId,
            });
            await movementRepo.save(movement);

            // Update session systemAmount if needed
            const delta = dto.movementType === 'income' || dto.movementType === 'sale' ? dto.amount : -dto.amount;
            await manager.increment(
                CashSession,
                { id: dto.cashSessionId },
                'systemAmount',
                delta,
            );
        });
    }
}
