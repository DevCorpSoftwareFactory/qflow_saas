import { Module } from '@nestjs/common';
import { ConfigModule, ConfigService } from '@nestjs/config';
import { TypeOrmModule } from '@nestjs/typeorm';
import { AuthModule } from './auth/auth.module';
import { AppDataSource } from '@qflow/database';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { InventoryModule } from './inventory/inventory.module';
import { SalesModule } from './sales/sales.module';
import { MetricsModule } from './metrics/metrics.module';
import { CatalogModule } from './catalog/catalog.module';
import {
  appConfig,
  databaseConfig,
  authConfig,
  supabaseConfig,
} from './app.config';
import { validate } from './environment';
import { CashSessionModule } from './cash-session/cash-session.module';
import { SyncModule } from './sync/sync.module';
import { HealthModule } from './health/health.module';
import { DashboardModule } from './dashboard/dashboard.module';
import { UsersModule } from './users/users.module';
import { SettingsModule } from './settings/settings.module';
import { ThrottlerModule, ThrottlerGuard } from '@nestjs/throttler';
import { LoggerModule } from 'nestjs-pino';
import { APP_GUARD } from '@nestjs/core';
import { AuditModule } from './audit/audit.module';

@Module({
  imports: [
    // Structured Logging
    LoggerModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (config: ConfigService) => {
        const isProduction = config.get('app.nodeEnv') === 'production';
        return {
          pinoHttp: {
            level: isProduction ? 'info' : 'debug',
            // Use pino-pretty in dev
            transport: isProduction
              ? undefined
              : {
                  target: 'pino-pretty',
                  options: {
                    singleLine: true,
                    translateTime: 'SYS:standard',
                    ignore: 'pid,hostname',
                  },
                },
            // Redact sensitive data
            redact: ['req.headers.authorization'],
            // Exclude health checks from logs to reduce noise
            autoLogging: {
              ignore: (req: any) =>
                req.url?.includes('/health') ||
                req.url?.includes('/api/v1/health'),
            },
          },
        };
      },
    }),

    // Configuration with validation
    ConfigModule.forRoot({
      isGlobal: true,
      load: [appConfig, databaseConfig, authConfig, supabaseConfig],
      validate,
      cache: true,
      expandVariables: true,
    }),

    // Rate Limiting (DoS Protection)
    ThrottlerModule.forRoot([
      {
        ttl: 60000, // 1 minute
        limit: 100, // 100 requests per minute
      },
    ]),

    // Database connection
    TypeOrmModule.forRootAsync({
      imports: [ConfigModule],
      inject: [ConfigService],
      useFactory: (configService: ConfigService) => ({
        ...AppDataSource.options,
        synchronize: configService.get('database.synchronize'),
        logging: configService.get('database.logging'),
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
    HealthModule,
    DashboardModule,
    UsersModule,
    SettingsModule,
    AuditModule,
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
export class AppModule {}
