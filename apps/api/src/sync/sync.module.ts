import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { SyncService } from './sync.service';
import { SyncController } from './sync.controller';
import { SalesModule } from '../sales/sales.module';

@Module({
  imports: [
    SalesModule, // Import SalesModule to use SalesService
  ],
  controllers: [SyncController],
  providers: [SyncService],
})
export class SyncModule {}
