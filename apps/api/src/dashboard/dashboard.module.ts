import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DashboardController } from './dashboard.controller';
import { DashboardService } from './dashboard.service';
import { Sale, CashSession } from '@qflow/database';

@Module({
  imports: [TypeOrmModule.forFeature([Sale, CashSession])],
  controllers: [DashboardController],
  providers: [DashboardService],
})
export class DashboardModule {}
