import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import {
  Product,
  ProductCategory,
  ProductVariant,
  PriceList,
  PriceListItem,
  Brand,
  UnitOfMeasure,
  Customer,
} from '@qflow/database';
import { CatalogController } from './catalog.controller';
import { CatalogService } from './catalog.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Product,
      ProductCategory,
      ProductVariant,
      PriceList,
      PriceListItem,
      Customer,
      Brand,
      UnitOfMeasure,
    ]),
  ],
  controllers: [CatalogController],
  providers: [CatalogService],
  exports: [CatalogService],
})
export class CatalogModule {}
