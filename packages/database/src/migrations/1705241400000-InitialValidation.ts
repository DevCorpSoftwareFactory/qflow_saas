import { MigrationInterface, QueryRunner } from 'typeorm';

/**
 * Initial empty migration - validation only.
 * 
 * This migration exists to:
 * 1. Validate that the migration system works correctly
 * 2. Serve as a baseline for future migrations
 * 
 * All tables were created by the DDL script (qflow_pro_ddl_complete.sql).
 * DO NOT create tables here - use the DDL as source of truth.
 */
export class InitialValidation1705241400000 implements MigrationInterface {
    name = 'InitialValidation1705241400000';

    public async up(queryRunner: QueryRunner): Promise<void> {
        // Validation: Check that core tables exist
        const tables = await queryRunner.query(`
      SELECT table_name 
      FROM information_schema.tables 
      WHERE table_schema = 'public' 
        AND table_type = 'BASE TABLE'
      ORDER BY table_name
    `);

        const tableNames = tables.map((t: { table_name: string }) => t.table_name);

        const requiredTables = [
            'tenants',
            'branches',
            'users',
            'products',
            'product_variants',
            'inventory_lots',
            'sales',
            'sales_details',
        ];

        for (const table of requiredTables) {
            if (!tableNames.includes(table)) {
                throw new Error(`Required table '${table}' not found. Run DDL script first.`);
            }
        }

        console.log(`✅ Validated ${requiredTables.length} core tables exist.`);
        console.log(`📊 Total tables in database: ${tableNames.length}`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        // No rollback needed for validation-only migration
        console.log('⚠️ InitialValidation migration has no rollback action.');
    }
}
