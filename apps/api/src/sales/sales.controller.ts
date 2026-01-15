import {
  Body,
  Controller,
  Post,
  HttpCode,
  HttpStatus,
  UseGuards,
  Req,
} from '@nestjs/common';
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
    @Req() req: any,
  ): Promise<SaleResponseDto> {
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    const tenantId = req.user.tenantId as string;
    // eslint-disable-next-line @typescript-eslint/no-unsafe-member-access
    console.log('[CreateSale] User:', req.user);
    console.log('[CreateSale] TenantID:', tenantId);
    console.log('[CreateSale] DTO:', JSON.stringify(dto));
    const sale = await this.salesService.createSale(dto, tenantId);
    return SaleResponseDto.fromEntity(sale);
  }
}
