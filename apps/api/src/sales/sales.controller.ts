import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  UseGuards,
} from '@nestjs/common';
import { CurrentUser } from '../auth/decorators';
import { JwtUser } from '../auth/interfaces/jwt-user.interface';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { SalesService } from './sales.service';
import { CreateSaleDto, SaleResponseDto } from './dto';

@Controller('sales')
@UseGuards(JwtAuthGuard)
export class SalesController {
  constructor(private readonly salesService: SalesService) {}

  @Post()
  @HttpCode(HttpStatus.CREATED)
  async createSale(
    @Body() dto: CreateSaleDto,
    @CurrentUser() user: JwtUser,
  ): Promise<SaleResponseDto> {
    const tenantId = user.tenantId;
    console.log('[CreateSale] User:', user);
    console.log('[CreateSale] TenantID:', tenantId);
    console.log('[CreateSale] DTO:', JSON.stringify(dto));
    const sale = await this.salesService.createSale(dto, tenantId);
    return SaleResponseDto.fromEntity(sale);
  }
}
