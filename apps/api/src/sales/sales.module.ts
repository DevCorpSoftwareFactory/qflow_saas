import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import {
  Sale,
  SaleDetail,
  InventoryLot,
  InventoryMovement,
  CashMovement,
  ProductVariant,
} from '@qflow/database';
import { SalesService } from './sales.service';
import { SalesController } from './sales.controller';
import { InventoryModule } from '../inventory/inventory.module';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Sale,
      SaleDetail,
      InventoryLot,
      InventoryMovement,
      CashMovement,
      ProductVariant,
    ]),
    InventoryModule,
  ],
  providers: [SalesService],
  controllers: [SalesController],
  exports: [SalesService],
})
export class SalesModule {}
