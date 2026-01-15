import { Body, Controller, HttpCode, HttpStatus, Post } from '@nestjs/common';
import { StockService } from './stock/stock.service';
import { CheckAvailabilityDto } from './dto/check-availability.dto';

@Controller('inventory')
export class InventoryController {
  constructor(private readonly stockService: StockService) {}

  @Post('check-availability')
  @HttpCode(HttpStatus.OK)
  async checkAvailability(@Body() dto: CheckAvailabilityDto) {
    const available = await this.stockService.checkAvailability(
      dto.variantId,
      dto.branchId,
      dto.quantity,
    );
    return { available };
  }
}
