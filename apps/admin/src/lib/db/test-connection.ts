/**
 * Database connection test for Admin app
 */
import 'reflect-metadata';
import { getDatabase } from './index';

async function testConnection(): Promise<void> {
    console.log('🔌 [Admin] Testing database connection...\n');

    try {
        const db = await getDatabase();
        console.log('✅ [Admin] Database connection successful!\n');

        // Test query
        const result = await db.query('SELECT version()');
        console.log('📊 PostgreSQL version:', result[0].version.split(' ').slice(0, 2).join(' '));

        // Count tables
        const tables = await db.query(`
      SELECT COUNT(*) as count 
      FROM information_schema.tables 
      WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
    `);
        console.log('📋 Tables in database:', tables[0].count);

        // Test tenant context
        await db.query(`SELECT set_config('app.current_tenant_id', '00000000-0000-0000-0000-000000000001', false)`);
        const tenantCheck = await db.query(`SELECT current_setting('app.current_tenant_id', true) as tenant_id`);
        console.log('🔒 Tenant context test:', tenantCheck[0].tenant_id ? '✅ Working' : '❌ Failed');

        await db.destroy();
        console.log('\n✅ [Admin] Connection test completed successfully!');

    } catch (error) {
        console.error('❌ [Admin] Connection failed:', error);
        process.exit(1);
    }
}

testConnection();
