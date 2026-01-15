import 'reflect-metadata';
import { AppDataSource } from './data-source';

async function testConnection(): Promise<void> {
  console.log('🔌 Testing database connection...\n');

  try {
    await AppDataSource.initialize();
    console.log('✅ Database connection successful!\n');

    // Test query
    const result = await AppDataSource.query('SELECT version()');
    console.log('📊 PostgreSQL version:', result[0].version.split(' ').slice(0, 2).join(' '));

    // Count tables
    const tables = await AppDataSource.query(`
      SELECT COUNT(*) as count 
      FROM information_schema.tables 
      WHERE table_schema = 'public' AND table_type = 'BASE TABLE'
    `);
    console.log('📋 Tables in database:', tables[0].count);

    // Check RLS
    const rlsTables = await AppDataSource.query(`
      SELECT COUNT(*) as count 
      FROM pg_tables 
      WHERE schemaname = 'public' AND rowsecurity = true
    `);
    console.log('🔒 Tables with RLS enabled:', rlsTables[0].count);

    await AppDataSource.destroy();
    console.log('\n✅ Connection test completed successfully!');

  } catch (error) {
    console.error('❌ Connection failed:', error);
    process.exit(1);
  }
}

testConnection();
