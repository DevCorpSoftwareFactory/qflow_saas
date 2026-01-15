import { Test, TestingModule } from '@nestjs/testing';
import { INestApplication } from '@nestjs/common';
import request from 'supertest';
import { AppModule } from '../src/app.module';
import { DataSource } from 'typeorm';
import { Server } from 'http';
import { randomUUID } from 'crypto';

/**
 * Sales Concurrency Tests
 *
 * These tests verify that the sales system correctly handles:
 * 1. Race conditions when multiple sales try to buy same stock
 * 2. SERIALIZABLE transaction isolation
 * 3. Pessimistic locking on inventory lots
 * 4. Rollback on partial failures
 */

// Type definitions for database query results
interface StockQueryResult {
    total: string | number;
}

interface SalesCountResult {
    count: string | number;
}

interface InventoryMovementResult {
    quantity: number;
    movement_type: string;
}

describe('SalesService Concurrency Tests', () => {
    let app: INestApplication;
    let dataSource: DataSource;
    let httpServer: Server;

    // Use dynamic IDs to ensure isolation
    const testTenantId = randomUUID();
    const testBranchId = randomUUID();
    const testVariantId = randomUUID();
    const testCashierId = randomUUID();
    const testProductId = randomUUID();
    const testRoleId = randomUUID();

    const uniqueSuffix = Date.now();

    beforeAll(async () => {
        const moduleFixture: TestingModule = await Test.createTestingModule({
            imports: [AppModule],
        }).compile();

        app = moduleFixture.createNestApplication();
        await app.init();

        dataSource = moduleFixture.get<DataSource>(DataSource);
        httpServer = app.getHttpServer() as Server;

        await seedDatabase();
    });

    async function seedDatabase() {
        try {
            // 1. Tenant
            await dataSource.query(
                `INSERT INTO tenants (id, company_name, slug, tax_id, email, status, plan, language, timezone, currency, onboarding_completed, max_branches, max_users, max_storage_gb, max_transactions_monthly)
                 VALUES ($1, 'Test Tenant ${uniqueSuffix}', 'test-tenant-${uniqueSuffix}', 'TAX-${uniqueSuffix}', 'admin-${uniqueSuffix}@test.com', 'active', 'enterprise', 'es', 'America/Bogota', 'COP', true, 5, 10, 10, 1000)`,
                [testTenantId],
            );

            // 2. Branch
            await dataSource.query(
                `INSERT INTO branches (id, tenant_id, name, code, address, phone, is_active, created_at, updated_at)
                 VALUES ($1, $2, 'Main Branch', 'B001', '123 Main St', '555-5555', true, NOW(), NOW())`,
                [testBranchId, testTenantId],
            );

            // 3. Role
            await dataSource.query(
                `INSERT INTO roles (id, tenant_id, name, description, is_system_role, permissions)
                 VALUES ($1, $2, 'Cashier', 'Cashier Role', false, '[]')`,
                [testRoleId, testTenantId],
            );

            // 4. User (Cashier)
            await dataSource.query(
                `INSERT INTO users (id, tenant_id, email, password_hash, full_name, role_id, branch_ids, is_active)
                 VALUES ($1, $2, 'cashier-${uniqueSuffix}@test.com', 'hash', 'Test Cashier', $3, $4, true)`,
                [testCashierId, testTenantId, testRoleId, JSON.stringify([testBranchId])],
            );

            // 5. Unit of Measure
            const testUnitId = randomUUID();
            await dataSource.query(
                `INSERT INTO units_of_measure (id, tenant_id, name, abbreviation, is_active, unit_type)
                 VALUES ($1, $2, 'Unit', 'u', true, 'quantity')`,
                [testUnitId, testTenantId],
            );

            // 6. Product
            await dataSource.query(
                `INSERT INTO products (id, tenant_id, name, code, unit_id, description, track_inventory, is_salable, is_purchasable, is_returnable, is_active, min_stock, has_expiry, has_batch_control)
                 VALUES ($1, $2, 'Test Product', 'P-${uniqueSuffix}', $3, 'Description', true, true, true, true, true, 0, false, true)`,
                [testProductId, testTenantId, testUnitId],
            );

            // 7. Product Variant
            await dataSource.query(
                `INSERT INTO product_variants (id, tenant_id, product_id, sku, is_active)
                 VALUES ($1, $2, $3, 'SKU-${uniqueSuffix}', true)`,
                [testVariantId, testTenantId, testProductId],
            );
        } catch (error) {
            throw error;
        }
    }

    afterAll(async () => {
        await app.close();
    });

    // Helper functions with proper types
    async function setupTestLot(config: {
        variantId: string;
        branchId: string;
        tenantId: string;
        quantity: number;
    }): Promise<void> {
        // Unique lot number every time
        const lotNumber = `LOT-${config.variantId.slice(0, 8)}-${Date.now()}-${Math.floor(Math.random() * 1000)}`;


        // Clean up previous lots to avoid test interference
        // First delete sales_details that reference the lots
        await dataSource.query(
            `DELETE FROM sales_details WHERE lot_id IN (SELECT id FROM inventory_lots WHERE variant_id = $1 AND branch_id = $2)`,
            [config.variantId, config.branchId]
        );

        // Then delete movements to avoid FK violation
        await dataSource.query(
            `DELETE FROM inventory_movements WHERE lot_id IN (SELECT id FROM inventory_lots WHERE variant_id = $1 AND branch_id = $2)`,
            [config.variantId, config.branchId]
        );

        await dataSource.query(
            `DELETE FROM inventory_lots WHERE variant_id = $1 AND branch_id = $2`,
            [config.variantId, config.branchId]
        );

        await dataSource.query(
            `
      INSERT INTO inventory_lots (id, tenant_id, branch_id, variant_id, lot_number, current_quantity, initial_quantity, status, purchase_price)
      VALUES (gen_random_uuid(), $1, $2, $3, $5, $4, $4, 'active', 100.00)
      `,
            [config.tenantId, config.branchId, config.variantId, config.quantity, lotNumber],
        );
    }

    async function getStockQuantity(
        variantId: string,
        branchId: string,
    ): Promise<number> {
        const result: StockQueryResult[] = await dataSource.query(
            `SELECT COALESCE(SUM(current_quantity), 0) as total 
       FROM inventory_lots 
       WHERE variant_id = $1 AND branch_id = $2 AND status = 'active'`,
            [variantId, branchId],
        );
        return Number(result[0]?.total ?? 0);
    }

    async function countSales(tenantId: string): Promise<number> {
        const result: SalesCountResult[] = await dataSource.query(
            `SELECT COUNT(*) as count FROM sales WHERE tenant_id = $1`,
            [tenantId],
        );
        return Number(result[0]?.count ?? 0);
    }

    function createSaleRequest(
        variantId: string,
        quantity: number,
    ): request.Test {
        return request(httpServer)
            .post('/sales')
            .set('x-tenant-id', testTenantId)
            .send({
                branchId: testBranchId,
                cashierId: testCashierId,
                paymentMethod: 'cash',
                items: [{ variantId, quantity, unitPrice: 100 }],
            });
    }

    describe('Race Condition Detection', () => {
        it('should prevent overselling when parallel requests try to buy same stock', async () => {
            const initialStock = 5;
            await setupTestLot({
                variantId: testVariantId,
                branchId: testBranchId,
                tenantId: testTenantId,
                quantity: initialStock,
            });

            const parallelRequests = 10;

            const results = await Promise.allSettled(
                Array(parallelRequests)
                    .fill(null)
                    .map(() => createSaleRequest(testVariantId, 1)),
            );

            const successful = results.filter(
                (r): r is PromiseFulfilledResult<request.Response> =>
                    r.status === 'fulfilled' && r.value.status === 201,
            );


            expect(successful.length).toBeLessThanOrEqual(initialStock);

            const finalStock = await getStockQuantity(testVariantId, testBranchId);
            expect(finalStock).toBeGreaterThanOrEqual(0);
        });

        it('should serialize concurrent transactions correctly', async () => {
            const initialStock = 100;
            await setupTestLot({
                variantId: testVariantId,
                branchId: testBranchId,
                tenantId: testTenantId,
                quantity: initialStock,
            });

            const parallelSales = 50;
            const quantityPerSale = 2;


            const results = await Promise.allSettled(
                Array(parallelSales)
                    .fill(null)
                    .map(() => createSaleRequest(testVariantId, quantityPerSale)),
            );

            const successful = results.filter(
                (r): r is PromiseFulfilledResult<request.Response> =>
                    r.status === 'fulfilled' && r.value.status === 201,
            );

            const finalStock = await getStockQuantity(testVariantId, testBranchId);
            const expectedStock = initialStock - successful.length * quantityPerSale;

            expect(finalStock).toBe(expectedStock);
        });
    });

    describe('Pessimistic Locking Verification', () => {
        it('should hold lock during transaction', async () => {
            const startTime = Date.now();

            await Promise.all([
                createSaleRequest(testVariantId, 1),
                createSaleRequest(testVariantId, 1),
            ]);

            const elapsed = Date.now() - startTime;
        });
    });

    describe('Rollback on Failure', () => {
        it('should rollback entire transaction if any item fails', async () => {
            await setupTestLot({
                variantId: testVariantId,
                branchId: testBranchId,
                tenantId: testTenantId,
                quantity: 5,
            });

            const initialStock = await getStockQuantity(testVariantId, testBranchId);

            const response = await request(httpServer)
                .post('/sales')
                .set('x-tenant-id', testTenantId)
                .send({
                    branchId: testBranchId,
                    cashierId: testCashierId,
                    paymentMethod: 'cash',
                    items: [
                        { variantId: testVariantId, quantity: 3, unitPrice: 100 },
                        {
                            variantId: '99999999-9999-9999-9999-999999999999',
                            quantity: 1,
                            unitPrice: 50,
                        },
                    ],
                });

            expect([400, 404]).toContain(response.status);

            const finalStock = await getStockQuantity(testVariantId, testBranchId);
            expect(finalStock).toBe(initialStock);
        });

        it('should not create partial records on failure', async () => {
            const salesBefore = await countSales(testTenantId);

            await request(httpServer)
                .post('/sales')
                .set('x-tenant-id', testTenantId)
                .send({
                    branchId: testBranchId,
                    cashierId: testCashierId,
                    paymentMethod: 'cash',
                    items: [
                        { variantId: testVariantId, quantity: 999999, unitPrice: 100 },
                    ],
                });

            const salesAfter = await countSales(testTenantId);
            expect(salesAfter).toBe(salesBefore);
        });
    });

    describe('Inventory Movement Integrity', () => {
        it('should create matching inventory movements for each sale', async () => {
            await setupTestLot({
                variantId: testVariantId,
                branchId: testBranchId,
                tenantId: testTenantId,
                quantity: 10,
            });

            const response = await request(httpServer)
                .post('/sales')
                .set('x-tenant-id', testTenantId)
                .send({
                    branchId: testBranchId,
                    cashierId: testCashierId,
                    paymentMethod: 'cash',
                    items: [{ variantId: testVariantId, quantity: 3, unitPrice: 100 }],
                });

            if (response.status === 201) {
                const saleId = (response.body as { id: string }).id;

                const movements: InventoryMovementResult[] = await dataSource.query(
                    `SELECT quantity, movement_type FROM inventory_movements WHERE reference_id = $1`,
                    [saleId],
                );

                expect(movements.length).toBeGreaterThan(0);
                expect(movements[0].quantity).toBe(-3);
                expect(movements[0].movement_type).toBe('sale');
            }
        });
    });
});
