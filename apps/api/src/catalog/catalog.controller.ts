import {
  Controller,
  Get,
  Req,
  UseGuards,
  HttpCode,
  HttpStatus,
} from '@nestjs/common';
import { Request } from 'express';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { CatalogService } from './catalog.service';

interface RequestWithUser extends Request {
  user: {
    userId: string;
    tenantId: string;
    email: string;
  };
}

@Controller('catalog')
@UseGuards(JwtAuthGuard)
export class CatalogController {
  constructor(private readonly catalogService: CatalogService) {}

  @Get('categories')
  @HttpCode(HttpStatus.OK)
  async getCategories(@Req() req: RequestWithUser) {
    return this.catalogService.getCategories(req.user.tenantId);
  }

  @Get('products')
  @HttpCode(HttpStatus.OK)
  async getProducts(@Req() req: RequestWithUser) {
    return this.catalogService.getProducts(req.user.tenantId);
  }

  @Get('price-lists')
  @HttpCode(HttpStatus.OK)
  async getPriceLists(@Req() req: RequestWithUser) {
    return this.catalogService.getPriceLists(req.user.tenantId);
  }

  @Get('customers')
  @HttpCode(HttpStatus.OK)
  async getCustomers(@Req() req: RequestWithUser) {
    return this.catalogService.getCustomers(req.user.tenantId);
  }

  @Get('brands')
  @HttpCode(HttpStatus.OK)
  async getBrands(@Req() req: RequestWithUser) {
    return this.catalogService.getBrands(req.user.tenantId);
  }

  @Get('units')
  @HttpCode(HttpStatus.OK)
  async getUnits(@Req() req: RequestWithUser) {
    return this.catalogService.getUnits(req.user.tenantId);
  }
}
