import { Test, TestingModule } from '@nestjs/testing';
import { SyncService } from './sync.service';
import { DataSource } from 'typeorm';
import { SalesService } from '../sales/sales.service';

describe('SyncService', () => {
  let service: SyncService;

  const mockDataSource = {
    transaction: jest.fn(),
  };

  const mockSalesService = {
    createSale: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SyncService,
        { provide: DataSource, useValue: mockDataSource },
        { provide: SalesService, useValue: mockSalesService },
      ],
    }).compile();

    service = module.get<SyncService>(SyncService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
