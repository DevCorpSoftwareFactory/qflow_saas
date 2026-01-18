import {
  Body,
  Controller,
  Get,
  Patch,
  Request,
  UseGuards,
} from '@nestjs/common';
import { ApiBearerAuth, ApiOperation, ApiTags } from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { SettingsService } from './settings.service';
import {
  UpdateCompanyDto,
  UpdateTaxesDto,
  UpdateDocumentsDto,
  UpdateSecurityDto,
} from '@qflow/shared';
import { AuthenticatedRequest } from '../common/types';

@ApiTags('Settings')
@ApiBearerAuth()
@UseGuards(JwtAuthGuard)
@Controller('settings')
export class SettingsController {
  constructor(private readonly settingsService: SettingsService) {}

  // Company
  @Get('company')
  @ApiOperation({ summary: 'Get company and regional settings' })
  getCompanySettings(@Request() req: AuthenticatedRequest) {
    return this.settingsService.getCompanySettings(req.user.tenantId);
  }

  @Patch('company')
  @ApiOperation({ summary: 'Update company and regional settings' })
  updateCompanySettings(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateCompanyDto,
  ) {
    return this.settingsService.updateCompanySettings(req.user.tenantId, dto);
  }

  // Taxes
  @Get('taxes')
  @ApiOperation({ summary: 'Get tax configuration' })
  getTaxSettings(@Request() req: AuthenticatedRequest) {
    return this.settingsService.getTaxSettings(req.user.tenantId);
  }

  @Patch('taxes')
  @ApiOperation({ summary: 'Update tax configuration' })
  updateTaxSettings(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateTaxesDto,
  ) {
    return this.settingsService.updateTaxSettings(req.user.tenantId, dto);
  }

  // Documents
  @Get('documents')
  @ApiOperation({ summary: 'Get document numbering settings' })
  getDocumentSettings(@Request() req: AuthenticatedRequest) {
    return this.settingsService.getDocumentSettings(req.user.tenantId);
  }

  @Patch('documents')
  @ApiOperation({ summary: 'Update document numbering settings' })
  updateDocumentSettings(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateDocumentsDto,
  ) {
    return this.settingsService.updateDocumentSettings(req.user.tenantId, dto);
  }

  // Security
  @Get('security')
  @ApiOperation({ summary: 'Get security policies (session, password)' })
  getSecuritySettings(@Request() req: AuthenticatedRequest) {
    return this.settingsService.getSecuritySettings(req.user.tenantId);
  }

  @Patch('security')
  @ApiOperation({ summary: 'Update security policies' })
  updateSecuritySettings(
    @Request() req: AuthenticatedRequest,
    @Body() dto: UpdateSecurityDto,
  ) {
    return this.settingsService.updateSecuritySettings(req.user.tenantId, dto);
  }
}
