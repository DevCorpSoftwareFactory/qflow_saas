import { Test, TestingModule } from '@nestjs/testing';
import { DataSource } from 'typeorm';
import { SalesService } from './sales.service';
import { StockService } from '../inventory/stock/stock.service';

describe('SalesService', () => {
  let service: SalesService;

  const mockDataSource = {
    transaction: jest.fn(),
    createQueryRunner: jest.fn(),
  };

  const mockStockService = {
    checkAvailability: jest.fn().mockResolvedValue(true),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SalesService,
        {
          provide: DataSource,
          useValue: mockDataSource,
        },
        {
          provide: StockService,
          useValue: mockStockService,
        },
      ],
    }).compile();

    service = module.get<SalesService>(SalesService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
