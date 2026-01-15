import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { InventoryLot, ProductVariant } from '@qflow/database';
import { StockService } from './stock/stock.service';
import { InventoryController } from './inventory.controller';

@Module({
  imports: [TypeOrmModule.forFeature([InventoryLot, ProductVariant])],
  providers: [StockService],
  controllers: [InventoryController],
  exports: [StockService],
})
export class InventoryModule {}
