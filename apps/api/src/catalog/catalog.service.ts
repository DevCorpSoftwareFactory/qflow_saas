import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import {
    Product,
    ProductCategory,
    ProductVariant,
    PriceList,
    Customer,
    Brand,
    UnitOfMeasure,
} from '@qflow/database';

@Injectable()
export class CatalogService {
    constructor(
        @InjectRepository(ProductCategory)
        private readonly categoryRepo: Repository<ProductCategory>,
        @InjectRepository(Product)
        private readonly productRepo: Repository<Product>,
        @InjectRepository(PriceList)
        private readonly priceListRepo: Repository<PriceList>,
        @InjectRepository(Customer)
        private readonly customerRepo: Repository<Customer>,
        @InjectRepository(Brand)
        private readonly brandRepo: Repository<Brand>,
        @InjectRepository(UnitOfMeasure)
        private readonly unitRepo: Repository<UnitOfMeasure>,
    ) { }

    async getCategories(tenantId: string) {
        const items = await this.categoryRepo.find({
            where: { tenantId, isActive: true },
        });
        return { items };
    }

    async getProducts(tenantId: string) {
        const items = await this.productRepo.find({
            where: { tenantId, isActive: true },
            relations: ['variants'],
        });
        return { items };
    }

    async getPriceLists(tenantId: string) {
        const items = await this.priceListRepo.find({
            where: { tenantId, isActive: true },
            relations: ['items'],
        });
        return { items };
    }

    async getCustomers(tenantId: string) {
        const items = await this.customerRepo.find({
            where: { tenantId, status: 'active' as any }, // Cast if enum mismatch
        });
        return { items };
    }

    async getBrands(tenantId: string) {
        const items = await this.brandRepo.find({
            where: { tenantId, isActive: true },
        });
        return { items };
    }

    async getUnits(tenantId: string) {
        const items = await this.unitRepo.find({
            where: { tenantId, isActive: true },
        });
        return { items };
    }
}
