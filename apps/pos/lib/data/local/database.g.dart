// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LocalSalesTable extends LocalSales
    with TableInfo<$LocalSalesTable, LocalSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleNumberMeta = const VerificationMeta(
    'saleNumber',
  );
  @override
  late final GeneratedColumn<String> saleNumber = GeneratedColumn<String>(
    'sale_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerIdMeta = const VerificationMeta(
    'customerId',
  );
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
    'customer_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _taxAmountMeta = const VerificationMeta(
    'taxAmount',
  );
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
    'tax_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _discountAmountMeta = const VerificationMeta(
    'discountAmount',
  );
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
    'discount_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _totalAmountMeta = const VerificationMeta(
    'totalAmount',
  );
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
    'total_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<SaleStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('completed'),
      ).withConverter<SaleStatus>($LocalSalesTable.$converterstatus);
  @override
  late final GeneratedColumnWithTypeConverter<SaleType, String> saleType =
      GeneratedColumn<String>(
        'sale_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('retail'),
      ).withConverter<SaleType>($LocalSalesTable.$convertersaleType);
  static const VerificationMeta _cashierIdMeta = const VerificationMeta(
    'cashierId',
  );
  @override
  late final GeneratedColumn<String> cashierId = GeneratedColumn<String>(
    'cashier_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleDateMeta = const VerificationMeta(
    'saleDate',
  );
  @override
  late final GeneratedColumn<DateTime> saleDate = GeneratedColumn<DateTime>(
    'sale_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    branchId,
    saleNumber,
    customerId,
    subtotal,
    taxAmount,
    discountAmount,
    totalAmount,
    status,
    saleType,
    cashierId,
    saleDate,
    synced,
    syncedAt,
    localId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sales';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSale> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('sale_number')) {
      context.handle(
        _saleNumberMeta,
        saleNumber.isAcceptableOrUnknown(data['sale_number']!, _saleNumberMeta),
      );
    }
    if (data.containsKey('customer_id')) {
      context.handle(
        _customerIdMeta,
        customerId.isAcceptableOrUnknown(data['customer_id']!, _customerIdMeta),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    }
    if (data.containsKey('tax_amount')) {
      context.handle(
        _taxAmountMeta,
        taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta),
      );
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
        _discountAmountMeta,
        discountAmount.isAcceptableOrUnknown(
          data['discount_amount']!,
          _discountAmountMeta,
        ),
      );
    }
    if (data.containsKey('total_amount')) {
      context.handle(
        _totalAmountMeta,
        totalAmount.isAcceptableOrUnknown(
          data['total_amount']!,
          _totalAmountMeta,
        ),
      );
    }
    if (data.containsKey('cashier_id')) {
      context.handle(
        _cashierIdMeta,
        cashierId.isAcceptableOrUnknown(data['cashier_id']!, _cashierIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cashierIdMeta);
    }
    if (data.containsKey('sale_date')) {
      context.handle(
        _saleDateMeta,
        saleDate.isAcceptableOrUnknown(data['sale_date']!, _saleDateMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSale(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      saleNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_number'],
      ),
      customerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_id'],
      ),
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      taxAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}tax_amount'],
      )!,
      discountAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_amount'],
      )!,
      totalAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_amount'],
      )!,
      status: $LocalSalesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      saleType: $LocalSalesTable.$convertersaleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}sale_type'],
        )!,
      ),
      cashierId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cashier_id'],
      )!,
      saleDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sale_date'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalSalesTable createAlias(String alias) {
    return $LocalSalesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SaleStatus, String, String> $converterstatus =
      const EnumNameConverter<SaleStatus>(SaleStatus.values);
  static JsonTypeConverter2<SaleType, String, String> $convertersaleType =
      const EnumNameConverter<SaleType>(SaleType.values);
}

class LocalSale extends DataClass implements Insertable<LocalSale> {
  final String id;
  final String tenantId;
  final String branchId;
  final String? saleNumber;
  final String? customerId;
  final double subtotal;
  final double taxAmount;
  final double discountAmount;
  final double totalAmount;
  final SaleStatus status;
  final SaleType saleType;
  final String cashierId;
  final DateTime saleDate;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalSale({
    required this.id,
    required this.tenantId,
    required this.branchId,
    this.saleNumber,
    this.customerId,
    required this.subtotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.totalAmount,
    required this.status,
    required this.saleType,
    required this.cashierId,
    required this.saleDate,
    required this.synced,
    this.syncedAt,
    required this.localId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    if (!nullToAbsent || saleNumber != null) {
      map['sale_number'] = Variable<String>(saleNumber);
    }
    if (!nullToAbsent || customerId != null) {
      map['customer_id'] = Variable<String>(customerId);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    {
      map['status'] = Variable<String>(
        $LocalSalesTable.$converterstatus.toSql(status),
      );
    }
    {
      map['sale_type'] = Variable<String>(
        $LocalSalesTable.$convertersaleType.toSql(saleType),
      );
    }
    map['cashier_id'] = Variable<String>(cashierId);
    map['sale_date'] = Variable<DateTime>(saleDate);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalSalesCompanion toCompanion(bool nullToAbsent) {
    return LocalSalesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      saleNumber: saleNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(saleNumber),
      customerId: customerId == null && nullToAbsent
          ? const Value.absent()
          : Value(customerId),
      subtotal: Value(subtotal),
      taxAmount: Value(taxAmount),
      discountAmount: Value(discountAmount),
      totalAmount: Value(totalAmount),
      status: Value(status),
      saleType: Value(saleType),
      cashierId: Value(cashierId),
      saleDate: Value(saleDate),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalSale.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSale(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      saleNumber: serializer.fromJson<String?>(json['saleNumber']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      status: $LocalSalesTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      saleType: $LocalSalesTable.$convertersaleType.fromJson(
        serializer.fromJson<String>(json['saleType']),
      ),
      cashierId: serializer.fromJson<String>(json['cashierId']),
      saleDate: serializer.fromJson<DateTime>(json['saleDate']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'saleNumber': serializer.toJson<String?>(saleNumber),
      'customerId': serializer.toJson<String?>(customerId),
      'subtotal': serializer.toJson<double>(subtotal),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'status': serializer.toJson<String>(
        $LocalSalesTable.$converterstatus.toJson(status),
      ),
      'saleType': serializer.toJson<String>(
        $LocalSalesTable.$convertersaleType.toJson(saleType),
      ),
      'cashierId': serializer.toJson<String>(cashierId),
      'saleDate': serializer.toJson<DateTime>(saleDate),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalSale copyWith({
    String? id,
    String? tenantId,
    String? branchId,
    Value<String?> saleNumber = const Value.absent(),
    Value<String?> customerId = const Value.absent(),
    double? subtotal,
    double? taxAmount,
    double? discountAmount,
    double? totalAmount,
    SaleStatus? status,
    SaleType? saleType,
    String? cashierId,
    DateTime? saleDate,
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
    String? localId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalSale(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    branchId: branchId ?? this.branchId,
    saleNumber: saleNumber.present ? saleNumber.value : this.saleNumber,
    customerId: customerId.present ? customerId.value : this.customerId,
    subtotal: subtotal ?? this.subtotal,
    taxAmount: taxAmount ?? this.taxAmount,
    discountAmount: discountAmount ?? this.discountAmount,
    totalAmount: totalAmount ?? this.totalAmount,
    status: status ?? this.status,
    saleType: saleType ?? this.saleType,
    cashierId: cashierId ?? this.cashierId,
    saleDate: saleDate ?? this.saleDate,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    localId: localId ?? this.localId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalSale copyWithCompanion(LocalSalesCompanion data) {
    return LocalSale(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      saleNumber: data.saleNumber.present
          ? data.saleNumber.value
          : this.saleNumber,
      customerId: data.customerId.present
          ? data.customerId.value
          : this.customerId,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      totalAmount: data.totalAmount.present
          ? data.totalAmount.value
          : this.totalAmount,
      status: data.status.present ? data.status.value : this.status,
      saleType: data.saleType.present ? data.saleType.value : this.saleType,
      cashierId: data.cashierId.present ? data.cashierId.value : this.cashierId,
      saleDate: data.saleDate.present ? data.saleDate.value : this.saleDate,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSale(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('saleNumber: $saleNumber, ')
          ..write('customerId: $customerId, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('saleType: $saleType, ')
          ..write('cashierId: $cashierId, ')
          ..write('saleDate: $saleDate, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    branchId,
    saleNumber,
    customerId,
    subtotal,
    taxAmount,
    discountAmount,
    totalAmount,
    status,
    saleType,
    cashierId,
    saleDate,
    synced,
    syncedAt,
    localId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSale &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.saleNumber == this.saleNumber &&
          other.customerId == this.customerId &&
          other.subtotal == this.subtotal &&
          other.taxAmount == this.taxAmount &&
          other.discountAmount == this.discountAmount &&
          other.totalAmount == this.totalAmount &&
          other.status == this.status &&
          other.saleType == this.saleType &&
          other.cashierId == this.cashierId &&
          other.saleDate == this.saleDate &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalSalesCompanion extends UpdateCompanion<LocalSale> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String?> saleNumber;
  final Value<String?> customerId;
  final Value<double> subtotal;
  final Value<double> taxAmount;
  final Value<double> discountAmount;
  final Value<double> totalAmount;
  final Value<SaleStatus> status;
  final Value<SaleType> saleType;
  final Value<String> cashierId;
  final Value<DateTime> saleDate;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalSalesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.saleNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.saleType = const Value.absent(),
    this.cashierId = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSalesCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    this.saleNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.saleType = const Value.absent(),
    required String cashierId,
    this.saleDate = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       branchId = Value(branchId),
       cashierId = Value(cashierId),
       localId = Value(localId);
  static Insertable<LocalSale> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? saleNumber,
    Expression<String>? customerId,
    Expression<double>? subtotal,
    Expression<double>? taxAmount,
    Expression<double>? discountAmount,
    Expression<double>? totalAmount,
    Expression<String>? status,
    Expression<String>? saleType,
    Expression<String>? cashierId,
    Expression<DateTime>? saleDate,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (saleNumber != null) 'sale_number': saleNumber,
      if (customerId != null) 'customer_id': customerId,
      if (subtotal != null) 'subtotal': subtotal,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (status != null) 'status': status,
      if (saleType != null) 'sale_type': saleType,
      if (cashierId != null) 'cashier_id': cashierId,
      if (saleDate != null) 'sale_date': saleDate,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSalesCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? branchId,
    Value<String?>? saleNumber,
    Value<String?>? customerId,
    Value<double>? subtotal,
    Value<double>? taxAmount,
    Value<double>? discountAmount,
    Value<double>? totalAmount,
    Value<SaleStatus>? status,
    Value<SaleType>? saleType,
    Value<String>? cashierId,
    Value<DateTime>? saleDate,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<String>? localId,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalSalesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      saleNumber: saleNumber ?? this.saleNumber,
      customerId: customerId ?? this.customerId,
      subtotal: subtotal ?? this.subtotal,
      taxAmount: taxAmount ?? this.taxAmount,
      discountAmount: discountAmount ?? this.discountAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      status: status ?? this.status,
      saleType: saleType ?? this.saleType,
      cashierId: cashierId ?? this.cashierId,
      saleDate: saleDate ?? this.saleDate,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (saleNumber.present) {
      map['sale_number'] = Variable<String>(saleNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $LocalSalesTable.$converterstatus.toSql(status.value),
      );
    }
    if (saleType.present) {
      map['sale_type'] = Variable<String>(
        $LocalSalesTable.$convertersaleType.toSql(saleType.value),
      );
    }
    if (cashierId.present) {
      map['cashier_id'] = Variable<String>(cashierId.value);
    }
    if (saleDate.present) {
      map['sale_date'] = Variable<DateTime>(saleDate.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSalesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('saleNumber: $saleNumber, ')
          ..write('customerId: $customerId, ')
          ..write('subtotal: $subtotal, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('status: $status, ')
          ..write('saleType: $saleType, ')
          ..write('cashierId: $cashierId, ')
          ..write('saleDate: $saleDate, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSaleItemsTable extends LocalSaleItems
    with TableInfo<$LocalSaleItemsTable, LocalSaleItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSaleItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sales (id)',
    ),
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
    'lot_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitPriceMeta = const VerificationMeta(
    'unitPrice',
  );
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
    'unit_price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _discountPercentMeta = const VerificationMeta(
    'discountPercent',
  );
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
    'discount_percent',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    variantId,
    lotId,
    quantity,
    unitPrice,
    costPrice,
    discountPercent,
    subtotal,
    synced,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSaleItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(
        _unitPriceMeta,
        unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta),
      );
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
        _discountPercentMeta,
        discountPercent.isAcceptableOrUnknown(
          data['discount_percent']!,
          _discountPercentMeta,
        ),
      );
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSaleItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_id'],
      ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      unitPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}unit_price'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      ),
      discountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}discount_percent'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}subtotal'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalSaleItemsTable createAlias(String alias) {
    return $LocalSaleItemsTable(attachedDatabase, alias);
  }
}

class LocalSaleItem extends DataClass implements Insertable<LocalSaleItem> {
  final String id;
  final String saleId;
  final String variantId;
  final String? lotId;
  final int quantity;

  /// Historical Unit Price (Immutable)
  final double unitPrice;

  /// Cost at moment of sale
  final double? costPrice;
  final double discountPercent;
  final double subtotal;
  final bool synced;
  final DateTime createdAt;
  const LocalSaleItem({
    required this.id,
    required this.saleId,
    required this.variantId,
    this.lotId,
    required this.quantity,
    required this.unitPrice,
    this.costPrice,
    required this.discountPercent,
    required this.subtotal,
    required this.synced,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    map['variant_id'] = Variable<String>(variantId);
    if (!nullToAbsent || lotId != null) {
      map['lot_id'] = Variable<String>(lotId);
    }
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    if (!nullToAbsent || costPrice != null) {
      map['cost_price'] = Variable<double>(costPrice);
    }
    map['discount_percent'] = Variable<double>(discountPercent);
    map['subtotal'] = Variable<double>(subtotal);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalSaleItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalSaleItemsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      variantId: Value(variantId),
      lotId: lotId == null && nullToAbsent
          ? const Value.absent()
          : Value(lotId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      costPrice: costPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(costPrice),
      discountPercent: Value(discountPercent),
      subtotal: Value(subtotal),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory LocalSaleItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSaleItem(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      lotId: serializer.fromJson<String?>(json['lotId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      costPrice: serializer.fromJson<double?>(json['costPrice']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'variantId': serializer.toJson<String>(variantId),
      'lotId': serializer.toJson<String?>(lotId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'costPrice': serializer.toJson<double?>(costPrice),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'subtotal': serializer.toJson<double>(subtotal),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalSaleItem copyWith({
    String? id,
    String? saleId,
    String? variantId,
    Value<String?> lotId = const Value.absent(),
    int? quantity,
    double? unitPrice,
    Value<double?> costPrice = const Value.absent(),
    double? discountPercent,
    double? subtotal,
    bool? synced,
    DateTime? createdAt,
  }) => LocalSaleItem(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    variantId: variantId ?? this.variantId,
    lotId: lotId.present ? lotId.value : this.lotId,
    quantity: quantity ?? this.quantity,
    unitPrice: unitPrice ?? this.unitPrice,
    costPrice: costPrice.present ? costPrice.value : this.costPrice,
    discountPercent: discountPercent ?? this.discountPercent,
    subtotal: subtotal ?? this.subtotal,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalSaleItem copyWithCompanion(LocalSaleItemsCompanion data) {
    return LocalSaleItem(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleItem(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('variantId: $variantId, ')
          ..write('lotId: $lotId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('subtotal: $subtotal, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    variantId,
    lotId,
    quantity,
    unitPrice,
    costPrice,
    discountPercent,
    subtotal,
    synced,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSaleItem &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.variantId == this.variantId &&
          other.lotId == this.lotId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.costPrice == this.costPrice &&
          other.discountPercent == this.discountPercent &&
          other.subtotal == this.subtotal &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class LocalSaleItemsCompanion extends UpdateCompanion<LocalSaleItem> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<String> variantId;
  final Value<String?> lotId;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double?> costPrice;
  final Value<double> discountPercent;
  final Value<double> subtotal;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalSaleItemsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.lotId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSaleItemsCompanion.insert({
    required String id,
    required String saleId,
    required String variantId,
    this.lotId = const Value.absent(),
    required int quantity,
    required double unitPrice,
    this.costPrice = const Value.absent(),
    this.discountPercent = const Value.absent(),
    required double subtotal,
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       saleId = Value(saleId),
       variantId = Value(variantId),
       quantity = Value(quantity),
       unitPrice = Value(unitPrice),
       subtotal = Value(subtotal);
  static Insertable<LocalSaleItem> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? variantId,
    Expression<String>? lotId,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? costPrice,
    Expression<double>? discountPercent,
    Expression<double>? subtotal,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (variantId != null) 'variant_id': variantId,
      if (lotId != null) 'lot_id': lotId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (costPrice != null) 'cost_price': costPrice,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (subtotal != null) 'subtotal': subtotal,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSaleItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? saleId,
    Value<String>? variantId,
    Value<String?>? lotId,
    Value<int>? quantity,
    Value<double>? unitPrice,
    Value<double?>? costPrice,
    Value<double>? discountPercent,
    Value<double>? subtotal,
    Value<bool>? synced,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalSaleItemsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      variantId: variantId ?? this.variantId,
      lotId: lotId ?? this.lotId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      costPrice: costPrice ?? this.costPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      subtotal: subtotal ?? this.subtotal,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleItemsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('variantId: $variantId, ')
          ..write('lotId: $lotId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('subtotal: $subtotal, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalProductsTable extends LocalProducts
    with TableInfo<$LocalProductsTable, LocalProduct> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeTypeMeta = const VerificationMeta(
    'barcodeType',
  );
  @override
  late final GeneratedColumn<String> barcodeType = GeneratedColumn<String>(
    'barcode_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _shortNameMeta = const VerificationMeta(
    'shortName',
  );
  @override
  late final GeneratedColumn<String> shortName = GeneratedColumn<String>(
    'short_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryIdMeta = const VerificationMeta(
    'categoryId',
  );
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
    'category_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brandIdMeta = const VerificationMeta(
    'brandId',
  );
  @override
  late final GeneratedColumn<String> brandId = GeneratedColumn<String>(
    'brand_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
    'unit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hasExpiryMeta = const VerificationMeta(
    'hasExpiry',
  );
  @override
  late final GeneratedColumn<bool> hasExpiry = GeneratedColumn<bool>(
    'has_expiry',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_expiry" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _hasBatchControlMeta = const VerificationMeta(
    'hasBatchControl',
  );
  @override
  late final GeneratedColumn<bool> hasBatchControl = GeneratedColumn<bool>(
    'has_batch_control',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("has_batch_control" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _trackInventoryMeta = const VerificationMeta(
    'trackInventory',
  );
  @override
  late final GeneratedColumn<bool> trackInventory = GeneratedColumn<bool>(
    'track_inventory',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("track_inventory" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isSalableMeta = const VerificationMeta(
    'isSalable',
  );
  @override
  late final GeneratedColumn<bool> isSalable = GeneratedColumn<bool>(
    'is_salable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_salable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    code,
    barcodeType,
    name,
    description,
    shortName,
    categoryId,
    brandId,
    unitId,
    hasExpiry,
    hasBatchControl,
    trackInventory,
    isSalable,
    isActive,
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_products';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProduct> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('barcode_type')) {
      context.handle(
        _barcodeTypeMeta,
        barcodeType.isAcceptableOrUnknown(
          data['barcode_type']!,
          _barcodeTypeMeta,
        ),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('short_name')) {
      context.handle(
        _shortNameMeta,
        shortName.isAcceptableOrUnknown(data['short_name']!, _shortNameMeta),
      );
    }
    if (data.containsKey('category_id')) {
      context.handle(
        _categoryIdMeta,
        categoryId.isAcceptableOrUnknown(data['category_id']!, _categoryIdMeta),
      );
    }
    if (data.containsKey('brand_id')) {
      context.handle(
        _brandIdMeta,
        brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta),
      );
    }
    if (data.containsKey('unit_id')) {
      context.handle(
        _unitIdMeta,
        unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta),
      );
    }
    if (data.containsKey('has_expiry')) {
      context.handle(
        _hasExpiryMeta,
        hasExpiry.isAcceptableOrUnknown(data['has_expiry']!, _hasExpiryMeta),
      );
    }
    if (data.containsKey('has_batch_control')) {
      context.handle(
        _hasBatchControlMeta,
        hasBatchControl.isAcceptableOrUnknown(
          data['has_batch_control']!,
          _hasBatchControlMeta,
        ),
      );
    }
    if (data.containsKey('track_inventory')) {
      context.handle(
        _trackInventoryMeta,
        trackInventory.isAcceptableOrUnknown(
          data['track_inventory']!,
          _trackInventoryMeta,
        ),
      );
    }
    if (data.containsKey('is_salable')) {
      context.handle(
        _isSalableMeta,
        isSalable.isAcceptableOrUnknown(data['is_salable']!, _isSalableMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProduct(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      barcodeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode_type'],
      ),
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      shortName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}short_name'],
      ),
      categoryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category_id'],
      ),
      brandId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brand_id'],
      ),
      unitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit_id'],
      ),
      hasExpiry: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_expiry'],
      )!,
      hasBatchControl: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}has_batch_control'],
      )!,
      trackInventory: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}track_inventory'],
      )!,
      isSalable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_salable'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $LocalProductsTable createAlias(String alias) {
    return $LocalProductsTable(attachedDatabase, alias);
  }
}

class LocalProduct extends DataClass implements Insertable<LocalProduct> {
  final String id;
  final String tenantId;
  final String code;
  final String? barcodeType;
  final String name;
  final String? description;
  final String? shortName;
  final String? categoryId;
  final String? brandId;
  final String? unitId;
  final bool hasExpiry;
  final bool hasBatchControl;
  final bool trackInventory;
  final bool isSalable;
  final bool isActive;
  final DateTime? lastSync;
  const LocalProduct({
    required this.id,
    required this.tenantId,
    required this.code,
    this.barcodeType,
    required this.name,
    this.description,
    this.shortName,
    this.categoryId,
    this.brandId,
    this.unitId,
    required this.hasExpiry,
    required this.hasBatchControl,
    required this.trackInventory,
    required this.isSalable,
    required this.isActive,
    this.lastSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['code'] = Variable<String>(code);
    if (!nullToAbsent || barcodeType != null) {
      map['barcode_type'] = Variable<String>(barcodeType);
    }
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || shortName != null) {
      map['short_name'] = Variable<String>(shortName);
    }
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<String>(categoryId);
    }
    if (!nullToAbsent || brandId != null) {
      map['brand_id'] = Variable<String>(brandId);
    }
    if (!nullToAbsent || unitId != null) {
      map['unit_id'] = Variable<String>(unitId);
    }
    map['has_expiry'] = Variable<bool>(hasExpiry);
    map['has_batch_control'] = Variable<bool>(hasBatchControl);
    map['track_inventory'] = Variable<bool>(trackInventory);
    map['is_salable'] = Variable<bool>(isSalable);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  LocalProductsCompanion toCompanion(bool nullToAbsent) {
    return LocalProductsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      code: Value(code),
      barcodeType: barcodeType == null && nullToAbsent
          ? const Value.absent()
          : Value(barcodeType),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      shortName: shortName == null && nullToAbsent
          ? const Value.absent()
          : Value(shortName),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      brandId: brandId == null && nullToAbsent
          ? const Value.absent()
          : Value(brandId),
      unitId: unitId == null && nullToAbsent
          ? const Value.absent()
          : Value(unitId),
      hasExpiry: Value(hasExpiry),
      hasBatchControl: Value(hasBatchControl),
      trackInventory: Value(trackInventory),
      isSalable: Value(isSalable),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory LocalProduct.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProduct(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      code: serializer.fromJson<String>(json['code']),
      barcodeType: serializer.fromJson<String?>(json['barcodeType']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      shortName: serializer.fromJson<String?>(json['shortName']),
      categoryId: serializer.fromJson<String?>(json['categoryId']),
      brandId: serializer.fromJson<String?>(json['brandId']),
      unitId: serializer.fromJson<String?>(json['unitId']),
      hasExpiry: serializer.fromJson<bool>(json['hasExpiry']),
      hasBatchControl: serializer.fromJson<bool>(json['hasBatchControl']),
      trackInventory: serializer.fromJson<bool>(json['trackInventory']),
      isSalable: serializer.fromJson<bool>(json['isSalable']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'code': serializer.toJson<String>(code),
      'barcodeType': serializer.toJson<String?>(barcodeType),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'shortName': serializer.toJson<String?>(shortName),
      'categoryId': serializer.toJson<String?>(categoryId),
      'brandId': serializer.toJson<String?>(brandId),
      'unitId': serializer.toJson<String?>(unitId),
      'hasExpiry': serializer.toJson<bool>(hasExpiry),
      'hasBatchControl': serializer.toJson<bool>(hasBatchControl),
      'trackInventory': serializer.toJson<bool>(trackInventory),
      'isSalable': serializer.toJson<bool>(isSalable),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  LocalProduct copyWith({
    String? id,
    String? tenantId,
    String? code,
    Value<String?> barcodeType = const Value.absent(),
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> shortName = const Value.absent(),
    Value<String?> categoryId = const Value.absent(),
    Value<String?> brandId = const Value.absent(),
    Value<String?> unitId = const Value.absent(),
    bool? hasExpiry,
    bool? hasBatchControl,
    bool? trackInventory,
    bool? isSalable,
    bool? isActive,
    Value<DateTime?> lastSync = const Value.absent(),
  }) => LocalProduct(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    code: code ?? this.code,
    barcodeType: barcodeType.present ? barcodeType.value : this.barcodeType,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    shortName: shortName.present ? shortName.value : this.shortName,
    categoryId: categoryId.present ? categoryId.value : this.categoryId,
    brandId: brandId.present ? brandId.value : this.brandId,
    unitId: unitId.present ? unitId.value : this.unitId,
    hasExpiry: hasExpiry ?? this.hasExpiry,
    hasBatchControl: hasBatchControl ?? this.hasBatchControl,
    trackInventory: trackInventory ?? this.trackInventory,
    isSalable: isSalable ?? this.isSalable,
    isActive: isActive ?? this.isActive,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  LocalProduct copyWithCompanion(LocalProductsCompanion data) {
    return LocalProduct(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      code: data.code.present ? data.code.value : this.code,
      barcodeType: data.barcodeType.present
          ? data.barcodeType.value
          : this.barcodeType,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      categoryId: data.categoryId.present
          ? data.categoryId.value
          : this.categoryId,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      hasExpiry: data.hasExpiry.present ? data.hasExpiry.value : this.hasExpiry,
      hasBatchControl: data.hasBatchControl.present
          ? data.hasBatchControl.value
          : this.hasBatchControl,
      trackInventory: data.trackInventory.present
          ? data.trackInventory.value
          : this.trackInventory,
      isSalable: data.isSalable.present ? data.isSalable.value : this.isSalable,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProduct(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('code: $code, ')
          ..write('barcodeType: $barcodeType, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('shortName: $shortName, ')
          ..write('categoryId: $categoryId, ')
          ..write('brandId: $brandId, ')
          ..write('unitId: $unitId, ')
          ..write('hasExpiry: $hasExpiry, ')
          ..write('hasBatchControl: $hasBatchControl, ')
          ..write('trackInventory: $trackInventory, ')
          ..write('isSalable: $isSalable, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    code,
    barcodeType,
    name,
    description,
    shortName,
    categoryId,
    brandId,
    unitId,
    hasExpiry,
    hasBatchControl,
    trackInventory,
    isSalable,
    isActive,
    lastSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProduct &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.code == this.code &&
          other.barcodeType == this.barcodeType &&
          other.name == this.name &&
          other.description == this.description &&
          other.shortName == this.shortName &&
          other.categoryId == this.categoryId &&
          other.brandId == this.brandId &&
          other.unitId == this.unitId &&
          other.hasExpiry == this.hasExpiry &&
          other.hasBatchControl == this.hasBatchControl &&
          other.trackInventory == this.trackInventory &&
          other.isSalable == this.isSalable &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync);
}

class LocalProductsCompanion extends UpdateCompanion<LocalProduct> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> code;
  final Value<String?> barcodeType;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> shortName;
  final Value<String?> categoryId;
  final Value<String?> brandId;
  final Value<String?> unitId;
  final Value<bool> hasExpiry;
  final Value<bool> hasBatchControl;
  final Value<bool> trackInventory;
  final Value<bool> isSalable;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const LocalProductsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.code = const Value.absent(),
    this.barcodeType = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.shortName = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.hasExpiry = const Value.absent(),
    this.hasBatchControl = const Value.absent(),
    this.trackInventory = const Value.absent(),
    this.isSalable = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProductsCompanion.insert({
    required String id,
    required String tenantId,
    required String code,
    this.barcodeType = const Value.absent(),
    required String name,
    this.description = const Value.absent(),
    this.shortName = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.brandId = const Value.absent(),
    this.unitId = const Value.absent(),
    this.hasExpiry = const Value.absent(),
    this.hasBatchControl = const Value.absent(),
    this.trackInventory = const Value.absent(),
    this.isSalable = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       code = Value(code),
       name = Value(name);
  static Insertable<LocalProduct> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? code,
    Expression<String>? barcodeType,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? shortName,
    Expression<String>? categoryId,
    Expression<String>? brandId,
    Expression<String>? unitId,
    Expression<bool>? hasExpiry,
    Expression<bool>? hasBatchControl,
    Expression<bool>? trackInventory,
    Expression<bool>? isSalable,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (code != null) 'code': code,
      if (barcodeType != null) 'barcode_type': barcodeType,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (shortName != null) 'short_name': shortName,
      if (categoryId != null) 'category_id': categoryId,
      if (brandId != null) 'brand_id': brandId,
      if (unitId != null) 'unit_id': unitId,
      if (hasExpiry != null) 'has_expiry': hasExpiry,
      if (hasBatchControl != null) 'has_batch_control': hasBatchControl,
      if (trackInventory != null) 'track_inventory': trackInventory,
      if (isSalable != null) 'is_salable': isSalable,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProductsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? code,
    Value<String?>? barcodeType,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? shortName,
    Value<String?>? categoryId,
    Value<String?>? brandId,
    Value<String?>? unitId,
    Value<bool>? hasExpiry,
    Value<bool>? hasBatchControl,
    Value<bool>? trackInventory,
    Value<bool>? isSalable,
    Value<bool>? isActive,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return LocalProductsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      code: code ?? this.code,
      barcodeType: barcodeType ?? this.barcodeType,
      name: name ?? this.name,
      description: description ?? this.description,
      shortName: shortName ?? this.shortName,
      categoryId: categoryId ?? this.categoryId,
      brandId: brandId ?? this.brandId,
      unitId: unitId ?? this.unitId,
      hasExpiry: hasExpiry ?? this.hasExpiry,
      hasBatchControl: hasBatchControl ?? this.hasBatchControl,
      trackInventory: trackInventory ?? this.trackInventory,
      isSalable: isSalable ?? this.isSalable,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (barcodeType.present) {
      map['barcode_type'] = Variable<String>(barcodeType.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (shortName.present) {
      map['short_name'] = Variable<String>(shortName.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<String>(categoryId.value);
    }
    if (brandId.present) {
      map['brand_id'] = Variable<String>(brandId.value);
    }
    if (unitId.present) {
      map['unit_id'] = Variable<String>(unitId.value);
    }
    if (hasExpiry.present) {
      map['has_expiry'] = Variable<bool>(hasExpiry.value);
    }
    if (hasBatchControl.present) {
      map['has_batch_control'] = Variable<bool>(hasBatchControl.value);
    }
    if (trackInventory.present) {
      map['track_inventory'] = Variable<bool>(trackInventory.value);
    }
    if (isSalable.present) {
      map['is_salable'] = Variable<bool>(isSalable.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('code: $code, ')
          ..write('barcodeType: $barcodeType, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('shortName: $shortName, ')
          ..write('categoryId: $categoryId, ')
          ..write('brandId: $brandId, ')
          ..write('unitId: $unitId, ')
          ..write('hasExpiry: $hasExpiry, ')
          ..write('hasBatchControl: $hasBatchControl, ')
          ..write('trackInventory: $trackInventory, ')
          ..write('isSalable: $isSalable, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalProductVariantsTable extends LocalProductVariants
    with TableInfo<$LocalProductVariantsTable, LocalProductVariant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductVariantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_products (id)',
    ),
  );
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
    'sku',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _barcodeMeta = const VerificationMeta(
    'barcode',
  );
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
    'barcode',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _attributesMeta = const VerificationMeta(
    'attributes',
  );
  @override
  late final GeneratedColumn<String> attributes = GeneratedColumn<String>(
    'attributes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeLitersMeta = const VerificationMeta(
    'volumeLiters',
  );
  @override
  late final GeneratedColumn<double> volumeLiters = GeneratedColumn<double>(
    'volume_liters',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    sku,
    barcode,
    attributes,
    price,
    weightKg,
    volumeLiters,
    isDefault,
    isActive,
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_product_variants';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalProductVariant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
        _skuMeta,
        sku.isAcceptableOrUnknown(data['sku']!, _skuMeta),
      );
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(
        _barcodeMeta,
        barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta),
      );
    }
    if (data.containsKey('attributes')) {
      context.handle(
        _attributesMeta,
        attributes.isAcceptableOrUnknown(data['attributes']!, _attributesMeta),
      );
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('volume_liters')) {
      context.handle(
        _volumeLitersMeta,
        volumeLiters.isAcceptableOrUnknown(
          data['volume_liters']!,
          _volumeLitersMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProductVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProductVariant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      sku: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sku'],
      )!,
      barcode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}barcode'],
      ),
      attributes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}attributes'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      volumeLiters: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_liters'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $LocalProductVariantsTable createAlias(String alias) {
    return $LocalProductVariantsTable(attachedDatabase, alias);
  }
}

class LocalProductVariant extends DataClass
    implements Insertable<LocalProductVariant> {
  final String id;
  final String productId;
  final String sku;
  final String? barcode;
  final String attributes;
  final double price;
  final double? weightKg;
  final double? volumeLiters;
  final bool isDefault;
  final bool isActive;
  final DateTime? lastSync;
  const LocalProductVariant({
    required this.id,
    required this.productId,
    required this.sku,
    this.barcode,
    required this.attributes,
    required this.price,
    this.weightKg,
    this.volumeLiters,
    required this.isDefault,
    required this.isActive,
    this.lastSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['product_id'] = Variable<String>(productId);
    map['sku'] = Variable<String>(sku);
    if (!nullToAbsent || barcode != null) {
      map['barcode'] = Variable<String>(barcode);
    }
    map['attributes'] = Variable<String>(attributes);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || volumeLiters != null) {
      map['volume_liters'] = Variable<double>(volumeLiters);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  LocalProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return LocalProductVariantsCompanion(
      id: Value(id),
      productId: Value(productId),
      sku: Value(sku),
      barcode: barcode == null && nullToAbsent
          ? const Value.absent()
          : Value(barcode),
      attributes: Value(attributes),
      price: Value(price),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      volumeLiters: volumeLiters == null && nullToAbsent
          ? const Value.absent()
          : Value(volumeLiters),
      isDefault: Value(isDefault),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory LocalProductVariant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProductVariant(
      id: serializer.fromJson<String>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      sku: serializer.fromJson<String>(json['sku']),
      barcode: serializer.fromJson<String?>(json['barcode']),
      attributes: serializer.fromJson<String>(json['attributes']),
      price: serializer.fromJson<double>(json['price']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      volumeLiters: serializer.fromJson<double?>(json['volumeLiters']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'productId': serializer.toJson<String>(productId),
      'sku': serializer.toJson<String>(sku),
      'barcode': serializer.toJson<String?>(barcode),
      'attributes': serializer.toJson<String>(attributes),
      'price': serializer.toJson<double>(price),
      'weightKg': serializer.toJson<double?>(weightKg),
      'volumeLiters': serializer.toJson<double?>(volumeLiters),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  LocalProductVariant copyWith({
    String? id,
    String? productId,
    String? sku,
    Value<String?> barcode = const Value.absent(),
    String? attributes,
    double? price,
    Value<double?> weightKg = const Value.absent(),
    Value<double?> volumeLiters = const Value.absent(),
    bool? isDefault,
    bool? isActive,
    Value<DateTime?> lastSync = const Value.absent(),
  }) => LocalProductVariant(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    sku: sku ?? this.sku,
    barcode: barcode.present ? barcode.value : this.barcode,
    attributes: attributes ?? this.attributes,
    price: price ?? this.price,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    volumeLiters: volumeLiters.present ? volumeLiters.value : this.volumeLiters,
    isDefault: isDefault ?? this.isDefault,
    isActive: isActive ?? this.isActive,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  LocalProductVariant copyWithCompanion(LocalProductVariantsCompanion data) {
    return LocalProductVariant(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      attributes: data.attributes.present
          ? data.attributes.value
          : this.attributes,
      price: data.price.present ? data.price.value : this.price,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      volumeLiters: data.volumeLiters.present
          ? data.volumeLiters.value
          : this.volumeLiters,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductVariant(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('attributes: $attributes, ')
          ..write('price: $price, ')
          ..write('weightKg: $weightKg, ')
          ..write('volumeLiters: $volumeLiters, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    productId,
    sku,
    barcode,
    attributes,
    price,
    weightKg,
    volumeLiters,
    isDefault,
    isActive,
    lastSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProductVariant &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.attributes == this.attributes &&
          other.price == this.price &&
          other.weightKg == this.weightKg &&
          other.volumeLiters == this.volumeLiters &&
          other.isDefault == this.isDefault &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync);
}

class LocalProductVariantsCompanion
    extends UpdateCompanion<LocalProductVariant> {
  final Value<String> id;
  final Value<String> productId;
  final Value<String> sku;
  final Value<String?> barcode;
  final Value<String> attributes;
  final Value<double> price;
  final Value<double?> weightKg;
  final Value<double?> volumeLiters;
  final Value<bool> isDefault;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const LocalProductVariantsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.sku = const Value.absent(),
    this.barcode = const Value.absent(),
    this.attributes = const Value.absent(),
    this.price = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.volumeLiters = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProductVariantsCompanion.insert({
    required String id,
    required String productId,
    required String sku,
    this.barcode = const Value.absent(),
    this.attributes = const Value.absent(),
    this.price = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.volumeLiters = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       productId = Value(productId),
       sku = Value(sku);
  static Insertable<LocalProductVariant> custom({
    Expression<String>? id,
    Expression<String>? productId,
    Expression<String>? sku,
    Expression<String>? barcode,
    Expression<String>? attributes,
    Expression<double>? price,
    Expression<double>? weightKg,
    Expression<double>? volumeLiters,
    Expression<bool>? isDefault,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (sku != null) 'sku': sku,
      if (barcode != null) 'barcode': barcode,
      if (attributes != null) 'attributes': attributes,
      if (price != null) 'price': price,
      if (weightKg != null) 'weight_kg': weightKg,
      if (volumeLiters != null) 'volume_liters': volumeLiters,
      if (isDefault != null) 'is_default': isDefault,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProductVariantsCompanion copyWith({
    Value<String>? id,
    Value<String>? productId,
    Value<String>? sku,
    Value<String?>? barcode,
    Value<String>? attributes,
    Value<double>? price,
    Value<double?>? weightKg,
    Value<double?>? volumeLiters,
    Value<bool>? isDefault,
    Value<bool>? isActive,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return LocalProductVariantsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      sku: sku ?? this.sku,
      barcode: barcode ?? this.barcode,
      attributes: attributes ?? this.attributes,
      price: price ?? this.price,
      weightKg: weightKg ?? this.weightKg,
      volumeLiters: volumeLiters ?? this.volumeLiters,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (sku.present) {
      map['sku'] = Variable<String>(sku.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (attributes.present) {
      map['attributes'] = Variable<String>(attributes.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (volumeLiters.present) {
      map['volume_liters'] = Variable<double>(volumeLiters.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductVariantsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('sku: $sku, ')
          ..write('barcode: $barcode, ')
          ..write('attributes: $attributes, ')
          ..write('price: $price, ')
          ..write('weightKg: $weightKg, ')
          ..write('volumeLiters: $volumeLiters, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPriceListsTable extends LocalPriceLists
    with TableInfo<$LocalPriceListsTable, LocalPriceList> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPriceListsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _customerTypeMeta = const VerificationMeta(
    'customerType',
  );
  @override
  late final GeneratedColumn<String> customerType = GeneratedColumn<String>(
    'customer_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isDefaultMeta = const VerificationMeta(
    'isDefault',
  );
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
    'is_default',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_default" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _validFromMeta = const VerificationMeta(
    'validFrom',
  );
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
    'valid_from',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _validToMeta = const VerificationMeta(
    'validTo',
  );
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
    'valid_to',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    name,
    description,
    customerType,
    isDefault,
    isActive,
    validFrom,
    validTo,
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_price_lists';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPriceList> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('customer_type')) {
      context.handle(
        _customerTypeMeta,
        customerType.isAcceptableOrUnknown(
          data['customer_type']!,
          _customerTypeMeta,
        ),
      );
    }
    if (data.containsKey('is_default')) {
      context.handle(
        _isDefaultMeta,
        isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('valid_from')) {
      context.handle(
        _validFromMeta,
        validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta),
      );
    }
    if (data.containsKey('valid_to')) {
      context.handle(
        _validToMeta,
        validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPriceList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPriceList(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      customerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}customer_type'],
      ),
      isDefault: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_default'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      validFrom: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_from'],
      ),
      validTo: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}valid_to'],
      ),
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $LocalPriceListsTable createAlias(String alias) {
    return $LocalPriceListsTable(attachedDatabase, alias);
  }
}

class LocalPriceList extends DataClass implements Insertable<LocalPriceList> {
  final String id;
  final String tenantId;
  final String name;
  final String? description;
  final String? customerType;
  final bool isDefault;
  final bool isActive;
  final DateTime? validFrom;
  final DateTime? validTo;
  final DateTime? lastSync;
  const LocalPriceList({
    required this.id,
    required this.tenantId,
    required this.name,
    this.description,
    this.customerType,
    required this.isDefault,
    required this.isActive,
    this.validFrom,
    this.validTo,
    this.lastSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || customerType != null) {
      map['customer_type'] = Variable<String>(customerType);
    }
    map['is_default'] = Variable<bool>(isDefault);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || validFrom != null) {
      map['valid_from'] = Variable<DateTime>(validFrom);
    }
    if (!nullToAbsent || validTo != null) {
      map['valid_to'] = Variable<DateTime>(validTo);
    }
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  LocalPriceListsCompanion toCompanion(bool nullToAbsent) {
    return LocalPriceListsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      customerType: customerType == null && nullToAbsent
          ? const Value.absent()
          : Value(customerType),
      isDefault: Value(isDefault),
      isActive: Value(isActive),
      validFrom: validFrom == null && nullToAbsent
          ? const Value.absent()
          : Value(validFrom),
      validTo: validTo == null && nullToAbsent
          ? const Value.absent()
          : Value(validTo),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory LocalPriceList.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPriceList(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      customerType: serializer.fromJson<String?>(json['customerType']),
      isDefault: serializer.fromJson<bool>(json['isDefault']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      validFrom: serializer.fromJson<DateTime?>(json['validFrom']),
      validTo: serializer.fromJson<DateTime?>(json['validTo']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'customerType': serializer.toJson<String?>(customerType),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isActive': serializer.toJson<bool>(isActive),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  LocalPriceList copyWith({
    String? id,
    String? tenantId,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> customerType = const Value.absent(),
    bool? isDefault,
    bool? isActive,
    Value<DateTime?> validFrom = const Value.absent(),
    Value<DateTime?> validTo = const Value.absent(),
    Value<DateTime?> lastSync = const Value.absent(),
  }) => LocalPriceList(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    customerType: customerType.present ? customerType.value : this.customerType,
    isDefault: isDefault ?? this.isDefault,
    isActive: isActive ?? this.isActive,
    validFrom: validFrom.present ? validFrom.value : this.validFrom,
    validTo: validTo.present ? validTo.value : this.validTo,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  LocalPriceList copyWithCompanion(LocalPriceListsCompanion data) {
    return LocalPriceList(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      customerType: data.customerType.present
          ? data.customerType.value
          : this.customerType,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPriceList(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('customerType: $customerType, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    name,
    description,
    customerType,
    isDefault,
    isActive,
    validFrom,
    validTo,
    lastSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPriceList &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.description == this.description &&
          other.customerType == this.customerType &&
          other.isDefault == this.isDefault &&
          other.isActive == this.isActive &&
          other.validFrom == this.validFrom &&
          other.validTo == this.validTo &&
          other.lastSync == this.lastSync);
}

class LocalPriceListsCompanion extends UpdateCompanion<LocalPriceList> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> customerType;
  final Value<bool> isDefault;
  final Value<bool> isActive;
  final Value<DateTime?> validFrom;
  final Value<DateTime?> validTo;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const LocalPriceListsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.customerType = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPriceListsCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.description = const Value.absent(),
    this.customerType = const Value.absent(),
    this.isDefault = const Value.absent(),
    this.isActive = const Value.absent(),
    this.validFrom = const Value.absent(),
    this.validTo = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       name = Value(name);
  static Insertable<LocalPriceList> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? customerType,
    Expression<bool>? isDefault,
    Expression<bool>? isActive,
    Expression<DateTime>? validFrom,
    Expression<DateTime>? validTo,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (customerType != null) 'customer_type': customerType,
      if (isDefault != null) 'is_default': isDefault,
      if (isActive != null) 'is_active': isActive,
      if (validFrom != null) 'valid_from': validFrom,
      if (validTo != null) 'valid_to': validTo,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPriceListsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? customerType,
    Value<bool>? isDefault,
    Value<bool>? isActive,
    Value<DateTime?>? validFrom,
    Value<DateTime?>? validTo,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return LocalPriceListsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      description: description ?? this.description,
      customerType: customerType ?? this.customerType,
      isDefault: isDefault ?? this.isDefault,
      isActive: isActive ?? this.isActive,
      validFrom: validFrom ?? this.validFrom,
      validTo: validTo ?? this.validTo,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (customerType.present) {
      map['customer_type'] = Variable<String>(customerType.value);
    }
    if (isDefault.present) {
      map['is_default'] = Variable<bool>(isDefault.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (validFrom.present) {
      map['valid_from'] = Variable<DateTime>(validFrom.value);
    }
    if (validTo.present) {
      map['valid_to'] = Variable<DateTime>(validTo.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPriceListsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('customerType: $customerType, ')
          ..write('isDefault: $isDefault, ')
          ..write('isActive: $isActive, ')
          ..write('validFrom: $validFrom, ')
          ..write('validTo: $validTo, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalPriceListItemsTable extends LocalPriceListItems
    with TableInfo<$LocalPriceListItemsTable, LocalPriceListItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalPriceListItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceListIdMeta = const VerificationMeta(
    'priceListId',
  );
  @override
  late final GeneratedColumn<String> priceListId = GeneratedColumn<String>(
    'price_list_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_price_lists (id)',
    ),
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_product_variants (id)',
    ),
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costPriceMeta = const VerificationMeta(
    'costPrice',
  );
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
    'cost_price',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minQuantityMeta = const VerificationMeta(
    'minQuantity',
  );
  @override
  late final GeneratedColumn<int> minQuantity = GeneratedColumn<int>(
    'min_quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _maxQuantityMeta = const VerificationMeta(
    'maxQuantity',
  );
  @override
  late final GeneratedColumn<int> maxQuantity = GeneratedColumn<int>(
    'max_quantity',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _volumeDiscountPercentMeta =
      const VerificationMeta('volumeDiscountPercent');
  @override
  late final GeneratedColumn<double> volumeDiscountPercent =
      GeneratedColumn<double>(
        'volume_discount_percent',
        aliasedName,
        false,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _lastSyncMeta = const VerificationMeta(
    'lastSync',
  );
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
    'last_sync',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    priceListId,
    variantId,
    price,
    costPrice,
    minQuantity,
    maxQuantity,
    volumeDiscountPercent,
    isActive,
    lastSync,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_price_list_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalPriceListItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('price_list_id')) {
      context.handle(
        _priceListIdMeta,
        priceListId.isAcceptableOrUnknown(
          data['price_list_id']!,
          _priceListIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_priceListIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(
        _costPriceMeta,
        costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta),
      );
    }
    if (data.containsKey('min_quantity')) {
      context.handle(
        _minQuantityMeta,
        minQuantity.isAcceptableOrUnknown(
          data['min_quantity']!,
          _minQuantityMeta,
        ),
      );
    }
    if (data.containsKey('max_quantity')) {
      context.handle(
        _maxQuantityMeta,
        maxQuantity.isAcceptableOrUnknown(
          data['max_quantity']!,
          _maxQuantityMeta,
        ),
      );
    }
    if (data.containsKey('volume_discount_percent')) {
      context.handle(
        _volumeDiscountPercentMeta,
        volumeDiscountPercent.isAcceptableOrUnknown(
          data['volume_discount_percent']!,
          _volumeDiscountPercentMeta,
        ),
      );
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('last_sync')) {
      context.handle(
        _lastSyncMeta,
        lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPriceListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPriceListItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      priceListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_list_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      costPrice: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cost_price'],
      ),
      minQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}min_quantity'],
      )!,
      maxQuantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_quantity'],
      ),
      volumeDiscountPercent: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume_discount_percent'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      lastSync: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_sync'],
      ),
    );
  }

  @override
  $LocalPriceListItemsTable createAlias(String alias) {
    return $LocalPriceListItemsTable(attachedDatabase, alias);
  }
}

class LocalPriceListItem extends DataClass
    implements Insertable<LocalPriceListItem> {
  final String id;
  final String tenantId;
  final String priceListId;
  final String variantId;
  final double price;
  final double? costPrice;
  final int minQuantity;
  final int? maxQuantity;
  final double volumeDiscountPercent;
  final bool isActive;
  final DateTime? lastSync;
  const LocalPriceListItem({
    required this.id,
    required this.tenantId,
    required this.priceListId,
    required this.variantId,
    required this.price,
    this.costPrice,
    required this.minQuantity,
    this.maxQuantity,
    required this.volumeDiscountPercent,
    required this.isActive,
    this.lastSync,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['price_list_id'] = Variable<String>(priceListId);
    map['variant_id'] = Variable<String>(variantId);
    map['price'] = Variable<double>(price);
    if (!nullToAbsent || costPrice != null) {
      map['cost_price'] = Variable<double>(costPrice);
    }
    map['min_quantity'] = Variable<int>(minQuantity);
    if (!nullToAbsent || maxQuantity != null) {
      map['max_quantity'] = Variable<int>(maxQuantity);
    }
    map['volume_discount_percent'] = Variable<double>(volumeDiscountPercent);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    return map;
  }

  LocalPriceListItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalPriceListItemsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      priceListId: Value(priceListId),
      variantId: Value(variantId),
      price: Value(price),
      costPrice: costPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(costPrice),
      minQuantity: Value(minQuantity),
      maxQuantity: maxQuantity == null && nullToAbsent
          ? const Value.absent()
          : Value(maxQuantity),
      volumeDiscountPercent: Value(volumeDiscountPercent),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
    );
  }

  factory LocalPriceListItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalPriceListItem(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      priceListId: serializer.fromJson<String>(json['priceListId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      price: serializer.fromJson<double>(json['price']),
      costPrice: serializer.fromJson<double?>(json['costPrice']),
      minQuantity: serializer.fromJson<int>(json['minQuantity']),
      maxQuantity: serializer.fromJson<int?>(json['maxQuantity']),
      volumeDiscountPercent: serializer.fromJson<double>(
        json['volumeDiscountPercent'],
      ),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'priceListId': serializer.toJson<String>(priceListId),
      'variantId': serializer.toJson<String>(variantId),
      'price': serializer.toJson<double>(price),
      'costPrice': serializer.toJson<double?>(costPrice),
      'minQuantity': serializer.toJson<int>(minQuantity),
      'maxQuantity': serializer.toJson<int?>(maxQuantity),
      'volumeDiscountPercent': serializer.toJson<double>(volumeDiscountPercent),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
    };
  }

  LocalPriceListItem copyWith({
    String? id,
    String? tenantId,
    String? priceListId,
    String? variantId,
    double? price,
    Value<double?> costPrice = const Value.absent(),
    int? minQuantity,
    Value<int?> maxQuantity = const Value.absent(),
    double? volumeDiscountPercent,
    bool? isActive,
    Value<DateTime?> lastSync = const Value.absent(),
  }) => LocalPriceListItem(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    priceListId: priceListId ?? this.priceListId,
    variantId: variantId ?? this.variantId,
    price: price ?? this.price,
    costPrice: costPrice.present ? costPrice.value : this.costPrice,
    minQuantity: minQuantity ?? this.minQuantity,
    maxQuantity: maxQuantity.present ? maxQuantity.value : this.maxQuantity,
    volumeDiscountPercent: volumeDiscountPercent ?? this.volumeDiscountPercent,
    isActive: isActive ?? this.isActive,
    lastSync: lastSync.present ? lastSync.value : this.lastSync,
  );
  LocalPriceListItem copyWithCompanion(LocalPriceListItemsCompanion data) {
    return LocalPriceListItem(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      priceListId: data.priceListId.present
          ? data.priceListId.value
          : this.priceListId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      price: data.price.present ? data.price.value : this.price,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      minQuantity: data.minQuantity.present
          ? data.minQuantity.value
          : this.minQuantity,
      maxQuantity: data.maxQuantity.present
          ? data.maxQuantity.value
          : this.maxQuantity,
      volumeDiscountPercent: data.volumeDiscountPercent.present
          ? data.volumeDiscountPercent.value
          : this.volumeDiscountPercent,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalPriceListItem(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('priceListId: $priceListId, ')
          ..write('variantId: $variantId, ')
          ..write('price: $price, ')
          ..write('costPrice: $costPrice, ')
          ..write('minQuantity: $minQuantity, ')
          ..write('maxQuantity: $maxQuantity, ')
          ..write('volumeDiscountPercent: $volumeDiscountPercent, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    priceListId,
    variantId,
    price,
    costPrice,
    minQuantity,
    maxQuantity,
    volumeDiscountPercent,
    isActive,
    lastSync,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalPriceListItem &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.priceListId == this.priceListId &&
          other.variantId == this.variantId &&
          other.price == this.price &&
          other.costPrice == this.costPrice &&
          other.minQuantity == this.minQuantity &&
          other.maxQuantity == this.maxQuantity &&
          other.volumeDiscountPercent == this.volumeDiscountPercent &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync);
}

class LocalPriceListItemsCompanion extends UpdateCompanion<LocalPriceListItem> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> priceListId;
  final Value<String> variantId;
  final Value<double> price;
  final Value<double?> costPrice;
  final Value<int> minQuantity;
  final Value<int?> maxQuantity;
  final Value<double> volumeDiscountPercent;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<int> rowid;
  const LocalPriceListItemsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.price = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.minQuantity = const Value.absent(),
    this.maxQuantity = const Value.absent(),
    this.volumeDiscountPercent = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalPriceListItemsCompanion.insert({
    required String id,
    required String tenantId,
    required String priceListId,
    required String variantId,
    required double price,
    this.costPrice = const Value.absent(),
    this.minQuantity = const Value.absent(),
    this.maxQuantity = const Value.absent(),
    this.volumeDiscountPercent = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       priceListId = Value(priceListId),
       variantId = Value(variantId),
       price = Value(price);
  static Insertable<LocalPriceListItem> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? priceListId,
    Expression<String>? variantId,
    Expression<double>? price,
    Expression<double>? costPrice,
    Expression<int>? minQuantity,
    Expression<int>? maxQuantity,
    Expression<double>? volumeDiscountPercent,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (priceListId != null) 'price_list_id': priceListId,
      if (variantId != null) 'variant_id': variantId,
      if (price != null) 'price': price,
      if (costPrice != null) 'cost_price': costPrice,
      if (minQuantity != null) 'min_quantity': minQuantity,
      if (maxQuantity != null) 'max_quantity': maxQuantity,
      if (volumeDiscountPercent != null)
        'volume_discount_percent': volumeDiscountPercent,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPriceListItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? priceListId,
    Value<String>? variantId,
    Value<double>? price,
    Value<double?>? costPrice,
    Value<int>? minQuantity,
    Value<int?>? maxQuantity,
    Value<double>? volumeDiscountPercent,
    Value<bool>? isActive,
    Value<DateTime?>? lastSync,
    Value<int>? rowid,
  }) {
    return LocalPriceListItemsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      priceListId: priceListId ?? this.priceListId,
      variantId: variantId ?? this.variantId,
      price: price ?? this.price,
      costPrice: costPrice ?? this.costPrice,
      minQuantity: minQuantity ?? this.minQuantity,
      maxQuantity: maxQuantity ?? this.maxQuantity,
      volumeDiscountPercent:
          volumeDiscountPercent ?? this.volumeDiscountPercent,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (priceListId.present) {
      map['price_list_id'] = Variable<String>(priceListId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (costPrice.present) {
      map['cost_price'] = Variable<double>(costPrice.value);
    }
    if (minQuantity.present) {
      map['min_quantity'] = Variable<int>(minQuantity.value);
    }
    if (maxQuantity.present) {
      map['max_quantity'] = Variable<int>(maxQuantity.value);
    }
    if (volumeDiscountPercent.present) {
      map['volume_discount_percent'] = Variable<double>(
        volumeDiscountPercent.value,
      );
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalPriceListItemsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('priceListId: $priceListId, ')
          ..write('variantId: $variantId, ')
          ..write('price: $price, ')
          ..write('costPrice: $costPrice, ')
          ..write('minQuantity: $minQuantity, ')
          ..write('maxQuantity: $maxQuantity, ')
          ..write('volumeDiscountPercent: $volumeDiscountPercent, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCustomersTable extends LocalCustomers
    with TableInfo<$LocalCustomersTable, LocalCustomer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCustomersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
    'tax_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priceListIdMeta = const VerificationMeta(
    'priceListId',
  );
  @override
  late final GeneratedColumn<String> priceListId = GeneratedColumn<String>(
    'price_list_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_price_lists (id)',
    ),
  );
  static const VerificationMeta _creditLimitMeta = const VerificationMeta(
    'creditLimit',
  );
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
    'credit_limit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _availableCreditMeta = const VerificationMeta(
    'availableCredit',
  );
  @override
  late final GeneratedColumn<double> availableCredit = GeneratedColumn<double>(
    'available_credit',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    fullName,
    taxId,
    email,
    phoneNumber,
    address,
    priceListId,
    creditLimit,
    availableCredit,
    synced,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_customers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCustomer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('tax_id')) {
      context.handle(
        _taxIdMeta,
        taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('price_list_id')) {
      context.handle(
        _priceListIdMeta,
        priceListId.isAcceptableOrUnknown(
          data['price_list_id']!,
          _priceListIdMeta,
        ),
      );
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
        _creditLimitMeta,
        creditLimit.isAcceptableOrUnknown(
          data['credit_limit']!,
          _creditLimitMeta,
        ),
      );
    }
    if (data.containsKey('available_credit')) {
      context.handle(
        _availableCreditMeta,
        availableCredit.isAcceptableOrUnknown(
          data['available_credit']!,
          _availableCreditMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCustomer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCustomer(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      taxId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tax_id'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      ),
      priceListId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}price_list_id'],
      ),
      creditLimit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}credit_limit'],
      )!,
      availableCredit: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}available_credit'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $LocalCustomersTable createAlias(String alias) {
    return $LocalCustomersTable(attachedDatabase, alias);
  }
}

class LocalCustomer extends DataClass implements Insertable<LocalCustomer> {
  final String id;
  final String tenantId;
  final String fullName;
  final String? taxId;
  final String? email;
  final String? phoneNumber;
  final String? address;
  final String? priceListId;
  final double creditLimit;
  final double availableCredit;
  final bool synced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalCustomer({
    required this.id,
    required this.tenantId,
    required this.fullName,
    this.taxId,
    this.email,
    this.phoneNumber,
    this.address,
    this.priceListId,
    required this.creditLimit,
    required this.availableCredit,
    required this.synced,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || priceListId != null) {
      map['price_list_id'] = Variable<String>(priceListId);
    }
    map['credit_limit'] = Variable<double>(creditLimit);
    map['available_credit'] = Variable<double>(availableCredit);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalCustomersCompanion toCompanion(bool nullToAbsent) {
    return LocalCustomersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      fullName: Value(fullName),
      taxId: taxId == null && nullToAbsent
          ? const Value.absent()
          : Value(taxId),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      priceListId: priceListId == null && nullToAbsent
          ? const Value.absent()
          : Value(priceListId),
      creditLimit: Value(creditLimit),
      availableCredit: Value(availableCredit),
      synced: Value(synced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalCustomer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCustomer(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      email: serializer.fromJson<String?>(json['email']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      address: serializer.fromJson<String?>(json['address']),
      priceListId: serializer.fromJson<String?>(json['priceListId']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
      availableCredit: serializer.fromJson<double>(json['availableCredit']),
      synced: serializer.fromJson<bool>(json['synced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'fullName': serializer.toJson<String>(fullName),
      'taxId': serializer.toJson<String?>(taxId),
      'email': serializer.toJson<String?>(email),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'address': serializer.toJson<String?>(address),
      'priceListId': serializer.toJson<String?>(priceListId),
      'creditLimit': serializer.toJson<double>(creditLimit),
      'availableCredit': serializer.toJson<double>(availableCredit),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalCustomer copyWith({
    String? id,
    String? tenantId,
    String? fullName,
    Value<String?> taxId = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> address = const Value.absent(),
    Value<String?> priceListId = const Value.absent(),
    double? creditLimit,
    double? availableCredit,
    bool? synced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => LocalCustomer(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    fullName: fullName ?? this.fullName,
    taxId: taxId.present ? taxId.value : this.taxId,
    email: email.present ? email.value : this.email,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    address: address.present ? address.value : this.address,
    priceListId: priceListId.present ? priceListId.value : this.priceListId,
    creditLimit: creditLimit ?? this.creditLimit,
    availableCredit: availableCredit ?? this.availableCredit,
    synced: synced ?? this.synced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  LocalCustomer copyWithCompanion(LocalCustomersCompanion data) {
    return LocalCustomer(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      address: data.address.present ? data.address.value : this.address,
      priceListId: data.priceListId.present
          ? data.priceListId.value
          : this.priceListId,
      creditLimit: data.creditLimit.present
          ? data.creditLimit.value
          : this.creditLimit,
      availableCredit: data.availableCredit.present
          ? data.availableCredit.value
          : this.availableCredit,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomer(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('fullName: $fullName, ')
          ..write('taxId: $taxId, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('address: $address, ')
          ..write('priceListId: $priceListId, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('availableCredit: $availableCredit, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    fullName,
    taxId,
    email,
    phoneNumber,
    address,
    priceListId,
    creditLimit,
    availableCredit,
    synced,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCustomer &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.fullName == this.fullName &&
          other.taxId == this.taxId &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.address == this.address &&
          other.priceListId == this.priceListId &&
          other.creditLimit == this.creditLimit &&
          other.availableCredit == this.availableCredit &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalCustomersCompanion extends UpdateCompanion<LocalCustomer> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> fullName;
  final Value<String?> taxId;
  final Value<String?> email;
  final Value<String?> phoneNumber;
  final Value<String?> address;
  final Value<String?> priceListId;
  final Value<double> creditLimit;
  final Value<double> availableCredit;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalCustomersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.taxId = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.availableCredit = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCustomersCompanion.insert({
    required String id,
    required String tenantId,
    required String fullName,
    this.taxId = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.address = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.availableCredit = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       fullName = Value(fullName);
  static Insertable<LocalCustomer> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? fullName,
    Expression<String>? taxId,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? address,
    Expression<String>? priceListId,
    Expression<double>? creditLimit,
    Expression<double>? availableCredit,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (fullName != null) 'full_name': fullName,
      if (taxId != null) 'tax_id': taxId,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (address != null) 'address': address,
      if (priceListId != null) 'price_list_id': priceListId,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (availableCredit != null) 'available_credit': availableCredit,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCustomersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? fullName,
    Value<String?>? taxId,
    Value<String?>? email,
    Value<String?>? phoneNumber,
    Value<String?>? address,
    Value<String?>? priceListId,
    Value<double>? creditLimit,
    Value<double>? availableCredit,
    Value<bool>? synced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return LocalCustomersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      fullName: fullName ?? this.fullName,
      taxId: taxId ?? this.taxId,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      address: address ?? this.address,
      priceListId: priceListId ?? this.priceListId,
      creditLimit: creditLimit ?? this.creditLimit,
      availableCredit: availableCredit ?? this.availableCredit,
      synced: synced ?? this.synced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (priceListId.present) {
      map['price_list_id'] = Variable<String>(priceListId.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (availableCredit.present) {
      map['available_credit'] = Variable<double>(availableCredit.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCustomersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('fullName: $fullName, ')
          ..write('taxId: $taxId, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('address: $address, ')
          ..write('priceListId: $priceListId, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('availableCredit: $availableCredit, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCashRegistersTable extends LocalCashRegisters
    with TableInfo<$LocalCashRegistersTable, LocalCashRegister> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashRegistersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    branchId,
    code,
    name,
    isActive,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_registers';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCashRegister> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashRegister map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashRegister(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
    );
  }

  @override
  $LocalCashRegistersTable createAlias(String alias) {
    return $LocalCashRegistersTable(attachedDatabase, alias);
  }
}

class LocalCashRegister extends DataClass
    implements Insertable<LocalCashRegister> {
  final String id;
  final String tenantId;
  final String branchId;
  final String code;
  final String name;
  final bool isActive;
  const LocalCashRegister({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.code,
    required this.name,
    required this.isActive,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    map['is_active'] = Variable<bool>(isActive);
    return map;
  }

  LocalCashRegistersCompanion toCompanion(bool nullToAbsent) {
    return LocalCashRegistersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      code: Value(code),
      name: Value(name),
      isActive: Value(isActive),
    );
  }

  factory LocalCashRegister.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashRegister(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      isActive: serializer.fromJson<bool>(json['isActive']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'isActive': serializer.toJson<bool>(isActive),
    };
  }

  LocalCashRegister copyWith({
    String? id,
    String? tenantId,
    String? branchId,
    String? code,
    String? name,
    bool? isActive,
  }) => LocalCashRegister(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    branchId: branchId ?? this.branchId,
    code: code ?? this.code,
    name: name ?? this.name,
    isActive: isActive ?? this.isActive,
  );
  LocalCashRegister copyWithCompanion(LocalCashRegistersCompanion data) {
    return LocalCashRegister(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashRegister(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, branchId, code, name, isActive);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashRegister &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.code == this.code &&
          other.name == this.name &&
          other.isActive == this.isActive);
}

class LocalCashRegistersCompanion extends UpdateCompanion<LocalCashRegister> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> code;
  final Value<String> name;
  final Value<bool> isActive;
  final Value<int> rowid;
  const LocalCashRegistersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashRegistersCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String code,
    required String name,
    this.isActive = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       branchId = Value(branchId),
       code = Value(code),
       name = Value(name);
  static Insertable<LocalCashRegister> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? code,
    Expression<String>? name,
    Expression<bool>? isActive,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (isActive != null) 'is_active': isActive,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashRegistersCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? branchId,
    Value<String>? code,
    Value<String>? name,
    Value<bool>? isActive,
    Value<int>? rowid,
  }) {
    return LocalCashRegistersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      code: code ?? this.code,
      name: name ?? this.name,
      isActive: isActive ?? this.isActive,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashRegistersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('isActive: $isActive, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCashSessionsTable extends LocalCashSessions
    with TableInfo<$LocalCashSessionsTable, LocalCashSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashRegisterIdMeta = const VerificationMeta(
    'cashRegisterId',
  );
  @override
  late final GeneratedColumn<String> cashRegisterId = GeneratedColumn<String>(
    'cash_register_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_cash_registers (id)',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _initialAmountMeta = const VerificationMeta(
    'initialAmount',
  );
  @override
  late final GeneratedColumn<double> initialAmount = GeneratedColumn<double>(
    'initial_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _systemAmountMeta = const VerificationMeta(
    'systemAmount',
  );
  @override
  late final GeneratedColumn<double> systemAmount = GeneratedColumn<double>(
    'system_amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _declaredAmountMeta = const VerificationMeta(
    'declaredAmount',
  );
  @override
  late final GeneratedColumn<double> declaredAmount = GeneratedColumn<double>(
    'declared_amount',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<SessionStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('open'),
      ).withConverter<SessionStatus>($LocalCashSessionsTable.$converterstatus);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _openingDateMeta = const VerificationMeta(
    'openingDate',
  );
  @override
  late final GeneratedColumn<DateTime> openingDate = GeneratedColumn<DateTime>(
    'opening_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _closingDateMeta = const VerificationMeta(
    'closingDate',
  );
  @override
  late final GeneratedColumn<DateTime> closingDate = GeneratedColumn<DateTime>(
    'closing_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    cashRegisterId,
    userId,
    initialAmount,
    systemAmount,
    declaredAmount,
    status,
    synced,
    syncedAt,
    localId,
    openingDate,
    closingDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCashSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
        _cashRegisterIdMeta,
        cashRegisterId.isAcceptableOrUnknown(
          data['cash_register_id']!,
          _cashRegisterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_cashRegisterIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('initial_amount')) {
      context.handle(
        _initialAmountMeta,
        initialAmount.isAcceptableOrUnknown(
          data['initial_amount']!,
          _initialAmountMeta,
        ),
      );
    }
    if (data.containsKey('system_amount')) {
      context.handle(
        _systemAmountMeta,
        systemAmount.isAcceptableOrUnknown(
          data['system_amount']!,
          _systemAmountMeta,
        ),
      );
    }
    if (data.containsKey('declared_amount')) {
      context.handle(
        _declaredAmountMeta,
        declaredAmount.isAcceptableOrUnknown(
          data['declared_amount']!,
          _declaredAmountMeta,
        ),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('opening_date')) {
      context.handle(
        _openingDateMeta,
        openingDate.isAcceptableOrUnknown(
          data['opening_date']!,
          _openingDateMeta,
        ),
      );
    }
    if (data.containsKey('closing_date')) {
      context.handle(
        _closingDateMeta,
        closingDate.isAcceptableOrUnknown(
          data['closing_date']!,
          _closingDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      cashRegisterId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cash_register_id'],
      )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      )!,
      initialAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}initial_amount'],
      )!,
      systemAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}system_amount'],
      )!,
      declaredAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}declared_amount'],
      ),
      status: $LocalCashSessionsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      openingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}opening_date'],
      )!,
      closingDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}closing_date'],
      ),
    );
  }

  @override
  $LocalCashSessionsTable createAlias(String alias) {
    return $LocalCashSessionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SessionStatus, String, String> $converterstatus =
      const EnumNameConverter<SessionStatus>(SessionStatus.values);
}

class LocalCashSession extends DataClass
    implements Insertable<LocalCashSession> {
  final String id;
  final String tenantId;
  final String cashRegisterId;
  final String userId;
  final double initialAmount;
  final double systemAmount;
  final double? declaredAmount;
  final SessionStatus status;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime openingDate;
  final DateTime? closingDate;
  const LocalCashSession({
    required this.id,
    required this.tenantId,
    required this.cashRegisterId,
    required this.userId,
    required this.initialAmount,
    required this.systemAmount,
    this.declaredAmount,
    required this.status,
    required this.synced,
    this.syncedAt,
    required this.localId,
    required this.openingDate,
    this.closingDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['cash_register_id'] = Variable<String>(cashRegisterId);
    map['user_id'] = Variable<String>(userId);
    map['initial_amount'] = Variable<double>(initialAmount);
    map['system_amount'] = Variable<double>(systemAmount);
    if (!nullToAbsent || declaredAmount != null) {
      map['declared_amount'] = Variable<double>(declaredAmount);
    }
    {
      map['status'] = Variable<String>(
        $LocalCashSessionsTable.$converterstatus.toSql(status),
      );
    }
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['opening_date'] = Variable<DateTime>(openingDate);
    if (!nullToAbsent || closingDate != null) {
      map['closing_date'] = Variable<DateTime>(closingDate);
    }
    return map;
  }

  LocalCashSessionsCompanion toCompanion(bool nullToAbsent) {
    return LocalCashSessionsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      cashRegisterId: Value(cashRegisterId),
      userId: Value(userId),
      initialAmount: Value(initialAmount),
      systemAmount: Value(systemAmount),
      declaredAmount: declaredAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(declaredAmount),
      status: Value(status),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      openingDate: Value(openingDate),
      closingDate: closingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(closingDate),
    );
  }

  factory LocalCashSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashSession(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      cashRegisterId: serializer.fromJson<String>(json['cashRegisterId']),
      userId: serializer.fromJson<String>(json['userId']),
      initialAmount: serializer.fromJson<double>(json['initialAmount']),
      systemAmount: serializer.fromJson<double>(json['systemAmount']),
      declaredAmount: serializer.fromJson<double?>(json['declaredAmount']),
      status: $LocalCashSessionsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      openingDate: serializer.fromJson<DateTime>(json['openingDate']),
      closingDate: serializer.fromJson<DateTime?>(json['closingDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'cashRegisterId': serializer.toJson<String>(cashRegisterId),
      'userId': serializer.toJson<String>(userId),
      'initialAmount': serializer.toJson<double>(initialAmount),
      'systemAmount': serializer.toJson<double>(systemAmount),
      'declaredAmount': serializer.toJson<double?>(declaredAmount),
      'status': serializer.toJson<String>(
        $LocalCashSessionsTable.$converterstatus.toJson(status),
      ),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'openingDate': serializer.toJson<DateTime>(openingDate),
      'closingDate': serializer.toJson<DateTime?>(closingDate),
    };
  }

  LocalCashSession copyWith({
    String? id,
    String? tenantId,
    String? cashRegisterId,
    String? userId,
    double? initialAmount,
    double? systemAmount,
    Value<double?> declaredAmount = const Value.absent(),
    SessionStatus? status,
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
    String? localId,
    DateTime? openingDate,
    Value<DateTime?> closingDate = const Value.absent(),
  }) => LocalCashSession(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    cashRegisterId: cashRegisterId ?? this.cashRegisterId,
    userId: userId ?? this.userId,
    initialAmount: initialAmount ?? this.initialAmount,
    systemAmount: systemAmount ?? this.systemAmount,
    declaredAmount: declaredAmount.present
        ? declaredAmount.value
        : this.declaredAmount,
    status: status ?? this.status,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    localId: localId ?? this.localId,
    openingDate: openingDate ?? this.openingDate,
    closingDate: closingDate.present ? closingDate.value : this.closingDate,
  );
  LocalCashSession copyWithCompanion(LocalCashSessionsCompanion data) {
    return LocalCashSession(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      userId: data.userId.present ? data.userId.value : this.userId,
      initialAmount: data.initialAmount.present
          ? data.initialAmount.value
          : this.initialAmount,
      systemAmount: data.systemAmount.present
          ? data.systemAmount.value
          : this.systemAmount,
      declaredAmount: data.declaredAmount.present
          ? data.declaredAmount.value
          : this.declaredAmount,
      status: data.status.present ? data.status.value : this.status,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      openingDate: data.openingDate.present
          ? data.openingDate.value
          : this.openingDate,
      closingDate: data.closingDate.present
          ? data.closingDate.value
          : this.closingDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashSession(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('userId: $userId, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('systemAmount: $systemAmount, ')
          ..write('declaredAmount: $declaredAmount, ')
          ..write('status: $status, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('openingDate: $openingDate, ')
          ..write('closingDate: $closingDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    cashRegisterId,
    userId,
    initialAmount,
    systemAmount,
    declaredAmount,
    status,
    synced,
    syncedAt,
    localId,
    openingDate,
    closingDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashSession &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.cashRegisterId == this.cashRegisterId &&
          other.userId == this.userId &&
          other.initialAmount == this.initialAmount &&
          other.systemAmount == this.systemAmount &&
          other.declaredAmount == this.declaredAmount &&
          other.status == this.status &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.openingDate == this.openingDate &&
          other.closingDate == this.closingDate);
}

class LocalCashSessionsCompanion extends UpdateCompanion<LocalCashSession> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> cashRegisterId;
  final Value<String> userId;
  final Value<double> initialAmount;
  final Value<double> systemAmount;
  final Value<double?> declaredAmount;
  final Value<SessionStatus> status;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> openingDate;
  final Value<DateTime?> closingDate;
  final Value<int> rowid;
  const LocalCashSessionsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.userId = const Value.absent(),
    this.initialAmount = const Value.absent(),
    this.systemAmount = const Value.absent(),
    this.declaredAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashSessionsCompanion.insert({
    required String id,
    required String tenantId,
    required String cashRegisterId,
    required String userId,
    this.initialAmount = const Value.absent(),
    this.systemAmount = const Value.absent(),
    this.declaredAmount = const Value.absent(),
    this.status = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.openingDate = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       cashRegisterId = Value(cashRegisterId),
       userId = Value(userId),
       localId = Value(localId);
  static Insertable<LocalCashSession> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? cashRegisterId,
    Expression<String>? userId,
    Expression<double>? initialAmount,
    Expression<double>? systemAmount,
    Expression<double>? declaredAmount,
    Expression<String>? status,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? openingDate,
    Expression<DateTime>? closingDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (userId != null) 'user_id': userId,
      if (initialAmount != null) 'initial_amount': initialAmount,
      if (systemAmount != null) 'system_amount': systemAmount,
      if (declaredAmount != null) 'declared_amount': declaredAmount,
      if (status != null) 'status': status,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (openingDate != null) 'opening_date': openingDate,
      if (closingDate != null) 'closing_date': closingDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? cashRegisterId,
    Value<String>? userId,
    Value<double>? initialAmount,
    Value<double>? systemAmount,
    Value<double?>? declaredAmount,
    Value<SessionStatus>? status,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<String>? localId,
    Value<DateTime>? openingDate,
    Value<DateTime?>? closingDate,
    Value<int>? rowid,
  }) {
    return LocalCashSessionsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      userId: userId ?? this.userId,
      initialAmount: initialAmount ?? this.initialAmount,
      systemAmount: systemAmount ?? this.systemAmount,
      declaredAmount: declaredAmount ?? this.declaredAmount,
      status: status ?? this.status,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      openingDate: openingDate ?? this.openingDate,
      closingDate: closingDate ?? this.closingDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<String>(cashRegisterId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (initialAmount.present) {
      map['initial_amount'] = Variable<double>(initialAmount.value);
    }
    if (systemAmount.present) {
      map['system_amount'] = Variable<double>(systemAmount.value);
    }
    if (declaredAmount.present) {
      map['declared_amount'] = Variable<double>(declaredAmount.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $LocalCashSessionsTable.$converterstatus.toSql(status.value),
      );
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<DateTime>(openingDate.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<DateTime>(closingDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashSessionsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('userId: $userId, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('systemAmount: $systemAmount, ')
          ..write('declaredAmount: $declaredAmount, ')
          ..write('status: $status, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('openingDate: $openingDate, ')
          ..write('closingDate: $closingDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalCashMovementsTable extends LocalCashMovements
    with TableInfo<$LocalCashMovementsTable, LocalCashMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cashSessionIdMeta = const VerificationMeta(
    'cashSessionId',
  );
  @override
  late final GeneratedColumn<String> cashSessionId = GeneratedColumn<String>(
    'cash_session_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_cash_sessions (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<CashMovementType, String>
  movementType =
      GeneratedColumn<String>(
        'movement_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<CashMovementType>(
        $LocalCashMovementsTable.$convertermovementType,
      );
  @override
  late final GeneratedColumnWithTypeConverter<CashMovementCategory?, String>
  category =
      GeneratedColumn<String>(
        'category',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<CashMovementCategory?>(
        $LocalCashMovementsTable.$convertercategoryn,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conceptMeta = const VerificationMeta(
    'concept',
  );
  @override
  late final GeneratedColumn<String> concept = GeneratedColumn<String>(
    'concept',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    cashSessionId,
    movementType,
    category,
    amount,
    concept,
    synced,
    syncedAt,
    localId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalCashMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('cash_session_id')) {
      context.handle(
        _cashSessionIdMeta,
        cashSessionId.isAcceptableOrUnknown(
          data['cash_session_id']!,
          _cashSessionIdMeta,
        ),
      );
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('concept')) {
      context.handle(
        _conceptMeta,
        concept.isAcceptableOrUnknown(data['concept']!, _conceptMeta),
      );
    } else if (isInserting) {
      context.missing(_conceptMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      cashSessionId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cash_session_id'],
      ),
      movementType: $LocalCashMovementsTable.$convertermovementType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}movement_type'],
        )!,
      ),
      category: $LocalCashMovementsTable.$convertercategoryn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}category'],
        ),
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      concept: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}concept'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalCashMovementsTable createAlias(String alias) {
    return $LocalCashMovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CashMovementType, String, String>
  $convertermovementType = const EnumNameConverter<CashMovementType>(
    CashMovementType.values,
  );
  static JsonTypeConverter2<CashMovementCategory, String, String>
  $convertercategory = const EnumNameConverter<CashMovementCategory>(
    CashMovementCategory.values,
  );
  static JsonTypeConverter2<CashMovementCategory?, String?, String?>
  $convertercategoryn = JsonTypeConverter2.asNullable($convertercategory);
}

class LocalCashMovement extends DataClass
    implements Insertable<LocalCashMovement> {
  final String id;
  final String tenantId;
  final String? cashSessionId;
  final CashMovementType movementType;
  final CashMovementCategory? category;
  final double amount;
  final String concept;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  const LocalCashMovement({
    required this.id,
    required this.tenantId,
    this.cashSessionId,
    required this.movementType,
    this.category,
    required this.amount,
    required this.concept,
    required this.synced,
    this.syncedAt,
    required this.localId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    if (!nullToAbsent || cashSessionId != null) {
      map['cash_session_id'] = Variable<String>(cashSessionId);
    }
    {
      map['movement_type'] = Variable<String>(
        $LocalCashMovementsTable.$convertermovementType.toSql(movementType),
      );
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(
        $LocalCashMovementsTable.$convertercategoryn.toSql(category),
      );
    }
    map['amount'] = Variable<double>(amount);
    map['concept'] = Variable<String>(concept);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalCashMovementsCompanion toCompanion(bool nullToAbsent) {
    return LocalCashMovementsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      cashSessionId: cashSessionId == null && nullToAbsent
          ? const Value.absent()
          : Value(cashSessionId),
      movementType: Value(movementType),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      amount: Value(amount),
      concept: Value(concept),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
    );
  }

  factory LocalCashMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashMovement(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      cashSessionId: serializer.fromJson<String?>(json['cashSessionId']),
      movementType: $LocalCashMovementsTable.$convertermovementType.fromJson(
        serializer.fromJson<String>(json['movementType']),
      ),
      category: $LocalCashMovementsTable.$convertercategoryn.fromJson(
        serializer.fromJson<String?>(json['category']),
      ),
      amount: serializer.fromJson<double>(json['amount']),
      concept: serializer.fromJson<String>(json['concept']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'cashSessionId': serializer.toJson<String?>(cashSessionId),
      'movementType': serializer.toJson<String>(
        $LocalCashMovementsTable.$convertermovementType.toJson(movementType),
      ),
      'category': serializer.toJson<String?>(
        $LocalCashMovementsTable.$convertercategoryn.toJson(category),
      ),
      'amount': serializer.toJson<double>(amount),
      'concept': serializer.toJson<String>(concept),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalCashMovement copyWith({
    String? id,
    String? tenantId,
    Value<String?> cashSessionId = const Value.absent(),
    CashMovementType? movementType,
    Value<CashMovementCategory?> category = const Value.absent(),
    double? amount,
    String? concept,
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
    String? localId,
    DateTime? createdAt,
  }) => LocalCashMovement(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    cashSessionId: cashSessionId.present
        ? cashSessionId.value
        : this.cashSessionId,
    movementType: movementType ?? this.movementType,
    category: category.present ? category.value : this.category,
    amount: amount ?? this.amount,
    concept: concept ?? this.concept,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    localId: localId ?? this.localId,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalCashMovement copyWithCompanion(LocalCashMovementsCompanion data) {
    return LocalCashMovement(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      cashSessionId: data.cashSessionId.present
          ? data.cashSessionId.value
          : this.cashSessionId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      concept: data.concept.present ? data.concept.value : this.concept,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashMovement(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('movementType: $movementType, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('concept: $concept, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    cashSessionId,
    movementType,
    category,
    amount,
    concept,
    synced,
    syncedAt,
    localId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashMovement &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.cashSessionId == this.cashSessionId &&
          other.movementType == this.movementType &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.concept == this.concept &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt);
}

class LocalCashMovementsCompanion extends UpdateCompanion<LocalCashMovement> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String?> cashSessionId;
  final Value<CashMovementType> movementType;
  final Value<CashMovementCategory?> category;
  final Value<double> amount;
  final Value<String> concept;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalCashMovementsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.cashSessionId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.concept = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashMovementsCompanion.insert({
    required String id,
    required String tenantId,
    this.cashSessionId = const Value.absent(),
    required CashMovementType movementType,
    this.category = const Value.absent(),
    required double amount,
    required String concept,
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       movementType = Value(movementType),
       amount = Value(amount),
       concept = Value(concept),
       localId = Value(localId);
  static Insertable<LocalCashMovement> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? cashSessionId,
    Expression<String>? movementType,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? concept,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (cashSessionId != null) 'cash_session_id': cashSessionId,
      if (movementType != null) 'movement_type': movementType,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (concept != null) 'concept': concept,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String?>? cashSessionId,
    Value<CashMovementType>? movementType,
    Value<CashMovementCategory?>? category,
    Value<double>? amount,
    Value<String>? concept,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<String>? localId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalCashMovementsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      cashSessionId: cashSessionId ?? this.cashSessionId,
      movementType: movementType ?? this.movementType,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      concept: concept ?? this.concept,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (cashSessionId.present) {
      map['cash_session_id'] = Variable<String>(cashSessionId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(
        $LocalCashMovementsTable.$convertermovementType.toSql(
          movementType.value,
        ),
      );
    }
    if (category.present) {
      map['category'] = Variable<String>(
        $LocalCashMovementsTable.$convertercategoryn.toSql(category.value),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (concept.present) {
      map['concept'] = Variable<String>(concept.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashMovementsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashSessionId: $cashSessionId, ')
          ..write('movementType: $movementType, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('concept: $concept, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSalePaymentsTable extends LocalSalePayments
    with TableInfo<$LocalSalePaymentsTable, LocalSalePayment> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSalePaymentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
    'sale_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_sales (id)',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String>
  paymentMethod =
      GeneratedColumn<String>(
        'payment_method',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<PaymentMethod>(
        $LocalSalePaymentsTable.$converterpaymentMethod,
      );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _referenceMeta = const VerificationMeta(
    'reference',
  );
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
    'reference',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    saleId,
    paymentMethod,
    amount,
    reference,
    synced,
    syncedAt,
    localId,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_payments';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalSalePayment> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('sale_id')) {
      context.handle(
        _saleIdMeta,
        saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(
        _referenceMeta,
        reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta),
      );
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSalePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSalePayment(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      saleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sale_id'],
      )!,
      paymentMethod: $LocalSalePaymentsTable.$converterpaymentMethod.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}payment_method'],
        )!,
      ),
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}amount'],
      )!,
      reference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reference'],
      ),
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LocalSalePaymentsTable createAlias(String alias) {
    return $LocalSalePaymentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, String, String>
  $converterpaymentMethod = const EnumNameConverter<PaymentMethod>(
    PaymentMethod.values,
  );
}

class LocalSalePayment extends DataClass
    implements Insertable<LocalSalePayment> {
  final String id;
  final String saleId;
  final PaymentMethod paymentMethod;
  final double amount;
  final String? reference;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  const LocalSalePayment({
    required this.id,
    required this.saleId,
    required this.paymentMethod,
    required this.amount,
    this.reference,
    required this.synced,
    this.syncedAt,
    required this.localId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['sale_id'] = Variable<String>(saleId);
    {
      map['payment_method'] = Variable<String>(
        $LocalSalePaymentsTable.$converterpaymentMethod.toSql(paymentMethod),
      );
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalSalePaymentsCompanion toCompanion(bool nullToAbsent) {
    return LocalSalePaymentsCompanion(
      id: Value(id),
      saleId: Value(saleId),
      paymentMethod: Value(paymentMethod),
      amount: Value(amount),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
    );
  }

  factory LocalSalePayment.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSalePayment(
      id: serializer.fromJson<String>(json['id']),
      saleId: serializer.fromJson<String>(json['saleId']),
      paymentMethod: $LocalSalePaymentsTable.$converterpaymentMethod.fromJson(
        serializer.fromJson<String>(json['paymentMethod']),
      ),
      amount: serializer.fromJson<double>(json['amount']),
      reference: serializer.fromJson<String?>(json['reference']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'saleId': serializer.toJson<String>(saleId),
      'paymentMethod': serializer.toJson<String>(
        $LocalSalePaymentsTable.$converterpaymentMethod.toJson(paymentMethod),
      ),
      'amount': serializer.toJson<double>(amount),
      'reference': serializer.toJson<String?>(reference),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalSalePayment copyWith({
    String? id,
    String? saleId,
    PaymentMethod? paymentMethod,
    double? amount,
    Value<String?> reference = const Value.absent(),
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
    String? localId,
    DateTime? createdAt,
  }) => LocalSalePayment(
    id: id ?? this.id,
    saleId: saleId ?? this.saleId,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    amount: amount ?? this.amount,
    reference: reference.present ? reference.value : this.reference,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    localId: localId ?? this.localId,
    createdAt: createdAt ?? this.createdAt,
  );
  LocalSalePayment copyWithCompanion(LocalSalePaymentsCompanion data) {
    return LocalSalePayment(
      id: data.id.present ? data.id.value : this.id,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      amount: data.amount.present ? data.amount.value : this.amount,
      reference: data.reference.present ? data.reference.value : this.reference,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSalePayment(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    saleId,
    paymentMethod,
    amount,
    reference,
    synced,
    syncedAt,
    localId,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSalePayment &&
          other.id == this.id &&
          other.saleId == this.saleId &&
          other.paymentMethod == this.paymentMethod &&
          other.amount == this.amount &&
          other.reference == this.reference &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt);
}

class LocalSalePaymentsCompanion extends UpdateCompanion<LocalSalePayment> {
  final Value<String> id;
  final Value<String> saleId;
  final Value<PaymentMethod> paymentMethod;
  final Value<double> amount;
  final Value<String?> reference;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalSalePaymentsCompanion({
    this.id = const Value.absent(),
    this.saleId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.amount = const Value.absent(),
    this.reference = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSalePaymentsCompanion.insert({
    required String id,
    required String saleId,
    required PaymentMethod paymentMethod,
    required double amount,
    this.reference = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       saleId = Value(saleId),
       paymentMethod = Value(paymentMethod),
       amount = Value(amount),
       localId = Value(localId);
  static Insertable<LocalSalePayment> custom({
    Expression<String>? id,
    Expression<String>? saleId,
    Expression<String>? paymentMethod,
    Expression<double>? amount,
    Expression<String>? reference,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (saleId != null) 'sale_id': saleId,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (amount != null) 'amount': amount,
      if (reference != null) 'reference': reference,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSalePaymentsCompanion copyWith({
    Value<String>? id,
    Value<String>? saleId,
    Value<PaymentMethod>? paymentMethod,
    Value<double>? amount,
    Value<String?>? reference,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<String>? localId,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LocalSalePaymentsCompanion(
      id: id ?? this.id,
      saleId: saleId ?? this.saleId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(
        $LocalSalePaymentsTable.$converterpaymentMethod.toSql(
          paymentMethod.value,
        ),
      );
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSalePaymentsCompanion(')
          ..write('id: $id, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalInventoryMovementsTable extends LocalInventoryMovements
    with TableInfo<$LocalInventoryMovementsTable, LocalInventoryMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalInventoryMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _tenantIdMeta = const VerificationMeta(
    'tenantId',
  );
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
    'tenant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _branchIdMeta = const VerificationMeta(
    'branchId',
  );
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
    'branch_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _variantIdMeta = const VerificationMeta(
    'variantId',
  );
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
    'variant_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES local_product_variants (id)',
    ),
  );
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
    'lot_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MovementType, String>
  movementType =
      GeneratedColumn<String>(
        'movement_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MovementType>(
        $LocalInventoryMovementsTable.$convertermovementType,
      );
  static const VerificationMeta _quantityMeta = const VerificationMeta(
    'quantity',
  );
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
    'quantity',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
    'synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'synced_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _localIdMeta = const VerificationMeta(
    'localId',
  );
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
    'local_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _movementDateMeta = const VerificationMeta(
    'movementDate',
  );
  @override
  late final GeneratedColumn<DateTime> movementDate = GeneratedColumn<DateTime>(
    'movement_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tenantId,
    branchId,
    variantId,
    lotId,
    movementType,
    quantity,
    synced,
    syncedAt,
    localId,
    movementDate,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_inventory_movements';
  @override
  VerificationContext validateIntegrity(
    Insertable<LocalInventoryMovement> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(
        _tenantIdMeta,
        tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(
        _branchIdMeta,
        branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta),
      );
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(
        _variantIdMeta,
        variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta),
      );
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
        _lotIdMeta,
        lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta),
      );
    }
    if (data.containsKey('quantity')) {
      context.handle(
        _quantityMeta,
        quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta),
      );
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(
        _syncedMeta,
        synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta),
      );
    }
    if (data.containsKey('synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta),
      );
    }
    if (data.containsKey('local_id')) {
      context.handle(
        _localIdMeta,
        localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta),
      );
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('movement_date')) {
      context.handle(
        _movementDateMeta,
        movementDate.isAcceptableOrUnknown(
          data['movement_date']!,
          _movementDateMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalInventoryMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalInventoryMovement(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      tenantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tenant_id'],
      )!,
      branchId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}branch_id'],
      )!,
      variantId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}variant_id'],
      )!,
      lotId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lot_id'],
      ),
      movementType: $LocalInventoryMovementsTable.$convertermovementType
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}movement_type'],
            )!,
          ),
      quantity: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}quantity'],
      )!,
      synced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}synced'],
      )!,
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}synced_at'],
      ),
      localId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}local_id'],
      )!,
      movementDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}movement_date'],
      )!,
    );
  }

  @override
  $LocalInventoryMovementsTable createAlias(String alias) {
    return $LocalInventoryMovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementType, String, String>
  $convertermovementType = const EnumNameConverter<MovementType>(
    MovementType.values,
  );
}

class LocalInventoryMovement extends DataClass
    implements Insertable<LocalInventoryMovement> {
  final String id;
  final String tenantId;
  final String branchId;
  final String variantId;
  final String? lotId;
  final MovementType movementType;
  final int quantity;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime movementDate;
  const LocalInventoryMovement({
    required this.id,
    required this.tenantId,
    required this.branchId,
    required this.variantId,
    this.lotId,
    required this.movementType,
    required this.quantity,
    required this.synced,
    this.syncedAt,
    required this.localId,
    required this.movementDate,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['variant_id'] = Variable<String>(variantId);
    if (!nullToAbsent || lotId != null) {
      map['lot_id'] = Variable<String>(lotId);
    }
    {
      map['movement_type'] = Variable<String>(
        $LocalInventoryMovementsTable.$convertermovementType.toSql(
          movementType,
        ),
      );
    }
    map['quantity'] = Variable<int>(quantity);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['movement_date'] = Variable<DateTime>(movementDate);
    return map;
  }

  LocalInventoryMovementsCompanion toCompanion(bool nullToAbsent) {
    return LocalInventoryMovementsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      variantId: Value(variantId),
      lotId: lotId == null && nullToAbsent
          ? const Value.absent()
          : Value(lotId),
      movementType: Value(movementType),
      quantity: Value(quantity),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      movementDate: Value(movementDate),
    );
  }

  factory LocalInventoryMovement.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalInventoryMovement(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      lotId: serializer.fromJson<String?>(json['lotId']),
      movementType: $LocalInventoryMovementsTable.$convertermovementType
          .fromJson(serializer.fromJson<String>(json['movementType'])),
      quantity: serializer.fromJson<int>(json['quantity']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      movementDate: serializer.fromJson<DateTime>(json['movementDate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'variantId': serializer.toJson<String>(variantId),
      'lotId': serializer.toJson<String?>(lotId),
      'movementType': serializer.toJson<String>(
        $LocalInventoryMovementsTable.$convertermovementType.toJson(
          movementType,
        ),
      ),
      'quantity': serializer.toJson<int>(quantity),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'movementDate': serializer.toJson<DateTime>(movementDate),
    };
  }

  LocalInventoryMovement copyWith({
    String? id,
    String? tenantId,
    String? branchId,
    String? variantId,
    Value<String?> lotId = const Value.absent(),
    MovementType? movementType,
    int? quantity,
    bool? synced,
    Value<DateTime?> syncedAt = const Value.absent(),
    String? localId,
    DateTime? movementDate,
  }) => LocalInventoryMovement(
    id: id ?? this.id,
    tenantId: tenantId ?? this.tenantId,
    branchId: branchId ?? this.branchId,
    variantId: variantId ?? this.variantId,
    lotId: lotId.present ? lotId.value : this.lotId,
    movementType: movementType ?? this.movementType,
    quantity: quantity ?? this.quantity,
    synced: synced ?? this.synced,
    syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
    localId: localId ?? this.localId,
    movementDate: movementDate ?? this.movementDate,
  );
  LocalInventoryMovement copyWithCompanion(
    LocalInventoryMovementsCompanion data,
  ) {
    return LocalInventoryMovement(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      movementDate: data.movementDate.present
          ? data.movementDate.value
          : this.movementDate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryMovement(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('variantId: $variantId, ')
          ..write('lotId: $lotId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('movementDate: $movementDate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tenantId,
    branchId,
    variantId,
    lotId,
    movementType,
    quantity,
    synced,
    syncedAt,
    localId,
    movementDate,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalInventoryMovement &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.variantId == this.variantId &&
          other.lotId == this.lotId &&
          other.movementType == this.movementType &&
          other.quantity == this.quantity &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.movementDate == this.movementDate);
}

class LocalInventoryMovementsCompanion
    extends UpdateCompanion<LocalInventoryMovement> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> variantId;
  final Value<String?> lotId;
  final Value<MovementType> movementType;
  final Value<int> quantity;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> movementDate;
  final Value<int> rowid;
  const LocalInventoryMovementsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.lotId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.movementDate = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalInventoryMovementsCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String variantId,
    this.lotId = const Value.absent(),
    required MovementType movementType,
    required int quantity,
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.movementDate = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       tenantId = Value(tenantId),
       branchId = Value(branchId),
       variantId = Value(variantId),
       movementType = Value(movementType),
       quantity = Value(quantity),
       localId = Value(localId);
  static Insertable<LocalInventoryMovement> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? variantId,
    Expression<String>? lotId,
    Expression<String>? movementType,
    Expression<int>? quantity,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? movementDate,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (variantId != null) 'variant_id': variantId,
      if (lotId != null) 'lot_id': lotId,
      if (movementType != null) 'movement_type': movementType,
      if (quantity != null) 'quantity': quantity,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (movementDate != null) 'movement_date': movementDate,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalInventoryMovementsCompanion copyWith({
    Value<String>? id,
    Value<String>? tenantId,
    Value<String>? branchId,
    Value<String>? variantId,
    Value<String?>? lotId,
    Value<MovementType>? movementType,
    Value<int>? quantity,
    Value<bool>? synced,
    Value<DateTime?>? syncedAt,
    Value<String>? localId,
    Value<DateTime>? movementDate,
    Value<int>? rowid,
  }) {
    return LocalInventoryMovementsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      variantId: variantId ?? this.variantId,
      lotId: lotId ?? this.lotId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      movementDate: movementDate ?? this.movementDate,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>(
        $LocalInventoryMovementsTable.$convertermovementType.toSql(
          movementType.value,
        ),
      );
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (movementDate.present) {
      map['movement_date'] = Variable<DateTime>(movementDate.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryMovementsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('variantId: $variantId, ')
          ..write('lotId: $lotId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('movementDate: $movementDate, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SyncQueueTable extends SyncQueue
    with TableInfo<$SyncQueueTable, SyncQueueData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncQueueTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _operationMeta = const VerificationMeta(
    'operation',
  );
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
    'operation',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _retryCountMeta = const VerificationMeta(
    'retryCount',
  );
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
    'retry_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _lastAttemptMeta = const VerificationMeta(
    'lastAttempt',
  );
  @override
  late final GeneratedColumn<DateTime> lastAttempt = GeneratedColumn<DateTime>(
    'last_attempt',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lastErrorMeta = const VerificationMeta(
    'lastError',
  );
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
    'last_error',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entityType,
    entityId,
    operation,
    payload,
    retryCount,
    createdAt,
    lastAttempt,
    lastError,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(
    Insertable<SyncQueueData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(
        _operationMeta,
        operation.isAcceptableOrUnknown(data['operation']!, _operationMeta),
      );
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
        _retryCountMeta,
        retryCount.isAcceptableOrUnknown(data['retry_count']!, _retryCountMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('last_attempt')) {
      context.handle(
        _lastAttemptMeta,
        lastAttempt.isAcceptableOrUnknown(
          data['last_attempt']!,
          _lastAttemptMeta,
        ),
      );
    }
    if (data.containsKey('last_error')) {
      context.handle(
        _lastErrorMeta,
        lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      )!,
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      )!,
      operation: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}operation'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      retryCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}retry_count'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lastAttempt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_attempt'],
      ),
      lastError: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}last_error'],
      ),
    );
  }

  @override
  $SyncQueueTable createAlias(String alias) {
    return $SyncQueueTable(attachedDatabase, alias);
  }
}

class SyncQueueData extends DataClass implements Insertable<SyncQueueData> {
  final int id;
  final String entityType;
  final String entityId;
  final String operation;
  final String payload;
  final int retryCount;
  final DateTime createdAt;
  final DateTime? lastAttempt;
  final String? lastError;
  const SyncQueueData({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.operation,
    required this.payload,
    required this.retryCount,
    required this.createdAt,
    this.lastAttempt,
    this.lastError,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastAttempt != null) {
      map['last_attempt'] = Variable<DateTime>(lastAttempt);
    }
    if (!nullToAbsent || lastError != null) {
      map['last_error'] = Variable<String>(lastError);
    }
    return map;
  }

  SyncQueueCompanion toCompanion(bool nullToAbsent) {
    return SyncQueueCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      payload: Value(payload),
      retryCount: Value(retryCount),
      createdAt: Value(createdAt),
      lastAttempt: lastAttempt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttempt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastAttempt: serializer.fromJson<DateTime?>(json['lastAttempt']),
      lastError: serializer.fromJson<String?>(json['lastError']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'operation': serializer.toJson<String>(operation),
      'payload': serializer.toJson<String>(payload),
      'retryCount': serializer.toJson<int>(retryCount),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttempt': serializer.toJson<DateTime?>(lastAttempt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueData copyWith({
    int? id,
    String? entityType,
    String? entityId,
    String? operation,
    String? payload,
    int? retryCount,
    DateTime? createdAt,
    Value<DateTime?> lastAttempt = const Value.absent(),
    Value<String?> lastError = const Value.absent(),
  }) => SyncQueueData(
    id: id ?? this.id,
    entityType: entityType ?? this.entityType,
    entityId: entityId ?? this.entityId,
    operation: operation ?? this.operation,
    payload: payload ?? this.payload,
    retryCount: retryCount ?? this.retryCount,
    createdAt: createdAt ?? this.createdAt,
    lastAttempt: lastAttempt.present ? lastAttempt.value : this.lastAttempt,
    lastError: lastError.present ? lastError.value : this.lastError,
  );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount: data.retryCount.present
          ? data.retryCount.value
          : this.retryCount,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttempt: data.lastAttempt.present
          ? data.lastAttempt.value
          : this.lastAttempt,
      lastError: data.lastError.present ? data.lastError.value : this.lastError,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueData(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttempt: $lastAttempt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entityType,
    entityId,
    operation,
    payload,
    retryCount,
    createdAt,
    lastAttempt,
    lastError,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncQueueData &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.payload == this.payload &&
          other.retryCount == this.retryCount &&
          other.createdAt == this.createdAt &&
          other.lastAttempt == this.lastAttempt &&
          other.lastError == this.lastError);
}

class SyncQueueCompanion extends UpdateCompanion<SyncQueueData> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> payload;
  final Value<int> retryCount;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastAttempt;
  final Value<String?> lastError;
  const SyncQueueCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.payload = const Value.absent(),
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttempt = const Value.absent(),
    this.lastError = const Value.absent(),
  });
  SyncQueueCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String payload,
    this.retryCount = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttempt = const Value.absent(),
    this.lastError = const Value.absent(),
  }) : entityType = Value(entityType),
       entityId = Value(entityId),
       operation = Value(operation),
       payload = Value(payload);
  static Insertable<SyncQueueData> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? payload,
    Expression<int>? retryCount,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastAttempt,
    Expression<String>? lastError,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (payload != null) 'payload': payload,
      if (retryCount != null) 'retry_count': retryCount,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttempt != null) 'last_attempt': lastAttempt,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncQueueCompanion copyWith({
    Value<int>? id,
    Value<String>? entityType,
    Value<String>? entityId,
    Value<String>? operation,
    Value<String>? payload,
    Value<int>? retryCount,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lastAttempt,
    Value<String?>? lastError,
  }) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      createdAt: createdAt ?? this.createdAt,
      lastAttempt: lastAttempt ?? this.lastAttempt,
      lastError: lastError ?? this.lastError,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (operation.present) {
      map['operation'] = Variable<String>(operation.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (retryCount.present) {
      map['retry_count'] = Variable<int>(retryCount.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastAttempt.present) {
      map['last_attempt'] = Variable<DateTime>(lastAttempt.value);
    }
    if (lastError.present) {
      map['last_error'] = Variable<String>(lastError.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncQueueCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('payload: $payload, ')
          ..write('retryCount: $retryCount, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttempt: $lastAttempt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalSalesTable localSales = $LocalSalesTable(this);
  late final $LocalSaleItemsTable localSaleItems = $LocalSaleItemsTable(this);
  late final $LocalProductsTable localProducts = $LocalProductsTable(this);
  late final $LocalProductVariantsTable localProductVariants =
      $LocalProductVariantsTable(this);
  late final $LocalPriceListsTable localPriceLists = $LocalPriceListsTable(
    this,
  );
  late final $LocalPriceListItemsTable localPriceListItems =
      $LocalPriceListItemsTable(this);
  late final $LocalCustomersTable localCustomers = $LocalCustomersTable(this);
  late final $LocalCashRegistersTable localCashRegisters =
      $LocalCashRegistersTable(this);
  late final $LocalCashSessionsTable localCashSessions =
      $LocalCashSessionsTable(this);
  late final $LocalCashMovementsTable localCashMovements =
      $LocalCashMovementsTable(this);
  late final $LocalSalePaymentsTable localSalePayments =
      $LocalSalePaymentsTable(this);
  late final $LocalInventoryMovementsTable localInventoryMovements =
      $LocalInventoryMovementsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    localSales,
    localSaleItems,
    localProducts,
    localProductVariants,
    localPriceLists,
    localPriceListItems,
    localCustomers,
    localCashRegisters,
    localCashSessions,
    localCashMovements,
    localSalePayments,
    localInventoryMovements,
    syncQueue,
  ];
}

typedef $$LocalSalesTableCreateCompanionBuilder =
    LocalSalesCompanion Function({
      required String id,
      required String tenantId,
      required String branchId,
      Value<String?> saleNumber,
      Value<String?> customerId,
      Value<double> subtotal,
      Value<double> taxAmount,
      Value<double> discountAmount,
      Value<double> totalAmount,
      Value<SaleStatus> status,
      Value<SaleType> saleType,
      required String cashierId,
      Value<DateTime> saleDate,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      required String localId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LocalSalesTableUpdateCompanionBuilder =
    LocalSalesCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> branchId,
      Value<String?> saleNumber,
      Value<String?> customerId,
      Value<double> subtotal,
      Value<double> taxAmount,
      Value<double> discountAmount,
      Value<double> totalAmount,
      Value<SaleStatus> status,
      Value<SaleType> saleType,
      Value<String> cashierId,
      Value<DateTime> saleDate,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<String> localId,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$LocalSalesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSalesTable, LocalSale> {
  $$LocalSalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
  _localSaleItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localSaleItems,
    aliasName: $_aliasNameGenerator(db.localSales.id, db.localSaleItems.saleId),
  );

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager(
      $_db,
      $_db.localSaleItems,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalSalePaymentsTable, List<LocalSalePayment>>
  _localSalePaymentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localSalePayments,
        aliasName: $_aliasNameGenerator(
          db.localSales.id,
          db.localSalePayments.saleId,
        ),
      );

  $$LocalSalePaymentsTableProcessedTableManager get localSalePaymentsRefs {
    final manager = $$LocalSalePaymentsTableTableManager(
      $_db,
      $_db.localSalePayments,
    ).filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localSalePaymentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalSalesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get saleNumber => $composableBuilder(
    column: $table.saleNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SaleStatus, SaleStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<SaleType, SaleType, String> get saleType =>
      $composableBuilder(
        column: $table.saleType,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get cashierId => $composableBuilder(
    column: $table.cashierId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localSaleItemsRefs(
    Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f,
  ) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableFilterComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localSalePaymentsRefs(
    Expression<bool> Function($$LocalSalePaymentsTableFilterComposer f) f,
  ) {
    final $$LocalSalePaymentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSalePayments,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalePaymentsTableFilterComposer(
            $db: $db,
            $table: $db.localSalePayments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalSalesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleNumber => $composableBuilder(
    column: $table.saleNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get taxAmount => $composableBuilder(
    column: $table.taxAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get saleType => $composableBuilder(
    column: $table.saleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cashierId => $composableBuilder(
    column: $table.cashierId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get saleDate => $composableBuilder(
    column: $table.saleDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalSalesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSalesTable> {
  $$LocalSalesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get saleNumber => $composableBuilder(
    column: $table.saleNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerId => $composableBuilder(
    column: $table.customerId,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get discountAmount => $composableBuilder(
    column: $table.discountAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get totalAmount => $composableBuilder(
    column: $table.totalAmount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SaleStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SaleType, String> get saleType =>
      $composableBuilder(column: $table.saleType, builder: (column) => column);

  GeneratedColumn<String> get cashierId =>
      $composableBuilder(column: $table.cashierId, builder: (column) => column);

  GeneratedColumn<DateTime> get saleDate =>
      $composableBuilder(column: $table.saleDate, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> localSaleItemsRefs<T extends Object>(
    Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localSaleItems,
      getReferencedColumn: (t) => t.saleId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSaleItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.localSaleItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> localSalePaymentsRefs<T extends Object>(
    Expression<T> Function($$LocalSalePaymentsTableAnnotationComposer a) f,
  ) {
    final $$LocalSalePaymentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localSalePayments,
          getReferencedColumn: (t) => t.saleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalSalePaymentsTableAnnotationComposer(
                $db: $db,
                $table: $db.localSalePayments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalSalesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSalesTable,
          LocalSale,
          $$LocalSalesTableFilterComposer,
          $$LocalSalesTableOrderingComposer,
          $$LocalSalesTableAnnotationComposer,
          $$LocalSalesTableCreateCompanionBuilder,
          $$LocalSalesTableUpdateCompanionBuilder,
          (LocalSale, $$LocalSalesTableReferences),
          LocalSale,
          PrefetchHooks Function({
            bool localSaleItemsRefs,
            bool localSalePaymentsRefs,
          })
        > {
  $$LocalSalesTableTableManager(_$AppDatabase db, $LocalSalesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String?> saleNumber = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<SaleStatus> status = const Value.absent(),
                Value<SaleType> saleType = const Value.absent(),
                Value<String> cashierId = const Value.absent(),
                Value<DateTime> saleDate = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalesCompanion(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                saleNumber: saleNumber,
                customerId: customerId,
                subtotal: subtotal,
                taxAmount: taxAmount,
                discountAmount: discountAmount,
                totalAmount: totalAmount,
                status: status,
                saleType: saleType,
                cashierId: cashierId,
                saleDate: saleDate,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String branchId,
                Value<String?> saleNumber = const Value.absent(),
                Value<String?> customerId = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<double> taxAmount = const Value.absent(),
                Value<double> discountAmount = const Value.absent(),
                Value<double> totalAmount = const Value.absent(),
                Value<SaleStatus> status = const Value.absent(),
                Value<SaleType> saleType = const Value.absent(),
                required String cashierId,
                Value<DateTime> saleDate = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                required String localId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalesCompanion.insert(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                saleNumber: saleNumber,
                customerId: customerId,
                subtotal: subtotal,
                taxAmount: taxAmount,
                discountAmount: discountAmount,
                totalAmount: totalAmount,
                status: status,
                saleType: saleType,
                cashierId: cashierId,
                saleDate: saleDate,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSalesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({localSaleItemsRefs = false, localSalePaymentsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localSaleItemsRefs) db.localSaleItems,
                    if (localSalePaymentsRefs) db.localSalePayments,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localSaleItemsRefs)
                        await $_getPrefetchedData<
                          LocalSale,
                          $LocalSalesTable,
                          LocalSaleItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSalesTableReferences
                              ._localSaleItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSalesTableReferences(
                                db,
                                table,
                                p0,
                              ).localSaleItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localSalePaymentsRefs)
                        await $_getPrefetchedData<
                          LocalSale,
                          $LocalSalesTable,
                          LocalSalePayment
                        >(
                          currentTable: table,
                          referencedTable: $$LocalSalesTableReferences
                              ._localSalePaymentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalSalesTableReferences(
                                db,
                                table,
                                p0,
                              ).localSalePaymentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.saleId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalSalesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSalesTable,
      LocalSale,
      $$LocalSalesTableFilterComposer,
      $$LocalSalesTableOrderingComposer,
      $$LocalSalesTableAnnotationComposer,
      $$LocalSalesTableCreateCompanionBuilder,
      $$LocalSalesTableUpdateCompanionBuilder,
      (LocalSale, $$LocalSalesTableReferences),
      LocalSale,
      PrefetchHooks Function({
        bool localSaleItemsRefs,
        bool localSalePaymentsRefs,
      })
    >;
typedef $$LocalSaleItemsTableCreateCompanionBuilder =
    LocalSaleItemsCompanion Function({
      required String id,
      required String saleId,
      required String variantId,
      Value<String?> lotId,
      required int quantity,
      required double unitPrice,
      Value<double?> costPrice,
      Value<double> discountPercent,
      required double subtotal,
      Value<bool> synced,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalSaleItemsTableUpdateCompanionBuilder =
    LocalSaleItemsCompanion Function({
      Value<String> id,
      Value<String> saleId,
      Value<String> variantId,
      Value<String?> lotId,
      Value<int> quantity,
      Value<double> unitPrice,
      Value<double?> costPrice,
      Value<double> discountPercent,
      Value<double> subtotal,
      Value<bool> synced,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LocalSaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSaleItemsTable, LocalSaleItem> {
  $$LocalSaleItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalSalesTable _saleIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
        $_aliasNameGenerator(db.localSaleItems.saleId, db.localSales.id),
      );

  $$LocalSalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalSaleItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalSalesTableFilterComposer get saleId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get variantId => $composableBuilder(
    column: $table.variantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get unitPrice => $composableBuilder(
    column: $table.unitPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalSalesTableOrderingComposer get saleId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableOrderingComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSaleItemsTable> {
  $$LocalSaleItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
    column: $table.discountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalSalesTableAnnotationComposer get saleId {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSaleItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSaleItemsTable,
          LocalSaleItem,
          $$LocalSaleItemsTableFilterComposer,
          $$LocalSaleItemsTableOrderingComposer,
          $$LocalSaleItemsTableAnnotationComposer,
          $$LocalSaleItemsTableCreateCompanionBuilder,
          $$LocalSaleItemsTableUpdateCompanionBuilder,
          (LocalSaleItem, $$LocalSaleItemsTableReferences),
          LocalSaleItem,
          PrefetchHooks Function({bool saleId})
        > {
  $$LocalSaleItemsTableTableManager(
    _$AppDatabase db,
    $LocalSaleItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<String?> lotId = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<double> unitPrice = const Value.absent(),
                Value<double?> costPrice = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                Value<double> subtotal = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleItemsCompanion(
                id: id,
                saleId: saleId,
                variantId: variantId,
                lotId: lotId,
                quantity: quantity,
                unitPrice: unitPrice,
                costPrice: costPrice,
                discountPercent: discountPercent,
                subtotal: subtotal,
                synced: synced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String saleId,
                required String variantId,
                Value<String?> lotId = const Value.absent(),
                required int quantity,
                required double unitPrice,
                Value<double?> costPrice = const Value.absent(),
                Value<double> discountPercent = const Value.absent(),
                required double subtotal,
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSaleItemsCompanion.insert(
                id: id,
                saleId: saleId,
                variantId: variantId,
                lotId: lotId,
                quantity: quantity,
                unitPrice: unitPrice,
                costPrice: costPrice,
                discountPercent: discountPercent,
                subtotal: subtotal,
                synced: synced,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSaleItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable: $$LocalSaleItemsTableReferences
                                    ._saleIdTable(db),
                                referencedColumn:
                                    $$LocalSaleItemsTableReferences
                                        ._saleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalSaleItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSaleItemsTable,
      LocalSaleItem,
      $$LocalSaleItemsTableFilterComposer,
      $$LocalSaleItemsTableOrderingComposer,
      $$LocalSaleItemsTableAnnotationComposer,
      $$LocalSaleItemsTableCreateCompanionBuilder,
      $$LocalSaleItemsTableUpdateCompanionBuilder,
      (LocalSaleItem, $$LocalSaleItemsTableReferences),
      LocalSaleItem,
      PrefetchHooks Function({bool saleId})
    >;
typedef $$LocalProductsTableCreateCompanionBuilder =
    LocalProductsCompanion Function({
      required String id,
      required String tenantId,
      required String code,
      Value<String?> barcodeType,
      required String name,
      Value<String?> description,
      Value<String?> shortName,
      Value<String?> categoryId,
      Value<String?> brandId,
      Value<String?> unitId,
      Value<bool> hasExpiry,
      Value<bool> hasBatchControl,
      Value<bool> trackInventory,
      Value<bool> isSalable,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$LocalProductsTableUpdateCompanionBuilder =
    LocalProductsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> code,
      Value<String?> barcodeType,
      Value<String> name,
      Value<String?> description,
      Value<String?> shortName,
      Value<String?> categoryId,
      Value<String?> brandId,
      Value<String?> unitId,
      Value<bool> hasExpiry,
      Value<bool> hasBatchControl,
      Value<bool> trackInventory,
      Value<bool> isSalable,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });

final class $$LocalProductsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalProductsTable, LocalProduct> {
  $$LocalProductsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $LocalProductVariantsTable,
    List<LocalProductVariant>
  >
  _localProductVariantsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localProductVariants,
        aliasName: $_aliasNameGenerator(
          db.localProducts.id,
          db.localProductVariants.productId,
        ),
      );

  $$LocalProductVariantsTableProcessedTableManager
  get localProductVariantsRefs {
    final manager = $$LocalProductVariantsTableTableManager(
      $_db,
      $_db.localProductVariants,
    ).filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localProductVariantsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalProductsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcodeType => $composableBuilder(
    column: $table.barcodeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasExpiry => $composableBuilder(
    column: $table.hasExpiry,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get hasBatchControl => $composableBuilder(
    column: $table.hasBatchControl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get trackInventory => $composableBuilder(
    column: $table.trackInventory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSalable => $composableBuilder(
    column: $table.isSalable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localProductVariantsRefs(
    Expression<bool> Function($$LocalProductVariantsTableFilterComposer f) f,
  ) {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localProductVariants,
      getReferencedColumn: (t) => t.productId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductVariantsTableFilterComposer(
            $db: $db,
            $table: $db.localProductVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalProductsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcodeType => $composableBuilder(
    column: $table.barcodeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get shortName => $composableBuilder(
    column: $table.shortName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brandId => $composableBuilder(
    column: $table.brandId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unitId => $composableBuilder(
    column: $table.unitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasExpiry => $composableBuilder(
    column: $table.hasExpiry,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get hasBatchControl => $composableBuilder(
    column: $table.hasBatchControl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get trackInventory => $composableBuilder(
    column: $table.trackInventory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSalable => $composableBuilder(
    column: $table.isSalable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalProductsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProductsTable> {
  $$LocalProductsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get barcodeType => $composableBuilder(
    column: $table.barcodeType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get shortName =>
      $composableBuilder(column: $table.shortName, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
    column: $table.categoryId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get brandId =>
      $composableBuilder(column: $table.brandId, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<bool> get hasExpiry =>
      $composableBuilder(column: $table.hasExpiry, builder: (column) => column);

  GeneratedColumn<bool> get hasBatchControl => $composableBuilder(
    column: $table.hasBatchControl,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get trackInventory => $composableBuilder(
    column: $table.trackInventory,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSalable =>
      $composableBuilder(column: $table.isSalable, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  Expression<T> localProductVariantsRefs<T extends Object>(
    Expression<T> Function($$LocalProductVariantsTableAnnotationComposer a) f,
  ) {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localProductVariants,
          getReferencedColumn: (t) => t.productId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalProductVariantsTableAnnotationComposer(
                $db: $db,
                $table: $db.localProductVariants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalProductsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProductsTable,
          LocalProduct,
          $$LocalProductsTableFilterComposer,
          $$LocalProductsTableOrderingComposer,
          $$LocalProductsTableAnnotationComposer,
          $$LocalProductsTableCreateCompanionBuilder,
          $$LocalProductsTableUpdateCompanionBuilder,
          (LocalProduct, $$LocalProductsTableReferences),
          LocalProduct,
          PrefetchHooks Function({bool localProductVariantsRefs})
        > {
  $$LocalProductsTableTableManager(_$AppDatabase db, $LocalProductsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String?> barcodeType = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> shortName = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> brandId = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<bool> hasExpiry = const Value.absent(),
                Value<bool> hasBatchControl = const Value.absent(),
                Value<bool> trackInventory = const Value.absent(),
                Value<bool> isSalable = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProductsCompanion(
                id: id,
                tenantId: tenantId,
                code: code,
                barcodeType: barcodeType,
                name: name,
                description: description,
                shortName: shortName,
                categoryId: categoryId,
                brandId: brandId,
                unitId: unitId,
                hasExpiry: hasExpiry,
                hasBatchControl: hasBatchControl,
                trackInventory: trackInventory,
                isSalable: isSalable,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String code,
                Value<String?> barcodeType = const Value.absent(),
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> shortName = const Value.absent(),
                Value<String?> categoryId = const Value.absent(),
                Value<String?> brandId = const Value.absent(),
                Value<String?> unitId = const Value.absent(),
                Value<bool> hasExpiry = const Value.absent(),
                Value<bool> hasBatchControl = const Value.absent(),
                Value<bool> trackInventory = const Value.absent(),
                Value<bool> isSalable = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProductsCompanion.insert(
                id: id,
                tenantId: tenantId,
                code: code,
                barcodeType: barcodeType,
                name: name,
                description: description,
                shortName: shortName,
                categoryId: categoryId,
                brandId: brandId,
                unitId: unitId,
                hasExpiry: hasExpiry,
                hasBatchControl: hasBatchControl,
                trackInventory: trackInventory,
                isSalable: isSalable,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalProductsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({localProductVariantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localProductVariantsRefs) db.localProductVariants,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localProductVariantsRefs)
                    await $_getPrefetchedData<
                      LocalProduct,
                      $LocalProductsTable,
                      LocalProductVariant
                    >(
                      currentTable: table,
                      referencedTable: $$LocalProductsTableReferences
                          ._localProductVariantsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LocalProductsTableReferences(
                            db,
                            table,
                            p0,
                          ).localProductVariantsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.productId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LocalProductsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProductsTable,
      LocalProduct,
      $$LocalProductsTableFilterComposer,
      $$LocalProductsTableOrderingComposer,
      $$LocalProductsTableAnnotationComposer,
      $$LocalProductsTableCreateCompanionBuilder,
      $$LocalProductsTableUpdateCompanionBuilder,
      (LocalProduct, $$LocalProductsTableReferences),
      LocalProduct,
      PrefetchHooks Function({bool localProductVariantsRefs})
    >;
typedef $$LocalProductVariantsTableCreateCompanionBuilder =
    LocalProductVariantsCompanion Function({
      required String id,
      required String productId,
      required String sku,
      Value<String?> barcode,
      Value<String> attributes,
      Value<double> price,
      Value<double?> weightKg,
      Value<double?> volumeLiters,
      Value<bool> isDefault,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$LocalProductVariantsTableUpdateCompanionBuilder =
    LocalProductVariantsCompanion Function({
      Value<String> id,
      Value<String> productId,
      Value<String> sku,
      Value<String?> barcode,
      Value<String> attributes,
      Value<double> price,
      Value<double?> weightKg,
      Value<double?> volumeLiters,
      Value<bool> isDefault,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });

final class $$LocalProductVariantsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalProductVariantsTable,
          LocalProductVariant
        > {
  $$LocalProductVariantsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProductsTable _productIdTable(_$AppDatabase db) =>
      db.localProducts.createAlias(
        $_aliasNameGenerator(
          db.localProductVariants.productId,
          db.localProducts.id,
        ),
      );

  $$LocalProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$LocalProductsTableTableManager(
      $_db,
      $_db.localProducts,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $LocalPriceListItemsTable,
    List<LocalPriceListItem>
  >
  _localPriceListItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPriceListItems,
        aliasName: $_aliasNameGenerator(
          db.localProductVariants.id,
          db.localPriceListItems.variantId,
        ),
      );

  $$LocalPriceListItemsTableProcessedTableManager get localPriceListItemsRefs {
    final manager = $$LocalPriceListItemsTableTableManager(
      $_db,
      $_db.localPriceListItems,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPriceListItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $LocalInventoryMovementsTable,
    List<LocalInventoryMovement>
  >
  _localInventoryMovementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localInventoryMovements,
        aliasName: $_aliasNameGenerator(
          db.localProductVariants.id,
          db.localInventoryMovements.variantId,
        ),
      );

  $$LocalInventoryMovementsTableProcessedTableManager
  get localInventoryMovementsRefs {
    final manager = $$LocalInventoryMovementsTableTableManager(
      $_db,
      $_db.localInventoryMovements,
    ).filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localInventoryMovementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalProductVariantsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProductVariantsTable> {
  $$LocalProductVariantsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeLiters => $composableBuilder(
    column: $table.volumeLiters,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProductsTableFilterComposer get productId {
    final $$LocalProductsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductsTableFilterComposer(
            $db: $db,
            $table: $db.localProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localPriceListItemsRefs(
    Expression<bool> Function($$LocalPriceListItemsTableFilterComposer f) f,
  ) {
    final $$LocalPriceListItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPriceListItems,
      getReferencedColumn: (t) => t.variantId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPriceListItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localInventoryMovementsRefs(
    Expression<bool> Function($$LocalInventoryMovementsTableFilterComposer f) f,
  ) {
    final $$LocalInventoryMovementsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localInventoryMovements,
          getReferencedColumn: (t) => t.variantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalInventoryMovementsTableFilterComposer(
                $db: $db,
                $table: $db.localInventoryMovements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalProductVariantsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProductVariantsTable> {
  $$LocalProductVariantsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sku => $composableBuilder(
    column: $table.sku,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get barcode => $composableBuilder(
    column: $table.barcode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeLiters => $composableBuilder(
    column: $table.volumeLiters,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProductsTableOrderingComposer get productId {
    final $$LocalProductsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductsTableOrderingComposer(
            $db: $db,
            $table: $db.localProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalProductVariantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProductVariantsTable> {
  $$LocalProductVariantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get attributes => $composableBuilder(
    column: $table.attributes,
    builder: (column) => column,
  );

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get volumeLiters => $composableBuilder(
    column: $table.volumeLiters,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  $$LocalProductsTableAnnotationComposer get productId {
    final $$LocalProductsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productId,
      referencedTable: $db.localProducts,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductsTableAnnotationComposer(
            $db: $db,
            $table: $db.localProducts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> localPriceListItemsRefs<T extends Object>(
    Expression<T> Function($$LocalPriceListItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalPriceListItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPriceListItems,
          getReferencedColumn: (t) => t.variantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPriceListItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPriceListItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localInventoryMovementsRefs<T extends Object>(
    Expression<T> Function($$LocalInventoryMovementsTableAnnotationComposer a)
    f,
  ) {
    final $$LocalInventoryMovementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localInventoryMovements,
          getReferencedColumn: (t) => t.variantId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalInventoryMovementsTableAnnotationComposer(
                $db: $db,
                $table: $db.localInventoryMovements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalProductVariantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalProductVariantsTable,
          LocalProductVariant,
          $$LocalProductVariantsTableFilterComposer,
          $$LocalProductVariantsTableOrderingComposer,
          $$LocalProductVariantsTableAnnotationComposer,
          $$LocalProductVariantsTableCreateCompanionBuilder,
          $$LocalProductVariantsTableUpdateCompanionBuilder,
          (LocalProductVariant, $$LocalProductVariantsTableReferences),
          LocalProductVariant,
          PrefetchHooks Function({
            bool productId,
            bool localPriceListItemsRefs,
            bool localInventoryMovementsRefs,
          })
        > {
  $$LocalProductVariantsTableTableManager(
    _$AppDatabase db,
    $LocalProductVariantsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductVariantsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalProductVariantsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> sku = const Value.absent(),
                Value<String?> barcode = const Value.absent(),
                Value<String> attributes = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> volumeLiters = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProductVariantsCompanion(
                id: id,
                productId: productId,
                sku: sku,
                barcode: barcode,
                attributes: attributes,
                price: price,
                weightKg: weightKg,
                volumeLiters: volumeLiters,
                isDefault: isDefault,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String productId,
                required String sku,
                Value<String?> barcode = const Value.absent(),
                Value<String> attributes = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<double?> volumeLiters = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalProductVariantsCompanion.insert(
                id: id,
                productId: productId,
                sku: sku,
                barcode: barcode,
                attributes: attributes,
                price: price,
                weightKg: weightKg,
                volumeLiters: volumeLiters,
                isDefault: isDefault,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalProductVariantsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                productId = false,
                localPriceListItemsRefs = false,
                localInventoryMovementsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localPriceListItemsRefs) db.localPriceListItems,
                    if (localInventoryMovementsRefs) db.localInventoryMovements,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (productId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.productId,
                                    referencedTable:
                                        $$LocalProductVariantsTableReferences
                                            ._productIdTable(db),
                                    referencedColumn:
                                        $$LocalProductVariantsTableReferences
                                            ._productIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localPriceListItemsRefs)
                        await $_getPrefetchedData<
                          LocalProductVariant,
                          $LocalProductVariantsTable,
                          LocalPriceListItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProductVariantsTableReferences
                              ._localPriceListItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProductVariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).localPriceListItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.variantId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localInventoryMovementsRefs)
                        await $_getPrefetchedData<
                          LocalProductVariant,
                          $LocalProductVariantsTable,
                          LocalInventoryMovement
                        >(
                          currentTable: table,
                          referencedTable: $$LocalProductVariantsTableReferences
                              ._localInventoryMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalProductVariantsTableReferences(
                                db,
                                table,
                                p0,
                              ).localInventoryMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.variantId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalProductVariantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalProductVariantsTable,
      LocalProductVariant,
      $$LocalProductVariantsTableFilterComposer,
      $$LocalProductVariantsTableOrderingComposer,
      $$LocalProductVariantsTableAnnotationComposer,
      $$LocalProductVariantsTableCreateCompanionBuilder,
      $$LocalProductVariantsTableUpdateCompanionBuilder,
      (LocalProductVariant, $$LocalProductVariantsTableReferences),
      LocalProductVariant,
      PrefetchHooks Function({
        bool productId,
        bool localPriceListItemsRefs,
        bool localInventoryMovementsRefs,
      })
    >;
typedef $$LocalPriceListsTableCreateCompanionBuilder =
    LocalPriceListsCompanion Function({
      required String id,
      required String tenantId,
      required String name,
      Value<String?> description,
      Value<String?> customerType,
      Value<bool> isDefault,
      Value<bool> isActive,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$LocalPriceListsTableUpdateCompanionBuilder =
    LocalPriceListsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> name,
      Value<String?> description,
      Value<String?> customerType,
      Value<bool> isDefault,
      Value<bool> isActive,
      Value<DateTime?> validFrom,
      Value<DateTime?> validTo,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });

final class $$LocalPriceListsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LocalPriceListsTable, LocalPriceList> {
  $$LocalPriceListsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<
    $LocalPriceListItemsTable,
    List<LocalPriceListItem>
  >
  _localPriceListItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localPriceListItems,
        aliasName: $_aliasNameGenerator(
          db.localPriceLists.id,
          db.localPriceListItems.priceListId,
        ),
      );

  $$LocalPriceListItemsTableProcessedTableManager get localPriceListItemsRefs {
    final manager = $$LocalPriceListItemsTableTableManager(
      $_db,
      $_db.localPriceListItems,
    ).filter((f) => f.priceListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localPriceListItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LocalCustomersTable, List<LocalCustomer>>
  _localCustomersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.localCustomers,
    aliasName: $_aliasNameGenerator(
      db.localPriceLists.id,
      db.localCustomers.priceListId,
    ),
  );

  $$LocalCustomersTableProcessedTableManager get localCustomersRefs {
    final manager = $$LocalCustomersTableTableManager(
      $_db,
      $_db.localCustomers,
    ).filter((f) => f.priceListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localCustomersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalPriceListsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPriceListsTable> {
  $$LocalPriceListsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localPriceListItemsRefs(
    Expression<bool> Function($$LocalPriceListItemsTableFilterComposer f) f,
  ) {
    final $$LocalPriceListItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localPriceListItems,
      getReferencedColumn: (t) => t.priceListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListItemsTableFilterComposer(
            $db: $db,
            $table: $db.localPriceListItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> localCustomersRefs(
    Expression<bool> Function($$LocalCustomersTableFilterComposer f) f,
  ) {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.priceListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableFilterComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalPriceListsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPriceListsTable> {
  $$LocalPriceListsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isDefault => $composableBuilder(
    column: $table.isDefault,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
    column: $table.validFrom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
    column: $table.validTo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalPriceListsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPriceListsTable> {
  $$LocalPriceListsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get customerType => $composableBuilder(
    column: $table.customerType,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get validFrom =>
      $composableBuilder(column: $table.validFrom, builder: (column) => column);

  GeneratedColumn<DateTime> get validTo =>
      $composableBuilder(column: $table.validTo, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  Expression<T> localPriceListItemsRefs<T extends Object>(
    Expression<T> Function($$LocalPriceListItemsTableAnnotationComposer a) f,
  ) {
    final $$LocalPriceListItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localPriceListItems,
          getReferencedColumn: (t) => t.priceListId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalPriceListItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.localPriceListItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> localCustomersRefs<T extends Object>(
    Expression<T> Function($$LocalCustomersTableAnnotationComposer a) f,
  ) {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCustomers,
      getReferencedColumn: (t) => t.priceListId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCustomersTableAnnotationComposer(
            $db: $db,
            $table: $db.localCustomers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalPriceListsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPriceListsTable,
          LocalPriceList,
          $$LocalPriceListsTableFilterComposer,
          $$LocalPriceListsTableOrderingComposer,
          $$LocalPriceListsTableAnnotationComposer,
          $$LocalPriceListsTableCreateCompanionBuilder,
          $$LocalPriceListsTableUpdateCompanionBuilder,
          (LocalPriceList, $$LocalPriceListsTableReferences),
          LocalPriceList,
          PrefetchHooks Function({
            bool localPriceListItemsRefs,
            bool localCustomersRefs,
          })
        > {
  $$LocalPriceListsTableTableManager(
    _$AppDatabase db,
    $LocalPriceListsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPriceListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPriceListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPriceListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> customerType = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPriceListsCompanion(
                id: id,
                tenantId: tenantId,
                name: name,
                description: description,
                customerType: customerType,
                isDefault: isDefault,
                isActive: isActive,
                validFrom: validFrom,
                validTo: validTo,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> customerType = const Value.absent(),
                Value<bool> isDefault = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> validFrom = const Value.absent(),
                Value<DateTime?> validTo = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPriceListsCompanion.insert(
                id: id,
                tenantId: tenantId,
                name: name,
                description: description,
                customerType: customerType,
                isDefault: isDefault,
                isActive: isActive,
                validFrom: validFrom,
                validTo: validTo,
                lastSync: lastSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalPriceListsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({localPriceListItemsRefs = false, localCustomersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localPriceListItemsRefs) db.localPriceListItems,
                    if (localCustomersRefs) db.localCustomers,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localPriceListItemsRefs)
                        await $_getPrefetchedData<
                          LocalPriceList,
                          $LocalPriceListsTable,
                          LocalPriceListItem
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPriceListsTableReferences
                              ._localPriceListItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPriceListsTableReferences(
                                db,
                                table,
                                p0,
                              ).localPriceListItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.priceListId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (localCustomersRefs)
                        await $_getPrefetchedData<
                          LocalPriceList,
                          $LocalPriceListsTable,
                          LocalCustomer
                        >(
                          currentTable: table,
                          referencedTable: $$LocalPriceListsTableReferences
                              ._localCustomersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalPriceListsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCustomersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.priceListId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalPriceListsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPriceListsTable,
      LocalPriceList,
      $$LocalPriceListsTableFilterComposer,
      $$LocalPriceListsTableOrderingComposer,
      $$LocalPriceListsTableAnnotationComposer,
      $$LocalPriceListsTableCreateCompanionBuilder,
      $$LocalPriceListsTableUpdateCompanionBuilder,
      (LocalPriceList, $$LocalPriceListsTableReferences),
      LocalPriceList,
      PrefetchHooks Function({
        bool localPriceListItemsRefs,
        bool localCustomersRefs,
      })
    >;
typedef $$LocalPriceListItemsTableCreateCompanionBuilder =
    LocalPriceListItemsCompanion Function({
      required String id,
      required String tenantId,
      required String priceListId,
      required String variantId,
      required double price,
      Value<double?> costPrice,
      Value<int> minQuantity,
      Value<int?> maxQuantity,
      Value<double> volumeDiscountPercent,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });
typedef $$LocalPriceListItemsTableUpdateCompanionBuilder =
    LocalPriceListItemsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> priceListId,
      Value<String> variantId,
      Value<double> price,
      Value<double?> costPrice,
      Value<int> minQuantity,
      Value<int?> maxQuantity,
      Value<double> volumeDiscountPercent,
      Value<bool> isActive,
      Value<DateTime?> lastSync,
      Value<int> rowid,
    });

final class $$LocalPriceListItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalPriceListItemsTable,
          LocalPriceListItem
        > {
  $$LocalPriceListItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalPriceListsTable _priceListIdTable(_$AppDatabase db) =>
      db.localPriceLists.createAlias(
        $_aliasNameGenerator(
          db.localPriceListItems.priceListId,
          db.localPriceLists.id,
        ),
      );

  $$LocalPriceListsTableProcessedTableManager get priceListId {
    final $_column = $_itemColumn<String>('price_list_id')!;

    final manager = $$LocalPriceListsTableTableManager(
      $_db,
      $_db.localPriceLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_priceListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias(
        $_aliasNameGenerator(
          db.localPriceListItems.variantId,
          db.localProductVariants.id,
        ),
      );

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager = $$LocalProductVariantsTableTableManager(
      $_db,
      $_db.localProductVariants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalPriceListItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalPriceListItemsTable> {
  $$LocalPriceListItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxQuantity => $composableBuilder(
    column: $table.maxQuantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volumeDiscountPercent => $composableBuilder(
    column: $table.volumeDiscountPercent,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalPriceListsTableFilterComposer get priceListId {
    final $$LocalPriceListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableFilterComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.localProductVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductVariantsTableFilterComposer(
            $db: $db,
            $table: $db.localProductVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalPriceListItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalPriceListItemsTable> {
  $$LocalPriceListItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costPrice => $composableBuilder(
    column: $table.costPrice,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxQuantity => $composableBuilder(
    column: $table.maxQuantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volumeDiscountPercent => $composableBuilder(
    column: $table.volumeDiscountPercent,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
    column: $table.lastSync,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalPriceListsTableOrderingComposer get priceListId {
    final $$LocalPriceListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableOrderingComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.variantId,
          referencedTable: $db.localProductVariants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalProductVariantsTableOrderingComposer(
                $db: $db,
                $table: $db.localProductVariants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalPriceListItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalPriceListItemsTable> {
  $$LocalPriceListItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<int> get minQuantity => $composableBuilder(
    column: $table.minQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxQuantity => $composableBuilder(
    column: $table.maxQuantity,
    builder: (column) => column,
  );

  GeneratedColumn<double> get volumeDiscountPercent => $composableBuilder(
    column: $table.volumeDiscountPercent,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  $$LocalPriceListsTableAnnotationComposer get priceListId {
    final $$LocalPriceListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableAnnotationComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.variantId,
          referencedTable: $db.localProductVariants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalProductVariantsTableAnnotationComposer(
                $db: $db,
                $table: $db.localProductVariants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalPriceListItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalPriceListItemsTable,
          LocalPriceListItem,
          $$LocalPriceListItemsTableFilterComposer,
          $$LocalPriceListItemsTableOrderingComposer,
          $$LocalPriceListItemsTableAnnotationComposer,
          $$LocalPriceListItemsTableCreateCompanionBuilder,
          $$LocalPriceListItemsTableUpdateCompanionBuilder,
          (LocalPriceListItem, $$LocalPriceListItemsTableReferences),
          LocalPriceListItem,
          PrefetchHooks Function({bool priceListId, bool variantId})
        > {
  $$LocalPriceListItemsTableTableManager(
    _$AppDatabase db,
    $LocalPriceListItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPriceListItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPriceListItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalPriceListItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> priceListId = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<double?> costPrice = const Value.absent(),
                Value<int> minQuantity = const Value.absent(),
                Value<int?> maxQuantity = const Value.absent(),
                Value<double> volumeDiscountPercent = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPriceListItemsCompanion(
                id: id,
                tenantId: tenantId,
                priceListId: priceListId,
                variantId: variantId,
                price: price,
                costPrice: costPrice,
                minQuantity: minQuantity,
                maxQuantity: maxQuantity,
                volumeDiscountPercent: volumeDiscountPercent,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String priceListId,
                required String variantId,
                required double price,
                Value<double?> costPrice = const Value.absent(),
                Value<int> minQuantity = const Value.absent(),
                Value<int?> maxQuantity = const Value.absent(),
                Value<double> volumeDiscountPercent = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime?> lastSync = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalPriceListItemsCompanion.insert(
                id: id,
                tenantId: tenantId,
                priceListId: priceListId,
                variantId: variantId,
                price: price,
                costPrice: costPrice,
                minQuantity: minQuantity,
                maxQuantity: maxQuantity,
                volumeDiscountPercent: volumeDiscountPercent,
                isActive: isActive,
                lastSync: lastSync,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalPriceListItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({priceListId = false, variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (priceListId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.priceListId,
                                referencedTable:
                                    $$LocalPriceListItemsTableReferences
                                        ._priceListIdTable(db),
                                referencedColumn:
                                    $$LocalPriceListItemsTableReferences
                                        ._priceListIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (variantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.variantId,
                                referencedTable:
                                    $$LocalPriceListItemsTableReferences
                                        ._variantIdTable(db),
                                referencedColumn:
                                    $$LocalPriceListItemsTableReferences
                                        ._variantIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalPriceListItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalPriceListItemsTable,
      LocalPriceListItem,
      $$LocalPriceListItemsTableFilterComposer,
      $$LocalPriceListItemsTableOrderingComposer,
      $$LocalPriceListItemsTableAnnotationComposer,
      $$LocalPriceListItemsTableCreateCompanionBuilder,
      $$LocalPriceListItemsTableUpdateCompanionBuilder,
      (LocalPriceListItem, $$LocalPriceListItemsTableReferences),
      LocalPriceListItem,
      PrefetchHooks Function({bool priceListId, bool variantId})
    >;
typedef $$LocalCustomersTableCreateCompanionBuilder =
    LocalCustomersCompanion Function({
      required String id,
      required String tenantId,
      required String fullName,
      Value<String?> taxId,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> address,
      Value<String?> priceListId,
      Value<double> creditLimit,
      Value<double> availableCredit,
      Value<bool> synced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$LocalCustomersTableUpdateCompanionBuilder =
    LocalCustomersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> fullName,
      Value<String?> taxId,
      Value<String?> email,
      Value<String?> phoneNumber,
      Value<String?> address,
      Value<String?> priceListId,
      Value<double> creditLimit,
      Value<double> availableCredit,
      Value<bool> synced,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$LocalCustomersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalCustomersTable, LocalCustomer> {
  $$LocalCustomersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalPriceListsTable _priceListIdTable(_$AppDatabase db) =>
      db.localPriceLists.createAlias(
        $_aliasNameGenerator(
          db.localCustomers.priceListId,
          db.localPriceLists.id,
        ),
      );

  $$LocalPriceListsTableProcessedTableManager? get priceListId {
    final $_column = $_itemColumn<String>('price_list_id');
    if ($_column == null) return null;
    final manager = $$LocalPriceListsTableTableManager(
      $_db,
      $_db.localPriceLists,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_priceListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalCustomersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get availableCredit => $composableBuilder(
    column: $table.availableCredit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalPriceListsTableFilterComposer get priceListId {
    final $$LocalPriceListsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableFilterComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taxId => $composableBuilder(
    column: $table.taxId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get availableCredit => $composableBuilder(
    column: $table.availableCredit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalPriceListsTableOrderingComposer get priceListId {
    final $$LocalPriceListsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableOrderingComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCustomersTable> {
  $$LocalCustomersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
    column: $table.creditLimit,
    builder: (column) => column,
  );

  GeneratedColumn<double> get availableCredit => $composableBuilder(
    column: $table.availableCredit,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalPriceListsTableAnnotationComposer get priceListId {
    final $$LocalPriceListsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.priceListId,
      referencedTable: $db.localPriceLists,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalPriceListsTableAnnotationComposer(
            $db: $db,
            $table: $db.localPriceLists,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCustomersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCustomersTable,
          LocalCustomer,
          $$LocalCustomersTableFilterComposer,
          $$LocalCustomersTableOrderingComposer,
          $$LocalCustomersTableAnnotationComposer,
          $$LocalCustomersTableCreateCompanionBuilder,
          $$LocalCustomersTableUpdateCompanionBuilder,
          (LocalCustomer, $$LocalCustomersTableReferences),
          LocalCustomer,
          PrefetchHooks Function({bool priceListId})
        > {
  $$LocalCustomersTableTableManager(
    _$AppDatabase db,
    $LocalCustomersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> taxId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> priceListId = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<double> availableCredit = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomersCompanion(
                id: id,
                tenantId: tenantId,
                fullName: fullName,
                taxId: taxId,
                email: email,
                phoneNumber: phoneNumber,
                address: address,
                priceListId: priceListId,
                creditLimit: creditLimit,
                availableCredit: availableCredit,
                synced: synced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String fullName,
                Value<String?> taxId = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> address = const Value.absent(),
                Value<String?> priceListId = const Value.absent(),
                Value<double> creditLimit = const Value.absent(),
                Value<double> availableCredit = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCustomersCompanion.insert(
                id: id,
                tenantId: tenantId,
                fullName: fullName,
                taxId: taxId,
                email: email,
                phoneNumber: phoneNumber,
                address: address,
                priceListId: priceListId,
                creditLimit: creditLimit,
                availableCredit: availableCredit,
                synced: synced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCustomersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({priceListId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (priceListId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.priceListId,
                                referencedTable: $$LocalCustomersTableReferences
                                    ._priceListIdTable(db),
                                referencedColumn:
                                    $$LocalCustomersTableReferences
                                        ._priceListIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalCustomersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCustomersTable,
      LocalCustomer,
      $$LocalCustomersTableFilterComposer,
      $$LocalCustomersTableOrderingComposer,
      $$LocalCustomersTableAnnotationComposer,
      $$LocalCustomersTableCreateCompanionBuilder,
      $$LocalCustomersTableUpdateCompanionBuilder,
      (LocalCustomer, $$LocalCustomersTableReferences),
      LocalCustomer,
      PrefetchHooks Function({bool priceListId})
    >;
typedef $$LocalCashRegistersTableCreateCompanionBuilder =
    LocalCashRegistersCompanion Function({
      required String id,
      required String tenantId,
      required String branchId,
      required String code,
      required String name,
      Value<bool> isActive,
      Value<int> rowid,
    });
typedef $$LocalCashRegistersTableUpdateCompanionBuilder =
    LocalCashRegistersCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> branchId,
      Value<String> code,
      Value<String> name,
      Value<bool> isActive,
      Value<int> rowid,
    });

final class $$LocalCashRegistersTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCashRegistersTable,
          LocalCashRegister
        > {
  $$LocalCashRegistersTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LocalCashSessionsTable, List<LocalCashSession>>
  _localCashSessionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCashSessions,
        aliasName: $_aliasNameGenerator(
          db.localCashRegisters.id,
          db.localCashSessions.cashRegisterId,
        ),
      );

  $$LocalCashSessionsTableProcessedTableManager get localCashSessionsRefs {
    final manager = $$LocalCashSessionsTableTableManager(
      $_db,
      $_db.localCashSessions,
    ).filter((f) => f.cashRegisterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalCashRegistersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCashRegistersTable> {
  $$LocalCashRegistersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> localCashSessionsRefs(
    Expression<bool> Function($$LocalCashSessionsTableFilterComposer f) f,
  ) {
    final $$LocalCashSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCashSessions,
      getReferencedColumn: (t) => t.cashRegisterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashSessionsTableFilterComposer(
            $db: $db,
            $table: $db.localCashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalCashRegistersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCashRegistersTable> {
  $$LocalCashRegistersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LocalCashRegistersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCashRegistersTable> {
  $$LocalCashRegistersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  Expression<T> localCashSessionsRefs<T extends Object>(
    Expression<T> Function($$LocalCashSessionsTableAnnotationComposer a) f,
  ) {
    final $$LocalCashSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashSessions,
          getReferencedColumn: (t) => t.cashRegisterId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalCashRegistersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCashRegistersTable,
          LocalCashRegister,
          $$LocalCashRegistersTableFilterComposer,
          $$LocalCashRegistersTableOrderingComposer,
          $$LocalCashRegistersTableAnnotationComposer,
          $$LocalCashRegistersTableCreateCompanionBuilder,
          $$LocalCashRegistersTableUpdateCompanionBuilder,
          (LocalCashRegister, $$LocalCashRegistersTableReferences),
          LocalCashRegister,
          PrefetchHooks Function({bool localCashSessionsRefs})
        > {
  $$LocalCashRegistersTableTableManager(
    _$AppDatabase db,
    $LocalCashRegistersTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashRegistersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashRegistersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashRegistersTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> code = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashRegistersCompanion(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                code: code,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String branchId,
                required String code,
                required String name,
                Value<bool> isActive = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashRegistersCompanion.insert(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                code: code,
                name: name,
                isActive: isActive,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCashRegistersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({localCashSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localCashSessionsRefs) db.localCashSessions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localCashSessionsRefs)
                    await $_getPrefetchedData<
                      LocalCashRegister,
                      $LocalCashRegistersTable,
                      LocalCashSession
                    >(
                      currentTable: table,
                      referencedTable: $$LocalCashRegistersTableReferences
                          ._localCashSessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LocalCashRegistersTableReferences(
                            db,
                            table,
                            p0,
                          ).localCashSessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.cashRegisterId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LocalCashRegistersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCashRegistersTable,
      LocalCashRegister,
      $$LocalCashRegistersTableFilterComposer,
      $$LocalCashRegistersTableOrderingComposer,
      $$LocalCashRegistersTableAnnotationComposer,
      $$LocalCashRegistersTableCreateCompanionBuilder,
      $$LocalCashRegistersTableUpdateCompanionBuilder,
      (LocalCashRegister, $$LocalCashRegistersTableReferences),
      LocalCashRegister,
      PrefetchHooks Function({bool localCashSessionsRefs})
    >;
typedef $$LocalCashSessionsTableCreateCompanionBuilder =
    LocalCashSessionsCompanion Function({
      required String id,
      required String tenantId,
      required String cashRegisterId,
      required String userId,
      Value<double> initialAmount,
      Value<double> systemAmount,
      Value<double?> declaredAmount,
      Value<SessionStatus> status,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      required String localId,
      Value<DateTime> openingDate,
      Value<DateTime?> closingDate,
      Value<int> rowid,
    });
typedef $$LocalCashSessionsTableUpdateCompanionBuilder =
    LocalCashSessionsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> cashRegisterId,
      Value<String> userId,
      Value<double> initialAmount,
      Value<double> systemAmount,
      Value<double?> declaredAmount,
      Value<SessionStatus> status,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<String> localId,
      Value<DateTime> openingDate,
      Value<DateTime?> closingDate,
      Value<int> rowid,
    });

final class $$LocalCashSessionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCashSessionsTable,
          LocalCashSession
        > {
  $$LocalCashSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalCashRegistersTable _cashRegisterIdTable(_$AppDatabase db) =>
      db.localCashRegisters.createAlias(
        $_aliasNameGenerator(
          db.localCashSessions.cashRegisterId,
          db.localCashRegisters.id,
        ),
      );

  $$LocalCashRegistersTableProcessedTableManager get cashRegisterId {
    final $_column = $_itemColumn<String>('cash_register_id')!;

    final manager = $$LocalCashRegistersTableTableManager(
      $_db,
      $_db.localCashRegisters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashRegisterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$LocalCashMovementsTable, List<LocalCashMovement>>
  _localCashMovementsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.localCashMovements,
        aliasName: $_aliasNameGenerator(
          db.localCashSessions.id,
          db.localCashMovements.cashSessionId,
        ),
      );

  $$LocalCashMovementsTableProcessedTableManager get localCashMovementsRefs {
    final manager = $$LocalCashMovementsTableTableManager(
      $_db,
      $_db.localCashMovements,
    ).filter((f) => f.cashSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _localCashMovementsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LocalCashSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCashSessionsTable> {
  $$LocalCashSessionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get systemAmount => $composableBuilder(
    column: $table.systemAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get declaredAmount => $composableBuilder(
    column: $table.declaredAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<SessionStatus, SessionStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalCashRegistersTableFilterComposer get cashRegisterId {
    final $$LocalCashRegistersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashRegisterId,
      referencedTable: $db.localCashRegisters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashRegistersTableFilterComposer(
            $db: $db,
            $table: $db.localCashRegisters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> localCashMovementsRefs(
    Expression<bool> Function($$LocalCashMovementsTableFilterComposer f) f,
  ) {
    final $$LocalCashMovementsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.localCashMovements,
      getReferencedColumn: (t) => t.cashSessionId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashMovementsTableFilterComposer(
            $db: $db,
            $table: $db.localCashMovements,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LocalCashSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCashSessionsTable> {
  $$LocalCashSessionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get systemAmount => $composableBuilder(
    column: $table.systemAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get declaredAmount => $composableBuilder(
    column: $table.declaredAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalCashRegistersTableOrderingComposer get cashRegisterId {
    final $$LocalCashRegistersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashRegisterId,
      referencedTable: $db.localCashRegisters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashRegistersTableOrderingComposer(
            $db: $db,
            $table: $db.localCashRegisters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCashSessionsTable> {
  $$LocalCashSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<double> get initialAmount => $composableBuilder(
    column: $table.initialAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get systemAmount => $composableBuilder(
    column: $table.systemAmount,
    builder: (column) => column,
  );

  GeneratedColumn<double> get declaredAmount => $composableBuilder(
    column: $table.declaredAmount,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<SessionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get openingDate => $composableBuilder(
    column: $table.openingDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get closingDate => $composableBuilder(
    column: $table.closingDate,
    builder: (column) => column,
  );

  $$LocalCashRegistersTableAnnotationComposer get cashRegisterId {
    final $$LocalCashRegistersTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.cashRegisterId,
          referencedTable: $db.localCashRegisters,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashRegistersTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashRegisters,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  Expression<T> localCashMovementsRefs<T extends Object>(
    Expression<T> Function($$LocalCashMovementsTableAnnotationComposer a) f,
  ) {
    final $$LocalCashMovementsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.localCashMovements,
          getReferencedColumn: (t) => t.cashSessionId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashMovementsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashMovements,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$LocalCashSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCashSessionsTable,
          LocalCashSession,
          $$LocalCashSessionsTableFilterComposer,
          $$LocalCashSessionsTableOrderingComposer,
          $$LocalCashSessionsTableAnnotationComposer,
          $$LocalCashSessionsTableCreateCompanionBuilder,
          $$LocalCashSessionsTableUpdateCompanionBuilder,
          (LocalCashSession, $$LocalCashSessionsTableReferences),
          LocalCashSession,
          PrefetchHooks Function({
            bool cashRegisterId,
            bool localCashMovementsRefs,
          })
        > {
  $$LocalCashSessionsTableTableManager(
    _$AppDatabase db,
    $LocalCashSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashSessionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> cashRegisterId = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<double> initialAmount = const Value.absent(),
                Value<double> systemAmount = const Value.absent(),
                Value<double?> declaredAmount = const Value.absent(),
                Value<SessionStatus> status = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<DateTime> openingDate = const Value.absent(),
                Value<DateTime?> closingDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashSessionsCompanion(
                id: id,
                tenantId: tenantId,
                cashRegisterId: cashRegisterId,
                userId: userId,
                initialAmount: initialAmount,
                systemAmount: systemAmount,
                declaredAmount: declaredAmount,
                status: status,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                openingDate: openingDate,
                closingDate: closingDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String cashRegisterId,
                required String userId,
                Value<double> initialAmount = const Value.absent(),
                Value<double> systemAmount = const Value.absent(),
                Value<double?> declaredAmount = const Value.absent(),
                Value<SessionStatus> status = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                required String localId,
                Value<DateTime> openingDate = const Value.absent(),
                Value<DateTime?> closingDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashSessionsCompanion.insert(
                id: id,
                tenantId: tenantId,
                cashRegisterId: cashRegisterId,
                userId: userId,
                initialAmount: initialAmount,
                systemAmount: systemAmount,
                declaredAmount: declaredAmount,
                status: status,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                openingDate: openingDate,
                closingDate: closingDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCashSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({cashRegisterId = false, localCashMovementsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (localCashMovementsRefs) db.localCashMovements,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (cashRegisterId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.cashRegisterId,
                                    referencedTable:
                                        $$LocalCashSessionsTableReferences
                                            ._cashRegisterIdTable(db),
                                    referencedColumn:
                                        $$LocalCashSessionsTableReferences
                                            ._cashRegisterIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (localCashMovementsRefs)
                        await $_getPrefetchedData<
                          LocalCashSession,
                          $LocalCashSessionsTable,
                          LocalCashMovement
                        >(
                          currentTable: table,
                          referencedTable: $$LocalCashSessionsTableReferences
                              ._localCashMovementsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$LocalCashSessionsTableReferences(
                                db,
                                table,
                                p0,
                              ).localCashMovementsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.cashSessionId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$LocalCashSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCashSessionsTable,
      LocalCashSession,
      $$LocalCashSessionsTableFilterComposer,
      $$LocalCashSessionsTableOrderingComposer,
      $$LocalCashSessionsTableAnnotationComposer,
      $$LocalCashSessionsTableCreateCompanionBuilder,
      $$LocalCashSessionsTableUpdateCompanionBuilder,
      (LocalCashSession, $$LocalCashSessionsTableReferences),
      LocalCashSession,
      PrefetchHooks Function({bool cashRegisterId, bool localCashMovementsRefs})
    >;
typedef $$LocalCashMovementsTableCreateCompanionBuilder =
    LocalCashMovementsCompanion Function({
      required String id,
      required String tenantId,
      Value<String?> cashSessionId,
      required CashMovementType movementType,
      Value<CashMovementCategory?> category,
      required double amount,
      required String concept,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      required String localId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalCashMovementsTableUpdateCompanionBuilder =
    LocalCashMovementsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String?> cashSessionId,
      Value<CashMovementType> movementType,
      Value<CashMovementCategory?> category,
      Value<double> amount,
      Value<String> concept,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<String> localId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LocalCashMovementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalCashMovementsTable,
          LocalCashMovement
        > {
  $$LocalCashMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalCashSessionsTable _cashSessionIdTable(_$AppDatabase db) =>
      db.localCashSessions.createAlias(
        $_aliasNameGenerator(
          db.localCashMovements.cashSessionId,
          db.localCashSessions.id,
        ),
      );

  $$LocalCashSessionsTableProcessedTableManager? get cashSessionId {
    final $_column = $_itemColumn<String>('cash_session_id');
    if ($_column == null) return null;
    final manager = $$LocalCashSessionsTableTableManager(
      $_db,
      $_db.localCashSessions,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalCashMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalCashMovementsTable> {
  $$LocalCashMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CashMovementType, CashMovementType, String>
  get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<
    CashMovementCategory?,
    CashMovementCategory,
    String
  >
  get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalCashSessionsTableFilterComposer get cashSessionId {
    final $$LocalCashSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashSessionId,
      referencedTable: $db.localCashSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashSessionsTableFilterComposer(
            $db: $db,
            $table: $db.localCashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalCashMovementsTable> {
  $$LocalCashMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get concept => $composableBuilder(
    column: $table.concept,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalCashSessionsTableOrderingComposer get cashSessionId {
    final $$LocalCashSessionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cashSessionId,
      referencedTable: $db.localCashSessions,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalCashSessionsTableOrderingComposer(
            $db: $db,
            $table: $db.localCashSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalCashMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalCashMovementsTable> {
  $$LocalCashMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CashMovementType, String> get movementType =>
      $composableBuilder(
        column: $table.movementType,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<CashMovementCategory?, String>
  get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get concept =>
      $composableBuilder(column: $table.concept, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalCashSessionsTableAnnotationComposer get cashSessionId {
    final $$LocalCashSessionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.cashSessionId,
          referencedTable: $db.localCashSessions,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalCashSessionsTableAnnotationComposer(
                $db: $db,
                $table: $db.localCashSessions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalCashMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalCashMovementsTable,
          LocalCashMovement,
          $$LocalCashMovementsTableFilterComposer,
          $$LocalCashMovementsTableOrderingComposer,
          $$LocalCashMovementsTableAnnotationComposer,
          $$LocalCashMovementsTableCreateCompanionBuilder,
          $$LocalCashMovementsTableUpdateCompanionBuilder,
          (LocalCashMovement, $$LocalCashMovementsTableReferences),
          LocalCashMovement,
          PrefetchHooks Function({bool cashSessionId})
        > {
  $$LocalCashMovementsTableTableManager(
    _$AppDatabase db,
    $LocalCashMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashMovementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String?> cashSessionId = const Value.absent(),
                Value<CashMovementType> movementType = const Value.absent(),
                Value<CashMovementCategory?> category = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String> concept = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashMovementsCompanion(
                id: id,
                tenantId: tenantId,
                cashSessionId: cashSessionId,
                movementType: movementType,
                category: category,
                amount: amount,
                concept: concept,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                Value<String?> cashSessionId = const Value.absent(),
                required CashMovementType movementType,
                Value<CashMovementCategory?> category = const Value.absent(),
                required double amount,
                required String concept,
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                required String localId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalCashMovementsCompanion.insert(
                id: id,
                tenantId: tenantId,
                cashSessionId: cashSessionId,
                movementType: movementType,
                category: category,
                amount: amount,
                concept: concept,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalCashMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cashSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cashSessionId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.cashSessionId,
                                referencedTable:
                                    $$LocalCashMovementsTableReferences
                                        ._cashSessionIdTable(db),
                                referencedColumn:
                                    $$LocalCashMovementsTableReferences
                                        ._cashSessionIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalCashMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalCashMovementsTable,
      LocalCashMovement,
      $$LocalCashMovementsTableFilterComposer,
      $$LocalCashMovementsTableOrderingComposer,
      $$LocalCashMovementsTableAnnotationComposer,
      $$LocalCashMovementsTableCreateCompanionBuilder,
      $$LocalCashMovementsTableUpdateCompanionBuilder,
      (LocalCashMovement, $$LocalCashMovementsTableReferences),
      LocalCashMovement,
      PrefetchHooks Function({bool cashSessionId})
    >;
typedef $$LocalSalePaymentsTableCreateCompanionBuilder =
    LocalSalePaymentsCompanion Function({
      required String id,
      required String saleId,
      required PaymentMethod paymentMethod,
      required double amount,
      Value<String?> reference,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      required String localId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });
typedef $$LocalSalePaymentsTableUpdateCompanionBuilder =
    LocalSalePaymentsCompanion Function({
      Value<String> id,
      Value<String> saleId,
      Value<PaymentMethod> paymentMethod,
      Value<double> amount,
      Value<String?> reference,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<String> localId,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LocalSalePaymentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalSalePaymentsTable,
          LocalSalePayment
        > {
  $$LocalSalePaymentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalSalesTable _saleIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
        $_aliasNameGenerator(db.localSalePayments.saleId, db.localSales.id),
      );

  $$LocalSalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$LocalSalesTableTableManager(
      $_db,
      $_db.localSales,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalSalePaymentsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalSalePaymentsTable> {
  $$LocalSalePaymentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String>
  get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalSalesTableFilterComposer get saleId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableFilterComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSalePaymentsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalSalePaymentsTable> {
  $$LocalSalePaymentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reference => $composableBuilder(
    column: $table.reference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalSalesTableOrderingComposer get saleId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableOrderingComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSalePaymentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalSalePaymentsTable> {
  $$LocalSalePaymentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get paymentMethod =>
      $composableBuilder(
        column: $table.paymentMethod,
        builder: (column) => column,
      );

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalSalesTableAnnotationComposer get saleId {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.saleId,
      referencedTable: $db.localSales,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalSalesTableAnnotationComposer(
            $db: $db,
            $table: $db.localSales,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalSalePaymentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalSalePaymentsTable,
          LocalSalePayment,
          $$LocalSalePaymentsTableFilterComposer,
          $$LocalSalePaymentsTableOrderingComposer,
          $$LocalSalePaymentsTableAnnotationComposer,
          $$LocalSalePaymentsTableCreateCompanionBuilder,
          $$LocalSalePaymentsTableUpdateCompanionBuilder,
          (LocalSalePayment, $$LocalSalePaymentsTableReferences),
          LocalSalePayment,
          PrefetchHooks Function({bool saleId})
        > {
  $$LocalSalePaymentsTableTableManager(
    _$AppDatabase db,
    $LocalSalePaymentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalePaymentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> saleId = const Value.absent(),
                Value<PaymentMethod> paymentMethod = const Value.absent(),
                Value<double> amount = const Value.absent(),
                Value<String?> reference = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalePaymentsCompanion(
                id: id,
                saleId: saleId,
                paymentMethod: paymentMethod,
                amount: amount,
                reference: reference,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String saleId,
                required PaymentMethod paymentMethod,
                required double amount,
                Value<String?> reference = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                required String localId,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalSalePaymentsCompanion.insert(
                id: id,
                saleId: saleId,
                paymentMethod: paymentMethod,
                amount: amount,
                reference: reference,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalSalePaymentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (saleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.saleId,
                                referencedTable:
                                    $$LocalSalePaymentsTableReferences
                                        ._saleIdTable(db),
                                referencedColumn:
                                    $$LocalSalePaymentsTableReferences
                                        ._saleIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalSalePaymentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalSalePaymentsTable,
      LocalSalePayment,
      $$LocalSalePaymentsTableFilterComposer,
      $$LocalSalePaymentsTableOrderingComposer,
      $$LocalSalePaymentsTableAnnotationComposer,
      $$LocalSalePaymentsTableCreateCompanionBuilder,
      $$LocalSalePaymentsTableUpdateCompanionBuilder,
      (LocalSalePayment, $$LocalSalePaymentsTableReferences),
      LocalSalePayment,
      PrefetchHooks Function({bool saleId})
    >;
typedef $$LocalInventoryMovementsTableCreateCompanionBuilder =
    LocalInventoryMovementsCompanion Function({
      required String id,
      required String tenantId,
      required String branchId,
      required String variantId,
      Value<String?> lotId,
      required MovementType movementType,
      required int quantity,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      required String localId,
      Value<DateTime> movementDate,
      Value<int> rowid,
    });
typedef $$LocalInventoryMovementsTableUpdateCompanionBuilder =
    LocalInventoryMovementsCompanion Function({
      Value<String> id,
      Value<String> tenantId,
      Value<String> branchId,
      Value<String> variantId,
      Value<String?> lotId,
      Value<MovementType> movementType,
      Value<int> quantity,
      Value<bool> synced,
      Value<DateTime?> syncedAt,
      Value<String> localId,
      Value<DateTime> movementDate,
      Value<int> rowid,
    });

final class $$LocalInventoryMovementsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LocalInventoryMovementsTable,
          LocalInventoryMovement
        > {
  $$LocalInventoryMovementsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias(
        $_aliasNameGenerator(
          db.localInventoryMovements.variantId,
          db.localProductVariants.id,
        ),
      );

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager = $$LocalProductVariantsTableTableManager(
      $_db,
      $_db.localProductVariants,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LocalInventoryMovementsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalInventoryMovementsTable> {
  $$LocalInventoryMovementsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MovementType, MovementType, String>
  get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get movementDate => $composableBuilder(
    column: $table.movementDate,
    builder: (column) => ColumnFilters(column),
  );

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.variantId,
      referencedTable: $db.localProductVariants,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LocalProductVariantsTableFilterComposer(
            $db: $db,
            $table: $db.localProductVariants,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LocalInventoryMovementsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalInventoryMovementsTable> {
  $$LocalInventoryMovementsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tenantId => $composableBuilder(
    column: $table.tenantId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get branchId => $composableBuilder(
    column: $table.branchId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lotId => $composableBuilder(
    column: $table.lotId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get movementType => $composableBuilder(
    column: $table.movementType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get quantity => $composableBuilder(
    column: $table.quantity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get synced => $composableBuilder(
    column: $table.synced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get localId => $composableBuilder(
    column: $table.localId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get movementDate => $composableBuilder(
    column: $table.movementDate,
    builder: (column) => ColumnOrderings(column),
  );

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.variantId,
          referencedTable: $db.localProductVariants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalProductVariantsTableOrderingComposer(
                $db: $db,
                $table: $db.localProductVariants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalInventoryMovementsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalInventoryMovementsTable> {
  $$LocalInventoryMovementsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementType, String> get movementType =>
      $composableBuilder(
        column: $table.movementType,
        builder: (column) => column,
      );

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get movementDate => $composableBuilder(
    column: $table.movementDate,
    builder: (column) => column,
  );

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.variantId,
          referencedTable: $db.localProductVariants,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LocalProductVariantsTableAnnotationComposer(
                $db: $db,
                $table: $db.localProductVariants,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$LocalInventoryMovementsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LocalInventoryMovementsTable,
          LocalInventoryMovement,
          $$LocalInventoryMovementsTableFilterComposer,
          $$LocalInventoryMovementsTableOrderingComposer,
          $$LocalInventoryMovementsTableAnnotationComposer,
          $$LocalInventoryMovementsTableCreateCompanionBuilder,
          $$LocalInventoryMovementsTableUpdateCompanionBuilder,
          (LocalInventoryMovement, $$LocalInventoryMovementsTableReferences),
          LocalInventoryMovement,
          PrefetchHooks Function({bool variantId})
        > {
  $$LocalInventoryMovementsTableTableManager(
    _$AppDatabase db,
    $LocalInventoryMovementsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalInventoryMovementsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$LocalInventoryMovementsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$LocalInventoryMovementsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> tenantId = const Value.absent(),
                Value<String> branchId = const Value.absent(),
                Value<String> variantId = const Value.absent(),
                Value<String?> lotId = const Value.absent(),
                Value<MovementType> movementType = const Value.absent(),
                Value<int> quantity = const Value.absent(),
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                Value<String> localId = const Value.absent(),
                Value<DateTime> movementDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalInventoryMovementsCompanion(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                variantId: variantId,
                lotId: lotId,
                movementType: movementType,
                quantity: quantity,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                movementDate: movementDate,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String tenantId,
                required String branchId,
                required String variantId,
                Value<String?> lotId = const Value.absent(),
                required MovementType movementType,
                required int quantity,
                Value<bool> synced = const Value.absent(),
                Value<DateTime?> syncedAt = const Value.absent(),
                required String localId,
                Value<DateTime> movementDate = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LocalInventoryMovementsCompanion.insert(
                id: id,
                tenantId: tenantId,
                branchId: branchId,
                variantId: variantId,
                lotId: lotId,
                movementType: movementType,
                quantity: quantity,
                synced: synced,
                syncedAt: syncedAt,
                localId: localId,
                movementDate: movementDate,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$LocalInventoryMovementsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (variantId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.variantId,
                                referencedTable:
                                    $$LocalInventoryMovementsTableReferences
                                        ._variantIdTable(db),
                                referencedColumn:
                                    $$LocalInventoryMovementsTableReferences
                                        ._variantIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$LocalInventoryMovementsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LocalInventoryMovementsTable,
      LocalInventoryMovement,
      $$LocalInventoryMovementsTableFilterComposer,
      $$LocalInventoryMovementsTableOrderingComposer,
      $$LocalInventoryMovementsTableAnnotationComposer,
      $$LocalInventoryMovementsTableCreateCompanionBuilder,
      $$LocalInventoryMovementsTableUpdateCompanionBuilder,
      (LocalInventoryMovement, $$LocalInventoryMovementsTableReferences),
      LocalInventoryMovement,
      PrefetchHooks Function({bool variantId})
    >;
typedef $$SyncQueueTableCreateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      required String entityType,
      required String entityId,
      required String operation,
      required String payload,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttempt,
      Value<String?> lastError,
    });
typedef $$SyncQueueTableUpdateCompanionBuilder =
    SyncQueueCompanion Function({
      Value<int> id,
      Value<String> entityType,
      Value<String> entityId,
      Value<String> operation,
      Value<String> payload,
      Value<int> retryCount,
      Value<DateTime> createdAt,
      Value<DateTime?> lastAttempt,
      Value<String?> lastError,
    });

class $$SyncQueueTableFilterComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastAttempt => $composableBuilder(
    column: $table.lastAttempt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SyncQueueTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get operation => $composableBuilder(
    column: $table.operation,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastAttempt => $composableBuilder(
    column: $table.lastAttempt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lastError => $composableBuilder(
    column: $table.lastError,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SyncQueueTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncQueueTable> {
  $$SyncQueueTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
    column: $table.retryCount,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttempt => $composableBuilder(
    column: $table.lastAttempt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SyncQueueTable,
          SyncQueueData,
          $$SyncQueueTableFilterComposer,
          $$SyncQueueTableOrderingComposer,
          $$SyncQueueTableAnnotationComposer,
          $$SyncQueueTableCreateCompanionBuilder,
          $$SyncQueueTableUpdateCompanionBuilder,
          (
            SyncQueueData,
            BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
          ),
          SyncQueueData,
          PrefetchHooks Function()
        > {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> entityType = const Value.absent(),
                Value<String> entityId = const Value.absent(),
                Value<String> operation = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttempt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueCompanion(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttempt: lastAttempt,
                lastError: lastError,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String entityType,
                required String entityId,
                required String operation,
                required String payload,
                Value<int> retryCount = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lastAttempt = const Value.absent(),
                Value<String?> lastError = const Value.absent(),
              }) => SyncQueueCompanion.insert(
                id: id,
                entityType: entityType,
                entityId: entityId,
                operation: operation,
                payload: payload,
                retryCount: retryCount,
                createdAt: createdAt,
                lastAttempt: lastAttempt,
                lastError: lastError,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SyncQueueTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SyncQueueTable,
      SyncQueueData,
      $$SyncQueueTableFilterComposer,
      $$SyncQueueTableOrderingComposer,
      $$SyncQueueTableAnnotationComposer,
      $$SyncQueueTableCreateCompanionBuilder,
      $$SyncQueueTableUpdateCompanionBuilder,
      (
        SyncQueueData,
        BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>,
      ),
      SyncQueueData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalSalesTableTableManager get localSales =>
      $$LocalSalesTableTableManager(_db, _db.localSales);
  $$LocalSaleItemsTableTableManager get localSaleItems =>
      $$LocalSaleItemsTableTableManager(_db, _db.localSaleItems);
  $$LocalProductsTableTableManager get localProducts =>
      $$LocalProductsTableTableManager(_db, _db.localProducts);
  $$LocalProductVariantsTableTableManager get localProductVariants =>
      $$LocalProductVariantsTableTableManager(_db, _db.localProductVariants);
  $$LocalPriceListsTableTableManager get localPriceLists =>
      $$LocalPriceListsTableTableManager(_db, _db.localPriceLists);
  $$LocalPriceListItemsTableTableManager get localPriceListItems =>
      $$LocalPriceListItemsTableTableManager(_db, _db.localPriceListItems);
  $$LocalCustomersTableTableManager get localCustomers =>
      $$LocalCustomersTableTableManager(_db, _db.localCustomers);
  $$LocalCashRegistersTableTableManager get localCashRegisters =>
      $$LocalCashRegistersTableTableManager(_db, _db.localCashRegisters);
  $$LocalCashSessionsTableTableManager get localCashSessions =>
      $$LocalCashSessionsTableTableManager(_db, _db.localCashSessions);
  $$LocalCashMovementsTableTableManager get localCashMovements =>
      $$LocalCashMovementsTableTableManager(_db, _db.localCashMovements);
  $$LocalSalePaymentsTableTableManager get localSalePayments =>
      $$LocalSalePaymentsTableTableManager(_db, _db.localSalePayments);
  $$LocalInventoryMovementsTableTableManager get localInventoryMovements =>
      $$LocalInventoryMovementsTableTableManager(
        _db,
        _db.localInventoryMovements,
      );
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
}
