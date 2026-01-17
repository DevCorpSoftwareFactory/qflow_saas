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
import { appConfig, databaseConfig, authConfig, supabaseConfig } from './app.config';
import { validate } from './environment';
import { CashSessionModule } from './cash-session/cash-session.module';
import { SyncModule } from './sync/sync.module';
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { APP_GUARD } from '@nestjs/core';

@Module({
  imports: [
    // Configuration with validation
    ConfigModule.forRoot({
      isGlobal: true,
      load: [appConfig, databaseConfig, authConfig, supabaseConfig],
      validate,
      cache: true,
      expandVariables: true,
    }),

    // Rate Limiting (DoS Protection)
    ThrottlerModule.forRoot([{
      ttl: 60000, // 1 minute
      limit: 100, // 100 requests per minute
    }]),

    // Database connection
    TypeOrmModule.forRootAsync({
      useFactory: () => ({
        ...AppDataSource.options,
        autoLoadEntities: true,
      }),
    }),

    // Feature modules
    MetricsModule,
    AuthModule,
    InventoryModule,
    SalesModule,
    CatalogModule,
    CashSessionModule,
    SyncModule,
  ],
  controllers: [AppController],
  providers: [
    AppService,
    {
      provide: APP_GUARD,
      useClass: ThrottlerGuard,
    },
  ],
})
export class AppModule { }
