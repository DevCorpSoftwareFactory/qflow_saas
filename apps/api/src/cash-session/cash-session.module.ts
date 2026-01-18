import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CashSessionService } from './cash-session.service';
import { CashSessionController } from './cash-session.controller';
import { CashMovementsService } from './cash-movements.service';
import { CashMovementsController } from './cash-movements.controller';
import { CashSession, CashMovement, User, CashRegister } from '@qflow/database';

@Module({
  imports: [
    TypeOrmModule.forFeature([CashSession, CashMovement, User, CashRegister]),
  ],
  controllers: [CashSessionController, CashMovementsController],
  providers: [CashSessionService, CashMovementsService],
  exports: [CashSessionService, CashMovementsService], // Export service for SyncModule
})
export class CashSessionModule {}
