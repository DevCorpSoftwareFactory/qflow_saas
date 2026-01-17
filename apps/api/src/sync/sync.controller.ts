import { Controller, Post, Body, UseGuards } from '@nestjs/common';
import { SyncService } from './sync.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators';
import { SyncPushDto } from '@qflow/shared';
import { JwtUser } from '../auth/interfaces/jwt-user.interface';

@Controller('sync')
@UseGuards(JwtAuthGuard)
export class SyncController {
    constructor(private readonly syncService: SyncService) { }

    @Post('push')
    pushBatch(@CurrentUser() user: JwtUser, @Body() dto: SyncPushDto) {
        return this.syncService.pushBatch(dto, user.tenantId);
    }
}
