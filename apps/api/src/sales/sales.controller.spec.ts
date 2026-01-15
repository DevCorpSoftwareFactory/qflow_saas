import { Test, TestingModule } from '@nestjs/testing';
import { SalesController } from './sales.controller';
import { SalesService } from './sales.service';

describe('SalesController', () => {
  let controller: SalesController;

  const mockSalesService = {
    createSale: jest.fn().mockResolvedValue({
      id: 'sale-123',
      saleNumber: 'SALE-1234567890-001',
      totalAmount: 119000,
      status: 'completed',
      saleDate: new Date(),
      subtotal: 100000,
      taxAmount: 19000,
      discountAmount: 0,
      details: [],
      payments: [],
    }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [SalesController],
      providers: [
        {
          provide: SalesService,
          useValue: mockSalesService,
        },
      ],
    }).compile();

    controller = module.get<SalesController>(SalesController);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
