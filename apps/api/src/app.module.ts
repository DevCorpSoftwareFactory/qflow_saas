import { Module } from '@nestjs/common';
import { ConfigModule } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { AppDataSource } from '@qflow/database';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InventoryModule } from './inventory/inventory.module';
import { SalesModule } from './sales/sales.module';
import { MetricsModule } from './metrics/metrics.module';
import { CatalogModule } from './catalog/catalog.module';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    TypeOrmModule.forRootAsync({
      useFactory: () => AppDataSource.options,
    }),
    MetricsModule,
    AuthModule,
    InventoryModule,
    SalesModule,
    CatalogModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule { }
