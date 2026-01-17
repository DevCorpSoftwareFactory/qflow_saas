import {
    Controller,
    Get,
    Post,
    Body,
    Param,
    UseGuards,
} from '@nestjs/common';
import { CashSessionService } from './cash-session.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators';
import { OpenSessionDto, CloseSessionDto } from '@qflow/shared';
import { JwtUser } from '../auth/interfaces/jwt-user.interface';

@Controller('cash-sessions')
@UseGuards(JwtAuthGuard)
export class CashSessionController {
    constructor(private readonly cashSessionService: CashSessionService) { }

    @Post('open')
    openSession(
        @CurrentUser() user: JwtUser,
        @Body() dto: OpenSessionDto,
    ) {
        return this.cashSessionService.openSession(user, dto);
    }

    @Post(':id/close')
    closeSession(
        @CurrentUser() user: JwtUser,
        @Param('id') id: string,
        @Body() dto: CloseSessionDto,
    ) {
        return this.cashSessionService.closeSession(user, id, dto);
    }

    @Get('active')
    getActiveSession(@CurrentUser() user: JwtUser) {
        return this.cashSessionService.getActiveSession(user);
    }
}
