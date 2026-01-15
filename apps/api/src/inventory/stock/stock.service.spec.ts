import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { StockService } from './stock.service';
import { InventoryLot, ProductVariant } from '@qflow/database';

describe('StockService', () => {
  let service: StockService;

  // Mock implementations
  const mockLotRepository = {
    createQueryBuilder: jest.fn(() => ({
      select: jest.fn().mockReturnThis(),
      where: jest.fn().mockReturnThis(),
      andWhere: jest.fn().mockReturnThis(),
      getRawOne: jest.fn().mockResolvedValue({ total: 100 }),
    })),
    findOne: jest.fn(),
    save: jest.fn(),
  };

  const mockVariantRepository = {
    findOne: jest.fn().mockResolvedValue({
      id: 'variant-123',
      product: { id: 'product-123', trackInventory: true },
    }),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        StockService,
        {
          provide: getRepositoryToken(InventoryLot),
          useValue: mockLotRepository,
        },
        {
          provide: getRepositoryToken(ProductVariant),
          useValue: mockVariantRepository,
        },
      ],
    }).compile();

    service = module.get<StockService>(StockService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('checkAvailability', () => {
    it('should return true when stock is sufficient', async () => {
      const result = await service.checkAvailability(
        'variant-123',
        'branch-123',
        10,
      );
      expect(result).toBe(true);
    });

    it('should return true for products that do not track inventory', async () => {
      mockVariantRepository.findOne.mockResolvedValueOnce({
        id: 'service-variant',
        product: { id: 'service-product', trackInventory: false },
      });

      const result = await service.checkAvailability(
        'service-variant',
        'branch-123',
        10,
      );
      expect(result).toBe(true);
    });
  });
});
