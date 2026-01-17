import { Body, Controller, Post, UseGuards } from '@nestjs/common';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CurrentUser } from '../auth/decorators';
import { JwtUser } from '../auth/interfaces/jwt-user.interface';
import { CashMovementsService } from './cash-movements.service';
import { CreateCashMovementDto } from '@qflow/shared';

@Controller('cash-movements')
@UseGuards(JwtAuthGuard)
export class CashMovementsController {
    constructor(private readonly movementsService: CashMovementsService) { }

    @Post()
    async create(
        @CurrentUser() user: JwtUser,
        @Body() dto: CreateCashMovementDto,
    ) {
        return this.movementsService.create(user.tenantId, user.userId, dto);
    }
}
