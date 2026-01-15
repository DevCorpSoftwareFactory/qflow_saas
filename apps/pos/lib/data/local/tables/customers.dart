// =============================================================================
// Customers Table - Drift Definition
// =============================================================================
// Based on: qflow_pro_ddl_complete.sql - lines 1967-2033
// =============================================================================

import 'package:drift/drift.dart';
import 'enums.dart';
import 'price_lists.dart';

/// Clientes del tenant. Controla tipo (retail/wholesale) para precios.
class LocalCustomers extends Table {
  TextColumn get id => text()();
  TextColumn get tenantId => text()();
  
  // Identificación
  TextColumn get code => text()();
  TextColumn get customerType => textEnum<CustomerType>()();  // retail, wholesale, vip
  
  // Datos personales
  TextColumn get fullName => text()();
  TextColumn get tradeName => text().nullable()();  // Nombre del negocio si es mayorista
  TextColumn get taxId => text().nullable()();
  TextColumn get documentType => text().nullable()();  // CC, NIT, CE, PASAPORTE
  TextColumn get documentNumber => text().nullable()();
  
  // Contacto
  TextColumn get email => text().nullable()();
  TextColumn get phoneNumber => text().nullable()();
  TextColumn get whatsapp => text().nullable()();
  
  // Dirección
  TextColumn get address => text().nullable()();
  TextColumn get city => text().nullable()();
  TextColumn get deliveryZone => text().nullable()();
  
  // Crédito
  RealColumn get creditLimit => real().withDefault(const Constant(0))();
  IntColumn get creditDays => integer().withDefault(const Constant(0))();
  RealColumn get currentCredit => real().withDefault(const Constant(0))();
  
  // Lista de precios asignada
  TextColumn get priceListId => text().nullable().references(LocalPriceLists, #id)();
  
  // Estado
  TextColumn get status => textEnum<CustomerStatus>().withDefault(const Constant('active'))();
  
  // Métricas
  RealColumn get totalPurchases => real().withDefault(const Constant(0))();
  IntColumn get totalOrders => integer().withDefault(const Constant(0))();
  DateTimeColumn get lastPurchaseDate => dateTime().nullable()();
  
  TextColumn get notes => text().nullable()();
  
  // Sync
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}
