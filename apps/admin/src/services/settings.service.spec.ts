import { SettingsService, CompanySettings, TaxSettings, DocumentSettings, SecuritySettings } from './settings.service';
import api from '@/lib/api';
import {
    UpdateCompanyDto,
    UpdateDocumentsDto,
    UpdateSecurityDto,
    UpdateTaxesDto,
} from '@qflow/shared';

jest.mock('@/lib/api', () => ({
    get: jest.fn(),
    patch: jest.fn(),
    interceptors: {
        request: { use: jest.fn() },
        response: { use: jest.fn() },
    },
}));

describe('SettingsService', () => {
    beforeEach(() => {
        jest.clearAllMocks();
    });

    describe('Company Settings', () => {
        const mockCompanySettings: CompanySettings = {
            name: 'Test Corp',
            nit: '123456789',
            email: 'test@corp.com',
            currency: 'USD',
            timezone: 'UTC',
            dateFormat: 'YYYY-MM-DD',
        };

        it('should fetch company settings', async () => {
            (api.get as jest.Mock).mockResolvedValue({ data: mockCompanySettings });
            const result = await SettingsService.getCompanySettings();
            expect(api.get).toHaveBeenCalledWith('/settings/company');
            expect(result).toEqual(mockCompanySettings);
        });

        it('should update company settings', async () => {
            const dto: UpdateCompanyDto = { name: 'New Corp', nit: '123456789' };
            const updatedSettings = { ...mockCompanySettings, ...dto };
            (api.patch as jest.Mock).mockResolvedValue({ data: updatedSettings });

            const result = await SettingsService.updateCompanySettings(dto);
            expect(api.patch).toHaveBeenCalledWith('/settings/company', dto);
            expect(result).toEqual(updatedSettings);
        });
    });

    describe('Tax Settings', () => {
        const mockTaxSettings: TaxSettings = {
            configuredRates: [{ name: 'VAT', rate: 19 }],
            pricesIncludeTax: true,
        };

        it('should fetch tax settings', async () => {
            (api.get as jest.Mock).mockResolvedValue({ data: mockTaxSettings });
            const result = await SettingsService.getTaxSettings();
            expect(api.get).toHaveBeenCalledWith('/settings/taxes');
            expect(result).toEqual(mockTaxSettings);
        });

        it('should update tax settings', async () => {
            const dto: UpdateTaxesDto = { pricesIncludeTax: false };
            const updatedSettings = { ...mockTaxSettings, ...dto };
            (api.patch as jest.Mock).mockResolvedValue({ data: updatedSettings });

            const result = await SettingsService.updateTaxSettings(dto);
            expect(api.patch).toHaveBeenCalledWith('/settings/taxes', dto);
            expect(result).toEqual(updatedSettings);
        });
    });

    describe('Document Settings', () => {
        const mockDocSettings: DocumentSettings = {
            invoice: { prefix: 'INV', currentNumber: 100 },
        };

        it('should fetch document settings', async () => {
            (api.get as jest.Mock).mockResolvedValue({ data: mockDocSettings });
            const result = await SettingsService.getDocumentSettings();
            expect(api.get).toHaveBeenCalledWith('/settings/documents');
            expect(result).toEqual(mockDocSettings);
        });

        it('should update document settings', async () => {
            const dto: UpdateDocumentsDto = { invoice: { prefix: 'FAC', currentNumber: 101 } };
            const updatedSettings = { ...mockDocSettings, ...dto };
            (api.patch as jest.Mock).mockResolvedValue({ data: updatedSettings });

            const result = await SettingsService.updateDocumentSettings(dto);
            expect(api.patch).toHaveBeenCalledWith('/settings/documents', dto);
            expect(result).toEqual(updatedSettings);
        });
    });

    describe('Security Settings', () => {
        const mockSecuritySettings: SecuritySettings = {
            sessionTimeoutMinutes: 30,
            minPasswordLength: 8,
            passwordExpiryDays: 90,
            maxLoginAttempts: 3,
        };

        it('should fetch security settings', async () => {
            (api.get as jest.Mock).mockResolvedValue({ data: mockSecuritySettings });
            const result = await SettingsService.getSecuritySettings();
            expect(api.get).toHaveBeenCalledWith('/settings/security');
            expect(result).toEqual(mockSecuritySettings);
        });

        it('should update security settings', async () => {
            const dto: UpdateSecurityDto = { sessionTimeoutMinutes: 60 };
            const updatedSettings = { ...mockSecuritySettings, ...dto };
            (api.patch as jest.Mock).mockResolvedValue({ data: updatedSettings });

            const result = await SettingsService.updateSecuritySettings(dto);
            expect(api.patch).toHaveBeenCalledWith('/settings/security', dto);
            expect(result).toEqual(updatedSettings);
        });
    });
});
