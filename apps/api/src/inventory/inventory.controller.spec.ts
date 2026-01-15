import { Test, TestingModule } from '@nestjs/testing';
import { InventoryController } from './inventory.controller';
import { StockService } from './stock/stock.service';

describe('InventoryController', () => {
  let controller: InventoryController;
  let stockService: StockService;

  const mockStockService = {
    checkAvailability: jest.fn().mockResolvedValue(true),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [InventoryController],
      providers: [
        {
          provide: StockService,
          useValue: mockStockService,
        },
      ],
    }).compile();

    controller = module.get<InventoryController>(InventoryController);
    stockService = module.get<StockService>(StockService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('checkAvailability', () => {
    it('should return availability status', async () => {
      const dto = {
        variantId: 'variant-123',
        branchId: 'branch-123',
        quantity: 10,
      };

      const result = await controller.checkAvailability(dto);

      expect(stockService.checkAvailability).toHaveBeenCalledWith(
        dto.variantId,
        dto.branchId,
        dto.quantity,
      );
      expect(result).toEqual({ available: true });
    });
  });
});
