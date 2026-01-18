import { UpdateCompanyDto, UpdateDocumentsDto, UpdateSecurityDto, UpdateTaxesDto } from '@qflow/shared';
import api from '@/lib/api';
import { logger } from '@/services/logger.service';

export interface CompanySettings {
  name: string;
  nit: string;
  address?: string;
  phone?: string;
  email: string;
  website?: string;
  logoUrl?: string;
  primaryColor?: string;
  currency: string;
  timezone: string;
  dateFormat: string;
}

export interface TaxSettings {
  taxRegime?: string;
  configuredRates: { name: string; rate: number }[];
  pricesIncludeTax: boolean;
}

export interface DocumentSettings {
  invoice?: { prefix: string; currentNumber: number; resolutionText?: string; resolutionDate?: string };
  posTicket?: { prefix: string; currentNumber: number };
  creditNote?: { prefix: string; currentNumber: number };
  debitNote?: { prefix: string; currentNumber: number };
}

export interface SecuritySettings {
  sessionTimeoutMinutes: number;
  minPasswordLength: number;
  passwordExpiryDays: number;
  maxLoginAttempts: number;
}

export const SettingsService = {
  getCompanySettings: async (): Promise<CompanySettings> => {
    logger.logApiRequest('GET', '/settings/company');
    try {
      const response = await api.get<CompanySettings>('/settings/company');
      logger.logApiResponse(200, '/settings/company', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/company', error);
      throw error;
    }
  },

  updateCompanySettings: async (dto: UpdateCompanyDto): Promise<CompanySettings> => {
    logger.logApiRequest('PATCH', '/settings/company', dto);
    try {
      const response = await api.patch<CompanySettings>('/settings/company', dto);
      logger.logApiResponse(200, '/settings/company', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/company', error);
      throw error;
    }
  },

  getTaxSettings: async (): Promise<TaxSettings> => {
    logger.logApiRequest('GET', '/settings/taxes');
    try {
      const response = await api.get<TaxSettings>('/settings/taxes');
      logger.logApiResponse(200, '/settings/taxes', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/taxes', error);
      throw error;
    }
  },

  updateTaxSettings: async (dto: UpdateTaxesDto): Promise<TaxSettings> => {
    logger.logApiRequest('PATCH', '/settings/taxes', dto);
    try {
      const response = await api.patch<TaxSettings>('/settings/taxes', dto);
      logger.logApiResponse(200, '/settings/taxes', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/taxes', error);
      throw error;
    }
  },

  getDocumentSettings: async (): Promise<DocumentSettings> => {
    logger.logApiRequest('GET', '/settings/documents');
    try {
      const response = await api.get<DocumentSettings>('/settings/documents');
      logger.logApiResponse(200, '/settings/documents', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/documents', error);
      throw error;
    }
  },

  updateDocumentSettings: async (dto: UpdateDocumentsDto): Promise<DocumentSettings> => {
    logger.logApiRequest('PATCH', '/settings/documents', dto);
    try {
      const response = await api.patch<DocumentSettings>('/settings/documents', dto);
      logger.logApiResponse(200, '/settings/documents', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/documents', error);
      throw error;
    }
  },

  getSecuritySettings: async (): Promise<SecuritySettings> => {
    logger.logApiRequest('GET', '/settings/security');
    try {
      const response = await api.get<SecuritySettings>('/settings/security');
      logger.logApiResponse(200, '/settings/security', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/security', error);
      throw error;
    }
  },

  updateSecuritySettings: async (dto: UpdateSecurityDto): Promise<SecuritySettings> => {
    logger.logApiRequest('PATCH', '/settings/security', dto);
    try {
      const response = await api.patch<SecuritySettings>('/settings/security', dto);
      logger.logApiResponse(200, '/settings/security', response.data);
      return response.data;
    } catch (error) {
      logger.logApiError(0, '/settings/security', error);
      throw error;
    }
  },
};
