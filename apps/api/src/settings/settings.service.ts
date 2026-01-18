import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { Tenant } from '@qflow/database';
import {
  UpdateCompanyDto,
  UpdateTaxesDto,
  UpdateDocumentsDto,
  UpdateSecurityDto,
} from '@qflow/shared';

@Injectable()
export class SettingsService {
  constructor(
    @InjectRepository(Tenant)
    private readonly tenantRepository: Repository<Tenant>,
  ) {}

  async getCompanySettings(tenantId: string) {
    const tenant = await this.getTenant(tenantId);

    // Combining entity fields to DTO shape
    return {
      name: tenant.companyName,
      nit: tenant.taxId,
      address: tenant.address,
      phone: tenant.phone,
      email: tenant.email,
      website: tenant.website,
      logoUrl: tenant.logoUrl,
      primaryColor: tenant.primaryColor,
      currency: tenant.currency || 'COP',
      timezone: tenant.timezone || 'America/Bogota',
      dateFormat: 'DD/MM/YYYY', // Default, not yet in entity
    };
  }

  async updateCompanySettings(tenantId: string, dto: UpdateCompanyDto) {
    const tenant = await this.getTenant(tenantId);

    // Auto-map fields
    Object.assign(tenant, dto);

    await this.tenantRepository.save(tenant);
    return this.getCompanySettings(tenantId);
  }

  async getTaxSettings(tenantId: string) {
    const tenant = await this.getTenant(tenantId);
    return {
      taxRegime: tenant.taxInformation?.taxRegime,
      configuredRates: tenant.taxInformation?.configuredRates || [],
      pricesIncludeTax: tenant.taxInformation?.pricesIncludeTax || false,
    };
  }

  async updateTaxSettings(tenantId: string, dto: UpdateTaxesDto) {
    const tenant = await this.getTenant(tenantId);

    tenant.taxInformation = {
      ...tenant.taxInformation,
      ...dto,
    };

    await this.tenantRepository.save(tenant);
    return this.getTaxSettings(tenantId);
  }

  async getDocumentSettings(tenantId: string) {
    const tenant = await this.getTenant(tenantId);
    return tenant.documentSettings || {};
  }

  async updateDocumentSettings(tenantId: string, dto: UpdateDocumentsDto) {
    const tenant = await this.getTenant(tenantId);

    tenant.documentSettings = {
      ...tenant.documentSettings,
      ...dto,
    };

    await this.tenantRepository.save(tenant);
    return this.getDocumentSettings(tenantId);
  }

  async getSecuritySettings(tenantId: string) {
    const tenant = await this.getTenant(tenantId);
    return (
      tenant.securitySettings || {
        sessionTimeoutMinutes: 30,
        minPasswordLength: 8,
        passwordExpiryDays: 90,
        maxLoginAttempts: 5,
      }
    );
  }

  async updateSecuritySettings(tenantId: string, dto: UpdateSecurityDto) {
    const tenant = await this.getTenant(tenantId);
    tenant.securitySettings = {
      ...tenant.securitySettings,
      ...dto,
    };
    await this.tenantRepository.save(tenant);
    return this.getSecuritySettings(tenantId);
  }

  private async getTenant(tenantId: string): Promise<Tenant> {
    const tenant = await this.tenantRepository.findOne({
      where: { id: tenantId },
    });
    if (!tenant) throw new NotFoundException('Tenant not found');
    return tenant;
  }
}
