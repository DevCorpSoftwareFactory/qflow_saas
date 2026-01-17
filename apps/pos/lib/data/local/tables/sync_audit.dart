import 'package:drift/drift.dart';

@DataClassName('SyncAuditLog')
class SyncAudit extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType =>
      text().withLength(min: 1, max: 50)(); // 'sale', 'product'
  TextColumn get entityId => text()();
  TextColumn get operation =>
      text().withLength(min: 1, max: 20)(); // 'create', 'update'
  TextColumn get status => text().withLength(
      min: 1, max: 20)(); // 'success', 'conflict', 'resolved', 'failed'
  DateTimeColumn get timestamp => dateTime().withDefault(currentDateAndTime)();
  TextColumn get details =>
      text().nullable()(); // Optional details, e.g. error message source
}
