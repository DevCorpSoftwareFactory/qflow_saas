// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $LocalProductCategoriesTable extends LocalProductCategories
    with TableInfo<$LocalProductCategoriesTable, LocalProductCategory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalProductCategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _parentIdMeta =
      const VerificationMeta('parentId');
  @override
  late final GeneratedColumn<String> parentId = GeneratedColumn<String>(
      'parent_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _levelMeta = const VerificationMeta('level');
  @override
  late final GeneratedColumn<int> level = GeneratedColumn<int>(
      'level', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _displayOrderMeta =
      const VerificationMeta('displayOrder');
  @override
  late final GeneratedColumn<int> displayOrder = GeneratedColumn<int>(
      'display_order', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _imageUrlMeta =
      const VerificationMeta('imageUrl');
  @override
  late final GeneratedColumn<String> imageUrl = GeneratedColumn<String>(
      'image_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        name,
        description,
        code,
        parentId,
        level,
        displayOrder,
        imageUrl,
        isActive,
        lastSync,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_product_categories';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalProductCategory> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    }
    if (data.containsKey('parent_id')) {
      context.handle(_parentIdMeta,
          parentId.isAcceptableOrUnknown(data['parent_id']!, _parentIdMeta));
    }
    if (data.containsKey('level')) {
      context.handle(
          _levelMeta, level.isAcceptableOrUnknown(data['level']!, _levelMeta));
    }
    if (data.containsKey('display_order')) {
      context.handle(
          _displayOrderMeta,
          displayOrder.isAcceptableOrUnknown(
              data['display_order']!, _displayOrderMeta));
    }
    if (data.containsKey('image_url')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['image_url']!, _imageUrlMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProductCategory map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProductCategory(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code']),
      parentId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}parent_id']),
      level: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}level'])!,
      displayOrder: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}display_order'])!,
      imageUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_url']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalProductCategoriesTable createAlias(String alias) {
    return $LocalProductCategoriesTable(attachedDatabase, alias);
  }
}

class LocalProductCategory extends DataClass
    implements Insertable<LocalProductCategory> {
  final String id;
  final String tenantId;
  final String name;
  final String? description;
  final String? code;
  final String? parentId;
  final int level;
  final int displayOrder;
  final String? imageUrl;
  final bool isActive;
  final DateTime? lastSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalProductCategory(
      {required this.id,
      required this.tenantId,
      required this.name,
      this.description,
      this.code,
      this.parentId,
      required this.level,
      required this.displayOrder,
      this.imageUrl,
      required this.isActive,
      this.lastSync,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || code != null) {
      map['code'] = Variable<String>(code);
    }
    if (!nullToAbsent || parentId != null) {
      map['parent_id'] = Variable<String>(parentId);
    }
    map['level'] = Variable<int>(level);
    map['display_order'] = Variable<int>(displayOrder);
    if (!nullToAbsent || imageUrl != null) {
      map['image_url'] = Variable<String>(imageUrl);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalProductCategoriesCompanion toCompanion(bool nullToAbsent) {
    return LocalProductCategoriesCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      code: code == null && nullToAbsent ? const Value.absent() : Value(code),
      parentId: parentId == null && nullToAbsent
          ? const Value.absent()
          : Value(parentId),
      level: Value(level),
      displayOrder: Value(displayOrder),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalProductCategory.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProductCategory(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      code: serializer.fromJson<String?>(json['code']),
      parentId: serializer.fromJson<String?>(json['parentId']),
      level: serializer.fromJson<int>(json['level']),
      displayOrder: serializer.fromJson<int>(json['displayOrder']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'code': serializer.toJson<String?>(code),
      'parentId': serializer.toJson<String?>(parentId),
      'level': serializer.toJson<int>(level),
      'displayOrder': serializer.toJson<int>(displayOrder),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalProductCategory copyWith(
          {String? id,
          String? tenantId,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> code = const Value.absent(),
          Value<String?> parentId = const Value.absent(),
          int? level,
          int? displayOrder,
          Value<String?> imageUrl = const Value.absent(),
          bool? isActive,
          Value<DateTime?> lastSync = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalProductCategory(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        code: code.present ? code.value : this.code,
        parentId: parentId.present ? parentId.value : this.parentId,
        level: level ?? this.level,
        displayOrder: displayOrder ?? this.displayOrder,
        imageUrl: imageUrl.present ? imageUrl.value : this.imageUrl,
        isActive: isActive ?? this.isActive,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalProductCategory copyWithCompanion(LocalProductCategoriesCompanion data) {
    return LocalProductCategory(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      code: data.code.present ? data.code.value : this.code,
      parentId: data.parentId.present ? data.parentId.value : this.parentId,
      level: data.level.present ? data.level.value : this.level,
      displayOrder: data.displayOrder.present
          ? data.displayOrder.value
          : this.displayOrder,
      imageUrl: data.imageUrl.present ? data.imageUrl.value : this.imageUrl,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductCategory(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('code: $code, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      name,
      description,
      code,
      parentId,
      level,
      displayOrder,
      imageUrl,
      isActive,
      lastSync,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProductCategory &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.description == this.description &&
          other.code == this.code &&
          other.parentId == this.parentId &&
          other.level == this.level &&
          other.displayOrder == this.displayOrder &&
          other.imageUrl == this.imageUrl &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalProductCategoriesCompanion
    extends UpdateCompanion<LocalProductCategory> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> code;
  final Value<String?> parentId;
  final Value<int> level;
  final Value<int> displayOrder;
  final Value<String?> imageUrl;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalProductCategoriesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.code = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProductCategoriesCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.description = const Value.absent(),
    this.code = const Value.absent(),
    this.parentId = const Value.absent(),
    this.level = const Value.absent(),
    this.displayOrder = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name);
  static Insertable<LocalProductCategory> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? code,
    Expression<String>? parentId,
    Expression<int>? level,
    Expression<int>? displayOrder,
    Expression<String>? imageUrl,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (code != null) 'code': code,
      if (parentId != null) 'parent_id': parentId,
      if (level != null) 'level': level,
      if (displayOrder != null) 'display_order': displayOrder,
      if (imageUrl != null) 'image_url': imageUrl,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProductCategoriesCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? code,
      Value<String?>? parentId,
      Value<int>? level,
      Value<int>? displayOrder,
      Value<String?>? imageUrl,
      Value<bool>? isActive,
      Value<DateTime?>? lastSync,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalProductCategoriesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      description: description ?? this.description,
      code: code ?? this.code,
      parentId: parentId ?? this.parentId,
      level: level ?? this.level,
      displayOrder: displayOrder ?? this.displayOrder,
      imageUrl: imageUrl ?? this.imageUrl,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (parentId.present) {
      map['parent_id'] = Variable<String>(parentId.value);
    }
    if (level.present) {
      map['level'] = Variable<int>(level.value);
    }
    if (displayOrder.present) {
      map['display_order'] = Variable<int>(displayOrder.value);
    }
    if (imageUrl.present) {
      map['image_url'] = Variable<String>(imageUrl.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
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
    return (StringBuffer('LocalProductCategoriesCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('code: $code, ')
          ..write('parentId: $parentId, ')
          ..write('level: $level, ')
          ..write('displayOrder: $displayOrder, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalBrandsTable extends LocalBrands
    with TableInfo<$LocalBrandsTable, LocalBrand> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalBrandsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _logoUrlMeta =
      const VerificationMeta('logoUrl');
  @override
  late final GeneratedColumn<String> logoUrl = GeneratedColumn<String>(
      'logo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _websiteMeta =
      const VerificationMeta('website');
  @override
  late final GeneratedColumn<String> website = GeneratedColumn<String>(
      'website', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        name,
        description,
        logoUrl,
        website,
        isActive,
        lastSync,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_brands';
  @override
  VerificationContext validateIntegrity(Insertable<LocalBrand> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('logo_url')) {
      context.handle(_logoUrlMeta,
          logoUrl.isAcceptableOrUnknown(data['logo_url']!, _logoUrlMeta));
    }
    if (data.containsKey('website')) {
      context.handle(_websiteMeta,
          website.isAcceptableOrUnknown(data['website']!, _websiteMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalBrand map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalBrand(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      logoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}logo_url']),
      website: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}website']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalBrandsTable createAlias(String alias) {
    return $LocalBrandsTable(attachedDatabase, alias);
  }
}

class LocalBrand extends DataClass implements Insertable<LocalBrand> {
  final String id;
  final String tenantId;
  final String name;
  final String? description;
  final String? logoUrl;
  final String? website;
  final bool isActive;
  final DateTime? lastSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalBrand(
      {required this.id,
      required this.tenantId,
      required this.name,
      this.description,
      this.logoUrl,
      this.website,
      required this.isActive,
      this.lastSync,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || logoUrl != null) {
      map['logo_url'] = Variable<String>(logoUrl);
    }
    if (!nullToAbsent || website != null) {
      map['website'] = Variable<String>(website);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalBrandsCompanion toCompanion(bool nullToAbsent) {
    return LocalBrandsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      logoUrl: logoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(logoUrl),
      website: website == null && nullToAbsent
          ? const Value.absent()
          : Value(website),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalBrand.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalBrand(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      logoUrl: serializer.fromJson<String?>(json['logoUrl']),
      website: serializer.fromJson<String?>(json['website']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'logoUrl': serializer.toJson<String?>(logoUrl),
      'website': serializer.toJson<String?>(website),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalBrand copyWith(
          {String? id,
          String? tenantId,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> logoUrl = const Value.absent(),
          Value<String?> website = const Value.absent(),
          bool? isActive,
          Value<DateTime?> lastSync = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalBrand(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        logoUrl: logoUrl.present ? logoUrl.value : this.logoUrl,
        website: website.present ? website.value : this.website,
        isActive: isActive ?? this.isActive,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalBrand copyWithCompanion(LocalBrandsCompanion data) {
    return LocalBrand(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      logoUrl: data.logoUrl.present ? data.logoUrl.value : this.logoUrl,
      website: data.website.present ? data.website.value : this.website,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalBrand(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('website: $website, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, name, description, logoUrl,
      website, isActive, lastSync, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalBrand &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.description == this.description &&
          other.logoUrl == this.logoUrl &&
          other.website == this.website &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalBrandsCompanion extends UpdateCompanion<LocalBrand> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> logoUrl;
  final Value<String?> website;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalBrandsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.website = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalBrandsCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    this.description = const Value.absent(),
    this.logoUrl = const Value.absent(),
    this.website = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name);
  static Insertable<LocalBrand> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? logoUrl,
    Expression<String>? website,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (logoUrl != null) 'logo_url': logoUrl,
      if (website != null) 'website': website,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalBrandsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? logoUrl,
      Value<String?>? website,
      Value<bool>? isActive,
      Value<DateTime?>? lastSync,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalBrandsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      description: description ?? this.description,
      logoUrl: logoUrl ?? this.logoUrl,
      website: website ?? this.website,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (logoUrl.present) {
      map['logo_url'] = Variable<String>(logoUrl.value);
    }
    if (website.present) {
      map['website'] = Variable<String>(website.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
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
    return (StringBuffer('LocalBrandsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('logoUrl: $logoUrl, ')
          ..write('website: $website, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalUnitsOfMeasureTable extends LocalUnitsOfMeasure
    with TableInfo<$LocalUnitsOfMeasureTable, LocalUnitsOfMeasureData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalUnitsOfMeasureTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _abbreviationMeta =
      const VerificationMeta('abbreviation');
  @override
  late final GeneratedColumn<String> abbreviation = GeneratedColumn<String>(
      'abbreviation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _unitTypeMeta =
      const VerificationMeta('unitType');
  @override
  late final GeneratedColumn<String> unitType = GeneratedColumn<String>(
      'unit_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conversionFactorMeta =
      const VerificationMeta('conversionFactor');
  @override
  late final GeneratedColumn<double> conversionFactor = GeneratedColumn<double>(
      'conversion_factor', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _baseUnitIdMeta =
      const VerificationMeta('baseUnitId');
  @override
  late final GeneratedColumn<String> baseUnitId = GeneratedColumn<String>(
      'base_unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        name,
        abbreviation,
        unitType,
        conversionFactor,
        baseUnitId,
        isActive,
        lastSync,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_units_of_measure';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalUnitsOfMeasureData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('abbreviation')) {
      context.handle(
          _abbreviationMeta,
          abbreviation.isAcceptableOrUnknown(
              data['abbreviation']!, _abbreviationMeta));
    } else if (isInserting) {
      context.missing(_abbreviationMeta);
    }
    if (data.containsKey('unit_type')) {
      context.handle(_unitTypeMeta,
          unitType.isAcceptableOrUnknown(data['unit_type']!, _unitTypeMeta));
    } else if (isInserting) {
      context.missing(_unitTypeMeta);
    }
    if (data.containsKey('conversion_factor')) {
      context.handle(
          _conversionFactorMeta,
          conversionFactor.isAcceptableOrUnknown(
              data['conversion_factor']!, _conversionFactorMeta));
    }
    if (data.containsKey('base_unit_id')) {
      context.handle(
          _baseUnitIdMeta,
          baseUnitId.isAcceptableOrUnknown(
              data['base_unit_id']!, _baseUnitIdMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalUnitsOfMeasureData map(Map<String, dynamic> data,
      {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalUnitsOfMeasureData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      abbreviation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}abbreviation'])!,
      unitType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_type'])!,
      conversionFactor: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}conversion_factor']),
      baseUnitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}base_unit_id']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalUnitsOfMeasureTable createAlias(String alias) {
    return $LocalUnitsOfMeasureTable(attachedDatabase, alias);
  }
}

class LocalUnitsOfMeasureData extends DataClass
    implements Insertable<LocalUnitsOfMeasureData> {
  final String id;
  final String tenantId;
  final String name;
  final String abbreviation;
  final String unitType;
  final double? conversionFactor;
  final String? baseUnitId;
  final bool isActive;
  final DateTime? lastSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalUnitsOfMeasureData(
      {required this.id,
      required this.tenantId,
      required this.name,
      required this.abbreviation,
      required this.unitType,
      this.conversionFactor,
      this.baseUnitId,
      required this.isActive,
      this.lastSync,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['name'] = Variable<String>(name);
    map['abbreviation'] = Variable<String>(abbreviation);
    map['unit_type'] = Variable<String>(unitType);
    if (!nullToAbsent || conversionFactor != null) {
      map['conversion_factor'] = Variable<double>(conversionFactor);
    }
    if (!nullToAbsent || baseUnitId != null) {
      map['base_unit_id'] = Variable<String>(baseUnitId);
    }
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalUnitsOfMeasureCompanion toCompanion(bool nullToAbsent) {
    return LocalUnitsOfMeasureCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      name: Value(name),
      abbreviation: Value(abbreviation),
      unitType: Value(unitType),
      conversionFactor: conversionFactor == null && nullToAbsent
          ? const Value.absent()
          : Value(conversionFactor),
      baseUnitId: baseUnitId == null && nullToAbsent
          ? const Value.absent()
          : Value(baseUnitId),
      isActive: Value(isActive),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalUnitsOfMeasureData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalUnitsOfMeasureData(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      name: serializer.fromJson<String>(json['name']),
      abbreviation: serializer.fromJson<String>(json['abbreviation']),
      unitType: serializer.fromJson<String>(json['unitType']),
      conversionFactor: serializer.fromJson<double?>(json['conversionFactor']),
      baseUnitId: serializer.fromJson<String?>(json['baseUnitId']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
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
      'name': serializer.toJson<String>(name),
      'abbreviation': serializer.toJson<String>(abbreviation),
      'unitType': serializer.toJson<String>(unitType),
      'conversionFactor': serializer.toJson<double?>(conversionFactor),
      'baseUnitId': serializer.toJson<String?>(baseUnitId),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalUnitsOfMeasureData copyWith(
          {String? id,
          String? tenantId,
          String? name,
          String? abbreviation,
          String? unitType,
          Value<double?> conversionFactor = const Value.absent(),
          Value<String?> baseUnitId = const Value.absent(),
          bool? isActive,
          Value<DateTime?> lastSync = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalUnitsOfMeasureData(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        abbreviation: abbreviation ?? this.abbreviation,
        unitType: unitType ?? this.unitType,
        conversionFactor: conversionFactor.present
            ? conversionFactor.value
            : this.conversionFactor,
        baseUnitId: baseUnitId.present ? baseUnitId.value : this.baseUnitId,
        isActive: isActive ?? this.isActive,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalUnitsOfMeasureData copyWithCompanion(LocalUnitsOfMeasureCompanion data) {
    return LocalUnitsOfMeasureData(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      abbreviation: data.abbreviation.present
          ? data.abbreviation.value
          : this.abbreviation,
      unitType: data.unitType.present ? data.unitType.value : this.unitType,
      conversionFactor: data.conversionFactor.present
          ? data.conversionFactor.value
          : this.conversionFactor,
      baseUnitId:
          data.baseUnitId.present ? data.baseUnitId.value : this.baseUnitId,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalUnitsOfMeasureData(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('unitType: $unitType, ')
          ..write('conversionFactor: $conversionFactor, ')
          ..write('baseUnitId: $baseUnitId, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, name, abbreviation, unitType,
      conversionFactor, baseUnitId, isActive, lastSync, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalUnitsOfMeasureData &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.name == this.name &&
          other.abbreviation == this.abbreviation &&
          other.unitType == this.unitType &&
          other.conversionFactor == this.conversionFactor &&
          other.baseUnitId == this.baseUnitId &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalUnitsOfMeasureCompanion
    extends UpdateCompanion<LocalUnitsOfMeasureData> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> name;
  final Value<String> abbreviation;
  final Value<String> unitType;
  final Value<double?> conversionFactor;
  final Value<String?> baseUnitId;
  final Value<bool> isActive;
  final Value<DateTime?> lastSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalUnitsOfMeasureCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.name = const Value.absent(),
    this.abbreviation = const Value.absent(),
    this.unitType = const Value.absent(),
    this.conversionFactor = const Value.absent(),
    this.baseUnitId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalUnitsOfMeasureCompanion.insert({
    required String id,
    required String tenantId,
    required String name,
    required String abbreviation,
    required String unitType,
    this.conversionFactor = const Value.absent(),
    this.baseUnitId = const Value.absent(),
    this.isActive = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        name = Value(name),
        abbreviation = Value(abbreviation),
        unitType = Value(unitType);
  static Insertable<LocalUnitsOfMeasureData> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? name,
    Expression<String>? abbreviation,
    Expression<String>? unitType,
    Expression<double>? conversionFactor,
    Expression<String>? baseUnitId,
    Expression<bool>? isActive,
    Expression<DateTime>? lastSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (name != null) 'name': name,
      if (abbreviation != null) 'abbreviation': abbreviation,
      if (unitType != null) 'unit_type': unitType,
      if (conversionFactor != null) 'conversion_factor': conversionFactor,
      if (baseUnitId != null) 'base_unit_id': baseUnitId,
      if (isActive != null) 'is_active': isActive,
      if (lastSync != null) 'last_sync': lastSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalUnitsOfMeasureCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String>? abbreviation,
      Value<String>? unitType,
      Value<double?>? conversionFactor,
      Value<String?>? baseUnitId,
      Value<bool>? isActive,
      Value<DateTime?>? lastSync,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalUnitsOfMeasureCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      name: name ?? this.name,
      abbreviation: abbreviation ?? this.abbreviation,
      unitType: unitType ?? this.unitType,
      conversionFactor: conversionFactor ?? this.conversionFactor,
      baseUnitId: baseUnitId ?? this.baseUnitId,
      isActive: isActive ?? this.isActive,
      lastSync: lastSync ?? this.lastSync,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (abbreviation.present) {
      map['abbreviation'] = Variable<String>(abbreviation.value);
    }
    if (unitType.present) {
      map['unit_type'] = Variable<String>(unitType.value);
    }
    if (conversionFactor.present) {
      map['conversion_factor'] = Variable<double>(conversionFactor.value);
    }
    if (baseUnitId.present) {
      map['base_unit_id'] = Variable<String>(baseUnitId.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
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
    return (StringBuffer('LocalUnitsOfMeasureCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('name: $name, ')
          ..write('abbreviation: $abbreviation, ')
          ..write('unitType: $unitType, ')
          ..write('conversionFactor: $conversionFactor, ')
          ..write('baseUnitId: $baseUnitId, ')
          ..write('isActive: $isActive, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeTypeMeta =
      const VerificationMeta('barcodeType');
  @override
  late final GeneratedColumn<String> barcodeType = GeneratedColumn<String>(
      'barcode_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _shortNameMeta =
      const VerificationMeta('shortName');
  @override
  late final GeneratedColumn<String> shortName = GeneratedColumn<String>(
      'short_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<String> categoryId = GeneratedColumn<String>(
      'category_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _brandIdMeta =
      const VerificationMeta('brandId');
  @override
  late final GeneratedColumn<String> brandId = GeneratedColumn<String>(
      'brand_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitIdMeta = const VerificationMeta('unitId');
  @override
  late final GeneratedColumn<String> unitId = GeneratedColumn<String>(
      'unit_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hasExpiryMeta =
      const VerificationMeta('hasExpiry');
  @override
  late final GeneratedColumn<bool> hasExpiry = GeneratedColumn<bool>(
      'has_expiry', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("has_expiry" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _hasBatchControlMeta =
      const VerificationMeta('hasBatchControl');
  @override
  late final GeneratedColumn<bool> hasBatchControl = GeneratedColumn<bool>(
      'has_batch_control', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_batch_control" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _trackInventoryMeta =
      const VerificationMeta('trackInventory');
  @override
  late final GeneratedColumn<bool> trackInventory = GeneratedColumn<bool>(
      'track_inventory', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("track_inventory" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _minStockMeta =
      const VerificationMeta('minStock');
  @override
  late final GeneratedColumn<int> minStock = GeneratedColumn<int>(
      'min_stock', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _maxStockMeta =
      const VerificationMeta('maxStock');
  @override
  late final GeneratedColumn<int> maxStock = GeneratedColumn<int>(
      'max_stock', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _reorderPointMeta =
      const VerificationMeta('reorderPoint');
  @override
  late final GeneratedColumn<int> reorderPoint = GeneratedColumn<int>(
      'reorder_point', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isSalableMeta =
      const VerificationMeta('isSalable');
  @override
  late final GeneratedColumn<bool> isSalable = GeneratedColumn<bool>(
      'is_salable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_salable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isPurchasableMeta =
      const VerificationMeta('isPurchasable');
  @override
  late final GeneratedColumn<bool> isPurchasable = GeneratedColumn<bool>(
      'is_purchasable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_purchasable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _isReturnableMeta =
      const VerificationMeta('isReturnable');
  @override
  late final GeneratedColumn<bool> isReturnable = GeneratedColumn<bool>(
      'is_returnable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_returnable" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _requiresCoolingMeta =
      const VerificationMeta('requiresCooling');
  @override
  late final GeneratedColumn<bool> requiresCooling = GeneratedColumn<bool>(
      'requires_cooling', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("requires_cooling" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _storageTemperatureMinMeta =
      const VerificationMeta('storageTemperatureMin');
  @override
  late final GeneratedColumn<double> storageTemperatureMin =
      GeneratedColumn<double>('storage_temperature_min', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _storageTemperatureMaxMeta =
      const VerificationMeta('storageTemperatureMax');
  @override
  late final GeneratedColumn<double> storageTemperatureMax =
      GeneratedColumn<double>('storage_temperature_max', aliasedName, true,
          type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _nutritionalInfoMeta =
      const VerificationMeta('nutritionalInfo');
  @override
  late final GeneratedColumn<String> nutritionalInfo = GeneratedColumn<String>(
      'nutritional_info', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
        minStock,
        maxStock,
        reorderPoint,
        isActive,
        isSalable,
        isPurchasable,
        isReturnable,
        requiresCooling,
        storageTemperatureMin,
        storageTemperatureMax,
        nutritionalInfo,
        lastSync,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_products';
  @override
  VerificationContext validateIntegrity(Insertable<LocalProduct> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('barcode_type')) {
      context.handle(
          _barcodeTypeMeta,
          barcodeType.isAcceptableOrUnknown(
              data['barcode_type']!, _barcodeTypeMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('short_name')) {
      context.handle(_shortNameMeta,
          shortName.isAcceptableOrUnknown(data['short_name']!, _shortNameMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('brand_id')) {
      context.handle(_brandIdMeta,
          brandId.isAcceptableOrUnknown(data['brand_id']!, _brandIdMeta));
    }
    if (data.containsKey('unit_id')) {
      context.handle(_unitIdMeta,
          unitId.isAcceptableOrUnknown(data['unit_id']!, _unitIdMeta));
    }
    if (data.containsKey('has_expiry')) {
      context.handle(_hasExpiryMeta,
          hasExpiry.isAcceptableOrUnknown(data['has_expiry']!, _hasExpiryMeta));
    }
    if (data.containsKey('has_batch_control')) {
      context.handle(
          _hasBatchControlMeta,
          hasBatchControl.isAcceptableOrUnknown(
              data['has_batch_control']!, _hasBatchControlMeta));
    }
    if (data.containsKey('track_inventory')) {
      context.handle(
          _trackInventoryMeta,
          trackInventory.isAcceptableOrUnknown(
              data['track_inventory']!, _trackInventoryMeta));
    }
    if (data.containsKey('min_stock')) {
      context.handle(_minStockMeta,
          minStock.isAcceptableOrUnknown(data['min_stock']!, _minStockMeta));
    }
    if (data.containsKey('max_stock')) {
      context.handle(_maxStockMeta,
          maxStock.isAcceptableOrUnknown(data['max_stock']!, _maxStockMeta));
    }
    if (data.containsKey('reorder_point')) {
      context.handle(
          _reorderPointMeta,
          reorderPoint.isAcceptableOrUnknown(
              data['reorder_point']!, _reorderPointMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('is_salable')) {
      context.handle(_isSalableMeta,
          isSalable.isAcceptableOrUnknown(data['is_salable']!, _isSalableMeta));
    }
    if (data.containsKey('is_purchasable')) {
      context.handle(
          _isPurchasableMeta,
          isPurchasable.isAcceptableOrUnknown(
              data['is_purchasable']!, _isPurchasableMeta));
    }
    if (data.containsKey('is_returnable')) {
      context.handle(
          _isReturnableMeta,
          isReturnable.isAcceptableOrUnknown(
              data['is_returnable']!, _isReturnableMeta));
    }
    if (data.containsKey('requires_cooling')) {
      context.handle(
          _requiresCoolingMeta,
          requiresCooling.isAcceptableOrUnknown(
              data['requires_cooling']!, _requiresCoolingMeta));
    }
    if (data.containsKey('storage_temperature_min')) {
      context.handle(
          _storageTemperatureMinMeta,
          storageTemperatureMin.isAcceptableOrUnknown(
              data['storage_temperature_min']!, _storageTemperatureMinMeta));
    }
    if (data.containsKey('storage_temperature_max')) {
      context.handle(
          _storageTemperatureMaxMeta,
          storageTemperatureMax.isAcceptableOrUnknown(
              data['storage_temperature_max']!, _storageTemperatureMaxMeta));
    }
    if (data.containsKey('nutritional_info')) {
      context.handle(
          _nutritionalInfoMeta,
          nutritionalInfo.isAcceptableOrUnknown(
              data['nutritional_info']!, _nutritionalInfoMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProduct map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProduct(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      barcodeType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode_type']),
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      shortName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}short_name']),
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category_id']),
      brandId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}brand_id']),
      unitId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit_id']),
      hasExpiry: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}has_expiry'])!,
      hasBatchControl: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_batch_control'])!,
      trackInventory: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}track_inventory'])!,
      minStock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_stock'])!,
      maxStock: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_stock']),
      reorderPoint: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reorder_point']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      isSalable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_salable'])!,
      isPurchasable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_purchasable'])!,
      isReturnable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_returnable'])!,
      requiresCooling: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}requires_cooling'])!,
      storageTemperatureMin: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}storage_temperature_min']),
      storageTemperatureMax: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}storage_temperature_max']),
      nutritionalInfo: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}nutritional_info']),
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final int minStock;
  final int? maxStock;
  final int? reorderPoint;
  final bool isActive;
  final bool isSalable;
  final bool isPurchasable;
  final bool isReturnable;
  final bool requiresCooling;
  final double? storageTemperatureMin;
  final double? storageTemperatureMax;
  final String? nutritionalInfo;
  final DateTime? lastSync;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalProduct(
      {required this.id,
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
      required this.minStock,
      this.maxStock,
      this.reorderPoint,
      required this.isActive,
      required this.isSalable,
      required this.isPurchasable,
      required this.isReturnable,
      required this.requiresCooling,
      this.storageTemperatureMin,
      this.storageTemperatureMax,
      this.nutritionalInfo,
      this.lastSync,
      required this.createdAt,
      required this.updatedAt});
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
    map['min_stock'] = Variable<int>(minStock);
    if (!nullToAbsent || maxStock != null) {
      map['max_stock'] = Variable<int>(maxStock);
    }
    if (!nullToAbsent || reorderPoint != null) {
      map['reorder_point'] = Variable<int>(reorderPoint);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['is_salable'] = Variable<bool>(isSalable);
    map['is_purchasable'] = Variable<bool>(isPurchasable);
    map['is_returnable'] = Variable<bool>(isReturnable);
    map['requires_cooling'] = Variable<bool>(requiresCooling);
    if (!nullToAbsent || storageTemperatureMin != null) {
      map['storage_temperature_min'] = Variable<double>(storageTemperatureMin);
    }
    if (!nullToAbsent || storageTemperatureMax != null) {
      map['storage_temperature_max'] = Variable<double>(storageTemperatureMax);
    }
    if (!nullToAbsent || nutritionalInfo != null) {
      map['nutritional_info'] = Variable<String>(nutritionalInfo);
    }
    if (!nullToAbsent || lastSync != null) {
      map['last_sync'] = Variable<DateTime>(lastSync);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
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
      unitId:
          unitId == null && nullToAbsent ? const Value.absent() : Value(unitId),
      hasExpiry: Value(hasExpiry),
      hasBatchControl: Value(hasBatchControl),
      trackInventory: Value(trackInventory),
      minStock: Value(minStock),
      maxStock: maxStock == null && nullToAbsent
          ? const Value.absent()
          : Value(maxStock),
      reorderPoint: reorderPoint == null && nullToAbsent
          ? const Value.absent()
          : Value(reorderPoint),
      isActive: Value(isActive),
      isSalable: Value(isSalable),
      isPurchasable: Value(isPurchasable),
      isReturnable: Value(isReturnable),
      requiresCooling: Value(requiresCooling),
      storageTemperatureMin: storageTemperatureMin == null && nullToAbsent
          ? const Value.absent()
          : Value(storageTemperatureMin),
      storageTemperatureMax: storageTemperatureMax == null && nullToAbsent
          ? const Value.absent()
          : Value(storageTemperatureMax),
      nutritionalInfo: nutritionalInfo == null && nullToAbsent
          ? const Value.absent()
          : Value(nutritionalInfo),
      lastSync: lastSync == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSync),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalProduct.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
      minStock: serializer.fromJson<int>(json['minStock']),
      maxStock: serializer.fromJson<int?>(json['maxStock']),
      reorderPoint: serializer.fromJson<int?>(json['reorderPoint']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      isSalable: serializer.fromJson<bool>(json['isSalable']),
      isPurchasable: serializer.fromJson<bool>(json['isPurchasable']),
      isReturnable: serializer.fromJson<bool>(json['isReturnable']),
      requiresCooling: serializer.fromJson<bool>(json['requiresCooling']),
      storageTemperatureMin:
          serializer.fromJson<double?>(json['storageTemperatureMin']),
      storageTemperatureMax:
          serializer.fromJson<double?>(json['storageTemperatureMax']),
      nutritionalInfo: serializer.fromJson<String?>(json['nutritionalInfo']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
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
      'minStock': serializer.toJson<int>(minStock),
      'maxStock': serializer.toJson<int?>(maxStock),
      'reorderPoint': serializer.toJson<int?>(reorderPoint),
      'isActive': serializer.toJson<bool>(isActive),
      'isSalable': serializer.toJson<bool>(isSalable),
      'isPurchasable': serializer.toJson<bool>(isPurchasable),
      'isReturnable': serializer.toJson<bool>(isReturnable),
      'requiresCooling': serializer.toJson<bool>(requiresCooling),
      'storageTemperatureMin':
          serializer.toJson<double?>(storageTemperatureMin),
      'storageTemperatureMax':
          serializer.toJson<double?>(storageTemperatureMax),
      'nutritionalInfo': serializer.toJson<String?>(nutritionalInfo),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalProduct copyWith(
          {String? id,
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
          int? minStock,
          Value<int?> maxStock = const Value.absent(),
          Value<int?> reorderPoint = const Value.absent(),
          bool? isActive,
          bool? isSalable,
          bool? isPurchasable,
          bool? isReturnable,
          bool? requiresCooling,
          Value<double?> storageTemperatureMin = const Value.absent(),
          Value<double?> storageTemperatureMax = const Value.absent(),
          Value<String?> nutritionalInfo = const Value.absent(),
          Value<DateTime?> lastSync = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalProduct(
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
        minStock: minStock ?? this.minStock,
        maxStock: maxStock.present ? maxStock.value : this.maxStock,
        reorderPoint:
            reorderPoint.present ? reorderPoint.value : this.reorderPoint,
        isActive: isActive ?? this.isActive,
        isSalable: isSalable ?? this.isSalable,
        isPurchasable: isPurchasable ?? this.isPurchasable,
        isReturnable: isReturnable ?? this.isReturnable,
        requiresCooling: requiresCooling ?? this.requiresCooling,
        storageTemperatureMin: storageTemperatureMin.present
            ? storageTemperatureMin.value
            : this.storageTemperatureMin,
        storageTemperatureMax: storageTemperatureMax.present
            ? storageTemperatureMax.value
            : this.storageTemperatureMax,
        nutritionalInfo: nutritionalInfo.present
            ? nutritionalInfo.value
            : this.nutritionalInfo,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalProduct copyWithCompanion(LocalProductsCompanion data) {
    return LocalProduct(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      code: data.code.present ? data.code.value : this.code,
      barcodeType:
          data.barcodeType.present ? data.barcodeType.value : this.barcodeType,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      shortName: data.shortName.present ? data.shortName.value : this.shortName,
      categoryId:
          data.categoryId.present ? data.categoryId.value : this.categoryId,
      brandId: data.brandId.present ? data.brandId.value : this.brandId,
      unitId: data.unitId.present ? data.unitId.value : this.unitId,
      hasExpiry: data.hasExpiry.present ? data.hasExpiry.value : this.hasExpiry,
      hasBatchControl: data.hasBatchControl.present
          ? data.hasBatchControl.value
          : this.hasBatchControl,
      trackInventory: data.trackInventory.present
          ? data.trackInventory.value
          : this.trackInventory,
      minStock: data.minStock.present ? data.minStock.value : this.minStock,
      maxStock: data.maxStock.present ? data.maxStock.value : this.maxStock,
      reorderPoint: data.reorderPoint.present
          ? data.reorderPoint.value
          : this.reorderPoint,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      isSalable: data.isSalable.present ? data.isSalable.value : this.isSalable,
      isPurchasable: data.isPurchasable.present
          ? data.isPurchasable.value
          : this.isPurchasable,
      isReturnable: data.isReturnable.present
          ? data.isReturnable.value
          : this.isReturnable,
      requiresCooling: data.requiresCooling.present
          ? data.requiresCooling.value
          : this.requiresCooling,
      storageTemperatureMin: data.storageTemperatureMin.present
          ? data.storageTemperatureMin.value
          : this.storageTemperatureMin,
      storageTemperatureMax: data.storageTemperatureMax.present
          ? data.storageTemperatureMax.value
          : this.storageTemperatureMax,
      nutritionalInfo: data.nutritionalInfo.present
          ? data.nutritionalInfo.value
          : this.nutritionalInfo,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('minStock: $minStock, ')
          ..write('maxStock: $maxStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('isActive: $isActive, ')
          ..write('isSalable: $isSalable, ')
          ..write('isPurchasable: $isPurchasable, ')
          ..write('isReturnable: $isReturnable, ')
          ..write('requiresCooling: $requiresCooling, ')
          ..write('storageTemperatureMin: $storageTemperatureMin, ')
          ..write('storageTemperatureMax: $storageTemperatureMax, ')
          ..write('nutritionalInfo: $nutritionalInfo, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
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
        minStock,
        maxStock,
        reorderPoint,
        isActive,
        isSalable,
        isPurchasable,
        isReturnable,
        requiresCooling,
        storageTemperatureMin,
        storageTemperatureMax,
        nutritionalInfo,
        lastSync,
        createdAt,
        updatedAt
      ]);
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
          other.minStock == this.minStock &&
          other.maxStock == this.maxStock &&
          other.reorderPoint == this.reorderPoint &&
          other.isActive == this.isActive &&
          other.isSalable == this.isSalable &&
          other.isPurchasable == this.isPurchasable &&
          other.isReturnable == this.isReturnable &&
          other.requiresCooling == this.requiresCooling &&
          other.storageTemperatureMin == this.storageTemperatureMin &&
          other.storageTemperatureMax == this.storageTemperatureMax &&
          other.nutritionalInfo == this.nutritionalInfo &&
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
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
  final Value<int> minStock;
  final Value<int?> maxStock;
  final Value<int?> reorderPoint;
  final Value<bool> isActive;
  final Value<bool> isSalable;
  final Value<bool> isPurchasable;
  final Value<bool> isReturnable;
  final Value<bool> requiresCooling;
  final Value<double?> storageTemperatureMin;
  final Value<double?> storageTemperatureMax;
  final Value<String?> nutritionalInfo;
  final Value<DateTime?> lastSync;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
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
    this.minStock = const Value.absent(),
    this.maxStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSalable = const Value.absent(),
    this.isPurchasable = const Value.absent(),
    this.isReturnable = const Value.absent(),
    this.requiresCooling = const Value.absent(),
    this.storageTemperatureMin = const Value.absent(),
    this.storageTemperatureMax = const Value.absent(),
    this.nutritionalInfo = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
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
    this.minStock = const Value.absent(),
    this.maxStock = const Value.absent(),
    this.reorderPoint = const Value.absent(),
    this.isActive = const Value.absent(),
    this.isSalable = const Value.absent(),
    this.isPurchasable = const Value.absent(),
    this.isReturnable = const Value.absent(),
    this.requiresCooling = const Value.absent(),
    this.storageTemperatureMin = const Value.absent(),
    this.storageTemperatureMax = const Value.absent(),
    this.nutritionalInfo = const Value.absent(),
    this.lastSync = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
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
    Expression<int>? minStock,
    Expression<int>? maxStock,
    Expression<int>? reorderPoint,
    Expression<bool>? isActive,
    Expression<bool>? isSalable,
    Expression<bool>? isPurchasable,
    Expression<bool>? isReturnable,
    Expression<bool>? requiresCooling,
    Expression<double>? storageTemperatureMin,
    Expression<double>? storageTemperatureMax,
    Expression<String>? nutritionalInfo,
    Expression<DateTime>? lastSync,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
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
      if (minStock != null) 'min_stock': minStock,
      if (maxStock != null) 'max_stock': maxStock,
      if (reorderPoint != null) 'reorder_point': reorderPoint,
      if (isActive != null) 'is_active': isActive,
      if (isSalable != null) 'is_salable': isSalable,
      if (isPurchasable != null) 'is_purchasable': isPurchasable,
      if (isReturnable != null) 'is_returnable': isReturnable,
      if (requiresCooling != null) 'requires_cooling': requiresCooling,
      if (storageTemperatureMin != null)
        'storage_temperature_min': storageTemperatureMin,
      if (storageTemperatureMax != null)
        'storage_temperature_max': storageTemperatureMax,
      if (nutritionalInfo != null) 'nutritional_info': nutritionalInfo,
      if (lastSync != null) 'last_sync': lastSync,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProductsCompanion copyWith(
      {Value<String>? id,
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
      Value<int>? minStock,
      Value<int?>? maxStock,
      Value<int?>? reorderPoint,
      Value<bool>? isActive,
      Value<bool>? isSalable,
      Value<bool>? isPurchasable,
      Value<bool>? isReturnable,
      Value<bool>? requiresCooling,
      Value<double?>? storageTemperatureMin,
      Value<double?>? storageTemperatureMax,
      Value<String?>? nutritionalInfo,
      Value<DateTime?>? lastSync,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
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
      minStock: minStock ?? this.minStock,
      maxStock: maxStock ?? this.maxStock,
      reorderPoint: reorderPoint ?? this.reorderPoint,
      isActive: isActive ?? this.isActive,
      isSalable: isSalable ?? this.isSalable,
      isPurchasable: isPurchasable ?? this.isPurchasable,
      isReturnable: isReturnable ?? this.isReturnable,
      requiresCooling: requiresCooling ?? this.requiresCooling,
      storageTemperatureMin:
          storageTemperatureMin ?? this.storageTemperatureMin,
      storageTemperatureMax:
          storageTemperatureMax ?? this.storageTemperatureMax,
      nutritionalInfo: nutritionalInfo ?? this.nutritionalInfo,
      lastSync: lastSync ?? this.lastSync,
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
    if (minStock.present) {
      map['min_stock'] = Variable<int>(minStock.value);
    }
    if (maxStock.present) {
      map['max_stock'] = Variable<int>(maxStock.value);
    }
    if (reorderPoint.present) {
      map['reorder_point'] = Variable<int>(reorderPoint.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (isSalable.present) {
      map['is_salable'] = Variable<bool>(isSalable.value);
    }
    if (isPurchasable.present) {
      map['is_purchasable'] = Variable<bool>(isPurchasable.value);
    }
    if (isReturnable.present) {
      map['is_returnable'] = Variable<bool>(isReturnable.value);
    }
    if (requiresCooling.present) {
      map['requires_cooling'] = Variable<bool>(requiresCooling.value);
    }
    if (storageTemperatureMin.present) {
      map['storage_temperature_min'] =
          Variable<double>(storageTemperatureMin.value);
    }
    if (storageTemperatureMax.present) {
      map['storage_temperature_max'] =
          Variable<double>(storageTemperatureMax.value);
    }
    if (nutritionalInfo.present) {
      map['nutritional_info'] = Variable<String>(nutritionalInfo.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
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
          ..write('minStock: $minStock, ')
          ..write('maxStock: $maxStock, ')
          ..write('reorderPoint: $reorderPoint, ')
          ..write('isActive: $isActive, ')
          ..write('isSalable: $isSalable, ')
          ..write('isPurchasable: $isPurchasable, ')
          ..write('isReturnable: $isReturnable, ')
          ..write('requiresCooling: $requiresCooling, ')
          ..write('storageTemperatureMin: $storageTemperatureMin, ')
          ..write('storageTemperatureMax: $storageTemperatureMax, ')
          ..write('nutritionalInfo: $nutritionalInfo, ')
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _productIdMeta =
      const VerificationMeta('productId');
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
      'product_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES local_products (id)'));
  static const VerificationMeta _skuMeta = const VerificationMeta('sku');
  @override
  late final GeneratedColumn<String> sku = GeneratedColumn<String>(
      'sku', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _barcodeMeta =
      const VerificationMeta('barcode');
  @override
  late final GeneratedColumn<String> barcode = GeneratedColumn<String>(
      'barcode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _attributesMeta =
      const VerificationMeta('attributes');
  @override
  late final GeneratedColumn<String> attributes = GeneratedColumn<String>(
      'attributes', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('{}'));
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  static const VerificationMeta _weightKgMeta =
      const VerificationMeta('weightKg');
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
      'weight_kg', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _volumeLitersMeta =
      const VerificationMeta('volumeLiters');
  @override
  late final GeneratedColumn<double> volumeLiters = GeneratedColumn<double>(
      'volume_liters', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
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
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_product_variants';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalProductVariant> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('product_id')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('sku')) {
      context.handle(
          _skuMeta, sku.isAcceptableOrUnknown(data['sku']!, _skuMeta));
    } else if (isInserting) {
      context.missing(_skuMeta);
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta,
          barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    }
    if (data.containsKey('attributes')) {
      context.handle(
          _attributesMeta,
          attributes.isAcceptableOrUnknown(
              data['attributes']!, _attributesMeta));
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    }
    if (data.containsKey('weight_kg')) {
      context.handle(_weightKgMeta,
          weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta));
    }
    if (data.containsKey('volume_liters')) {
      context.handle(
          _volumeLitersMeta,
          volumeLiters.isAcceptableOrUnknown(
              data['volume_liters']!, _volumeLitersMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalProductVariant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalProductVariant(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      productId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}product_id'])!,
      sku: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sku'])!,
      barcode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}barcode']),
      attributes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}attributes'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      weightKg: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight_kg']),
      volumeLiters: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}volume_liters']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final String tenantId;
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
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalProductVariant(
      {required this.id,
      required this.tenantId,
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
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
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
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalProductVariantsCompanion toCompanion(bool nullToAbsent) {
    return LocalProductVariantsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
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
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalProductVariant.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalProductVariant(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
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
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalProductVariant copyWith(
          {String? id,
          String? tenantId,
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
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalProductVariant(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        productId: productId ?? this.productId,
        sku: sku ?? this.sku,
        barcode: barcode.present ? barcode.value : this.barcode,
        attributes: attributes ?? this.attributes,
        price: price ?? this.price,
        weightKg: weightKg.present ? weightKg.value : this.weightKg,
        volumeLiters:
            volumeLiters.present ? volumeLiters.value : this.volumeLiters,
        isDefault: isDefault ?? this.isDefault,
        isActive: isActive ?? this.isActive,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalProductVariant copyWithCompanion(LocalProductVariantsCompanion data) {
    return LocalProductVariant(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      productId: data.productId.present ? data.productId.value : this.productId,
      sku: data.sku.present ? data.sku.value : this.sku,
      barcode: data.barcode.present ? data.barcode.value : this.barcode,
      attributes:
          data.attributes.present ? data.attributes.value : this.attributes,
      price: data.price.present ? data.price.value : this.price,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      volumeLiters: data.volumeLiters.present
          ? data.volumeLiters.value
          : this.volumeLiters,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalProductVariant(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
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
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalProductVariant &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.productId == this.productId &&
          other.sku == this.sku &&
          other.barcode == this.barcode &&
          other.attributes == this.attributes &&
          other.price == this.price &&
          other.weightKg == this.weightKg &&
          other.volumeLiters == this.volumeLiters &&
          other.isDefault == this.isDefault &&
          other.isActive == this.isActive &&
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalProductVariantsCompanion
    extends UpdateCompanion<LocalProductVariant> {
  final Value<String> id;
  final Value<String> tenantId;
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
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalProductVariantsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalProductVariantsCompanion.insert({
    required String id,
    required String tenantId,
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        productId = Value(productId),
        sku = Value(sku);
  static Insertable<LocalProductVariant> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
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
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
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
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalProductVariantsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
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
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalProductVariantsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
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
    return (StringBuffer('LocalProductVariantsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerTypeMeta =
      const VerificationMeta('customerType');
  @override
  late final GeneratedColumn<String> customerType = GeneratedColumn<String>(
      'customer_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isDefaultMeta =
      const VerificationMeta('isDefault');
  @override
  late final GeneratedColumn<bool> isDefault = GeneratedColumn<bool>(
      'is_default', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_default" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _validFromMeta =
      const VerificationMeta('validFrom');
  @override
  late final GeneratedColumn<DateTime> validFrom = GeneratedColumn<DateTime>(
      'valid_from', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _validToMeta =
      const VerificationMeta('validTo');
  @override
  late final GeneratedColumn<DateTime> validTo = GeneratedColumn<DateTime>(
      'valid_to', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_price_lists';
  @override
  VerificationContext validateIntegrity(Insertable<LocalPriceList> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('customer_type')) {
      context.handle(
          _customerTypeMeta,
          customerType.isAcceptableOrUnknown(
              data['customer_type']!, _customerTypeMeta));
    }
    if (data.containsKey('is_default')) {
      context.handle(_isDefaultMeta,
          isDefault.isAcceptableOrUnknown(data['is_default']!, _isDefaultMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('valid_from')) {
      context.handle(_validFromMeta,
          validFrom.isAcceptableOrUnknown(data['valid_from']!, _validFromMeta));
    }
    if (data.containsKey('valid_to')) {
      context.handle(_validToMeta,
          validTo.isAcceptableOrUnknown(data['valid_to']!, _validToMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPriceList map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPriceList(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      customerType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_type']),
      isDefault: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_default'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      validFrom: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_from']),
      validTo: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}valid_to']),
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalPriceList(
      {required this.id,
      required this.tenantId,
      required this.name,
      this.description,
      this.customerType,
      required this.isDefault,
      required this.isActive,
      this.validFrom,
      this.validTo,
      this.lastSync,
      required this.createdAt,
      required this.updatedAt});
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
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
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
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalPriceList.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'customerType': serializer.toJson<String?>(customerType),
      'isDefault': serializer.toJson<bool>(isDefault),
      'isActive': serializer.toJson<bool>(isActive),
      'validFrom': serializer.toJson<DateTime?>(validFrom),
      'validTo': serializer.toJson<DateTime?>(validTo),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalPriceList copyWith(
          {String? id,
          String? tenantId,
          String? name,
          Value<String?> description = const Value.absent(),
          Value<String?> customerType = const Value.absent(),
          bool? isDefault,
          bool? isActive,
          Value<DateTime?> validFrom = const Value.absent(),
          Value<DateTime?> validTo = const Value.absent(),
          Value<DateTime?> lastSync = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalPriceList(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        name: name ?? this.name,
        description: description.present ? description.value : this.description,
        customerType:
            customerType.present ? customerType.value : this.customerType,
        isDefault: isDefault ?? this.isDefault,
        isActive: isActive ?? this.isActive,
        validFrom: validFrom.present ? validFrom.value : this.validFrom,
        validTo: validTo.present ? validTo.value : this.validTo,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalPriceList copyWithCompanion(LocalPriceListsCompanion data) {
    return LocalPriceList(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      customerType: data.customerType.present
          ? data.customerType.value
          : this.customerType,
      isDefault: data.isDefault.present ? data.isDefault.value : this.isDefault,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      validFrom: data.validFrom.present ? data.validFrom.value : this.validFrom,
      validTo: data.validTo.present ? data.validTo.value : this.validTo,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, name, description, customerType,
      isDefault, isActive, validFrom, validTo, lastSync, createdAt, updatedAt);
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
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
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
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
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
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
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
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPriceListsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? customerType,
      Value<bool>? isDefault,
      Value<bool>? isActive,
      Value<DateTime?>? validFrom,
      Value<DateTime?>? validTo,
      Value<DateTime?>? lastSync,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priceListIdMeta =
      const VerificationMeta('priceListId');
  @override
  late final GeneratedColumn<String> priceListId = GeneratedColumn<String>(
      'price_list_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_price_lists (id)'));
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_product_variants (id)'));
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
      'price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costPriceMeta =
      const VerificationMeta('costPrice');
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
      'cost_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _minQuantityMeta =
      const VerificationMeta('minQuantity');
  @override
  late final GeneratedColumn<int> minQuantity = GeneratedColumn<int>(
      'min_quantity', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(1));
  static const VerificationMeta _maxQuantityMeta =
      const VerificationMeta('maxQuantity');
  @override
  late final GeneratedColumn<int> maxQuantity = GeneratedColumn<int>(
      'max_quantity', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _volumeDiscountPercentMeta =
      const VerificationMeta('volumeDiscountPercent');
  @override
  late final GeneratedColumn<double> volumeDiscountPercent =
      GeneratedColumn<double>('volume_discount_percent', aliasedName, false,
          type: DriftSqlType.double,
          requiredDuringInsert: false,
          defaultValue: const Constant(0));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _lastSyncMeta =
      const VerificationMeta('lastSync');
  @override
  late final GeneratedColumn<DateTime> lastSync = GeneratedColumn<DateTime>(
      'last_sync', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
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
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_price_list_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocalPriceListItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('price_list_id')) {
      context.handle(
          _priceListIdMeta,
          priceListId.isAcceptableOrUnknown(
              data['price_list_id']!, _priceListIdMeta));
    } else if (isInserting) {
      context.missing(_priceListIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
          _priceMeta, price.isAcceptableOrUnknown(data['price']!, _priceMeta));
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(_costPriceMeta,
          costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta));
    }
    if (data.containsKey('min_quantity')) {
      context.handle(
          _minQuantityMeta,
          minQuantity.isAcceptableOrUnknown(
              data['min_quantity']!, _minQuantityMeta));
    }
    if (data.containsKey('max_quantity')) {
      context.handle(
          _maxQuantityMeta,
          maxQuantity.isAcceptableOrUnknown(
              data['max_quantity']!, _maxQuantityMeta));
    }
    if (data.containsKey('volume_discount_percent')) {
      context.handle(
          _volumeDiscountPercentMeta,
          volumeDiscountPercent.isAcceptableOrUnknown(
              data['volume_discount_percent']!, _volumeDiscountPercentMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('last_sync')) {
      context.handle(_lastSyncMeta,
          lastSync.isAcceptableOrUnknown(data['last_sync']!, _lastSyncMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalPriceListItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalPriceListItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      priceListId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price_list_id'])!,
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id'])!,
      price: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}price'])!,
      costPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_price']),
      minQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}min_quantity'])!,
      maxQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_quantity']),
      volumeDiscountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double,
          data['${effectivePrefix}volume_discount_percent'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      lastSync: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_sync']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalPriceListItem(
      {required this.id,
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
      required this.createdAt,
      required this.updatedAt});
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
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
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
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalPriceListItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
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
      volumeDiscountPercent:
          serializer.fromJson<double>(json['volumeDiscountPercent']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      lastSync: serializer.fromJson<DateTime?>(json['lastSync']),
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
      'priceListId': serializer.toJson<String>(priceListId),
      'variantId': serializer.toJson<String>(variantId),
      'price': serializer.toJson<double>(price),
      'costPrice': serializer.toJson<double?>(costPrice),
      'minQuantity': serializer.toJson<int>(minQuantity),
      'maxQuantity': serializer.toJson<int?>(maxQuantity),
      'volumeDiscountPercent': serializer.toJson<double>(volumeDiscountPercent),
      'isActive': serializer.toJson<bool>(isActive),
      'lastSync': serializer.toJson<DateTime?>(lastSync),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalPriceListItem copyWith(
          {String? id,
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
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalPriceListItem(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        priceListId: priceListId ?? this.priceListId,
        variantId: variantId ?? this.variantId,
        price: price ?? this.price,
        costPrice: costPrice.present ? costPrice.value : this.costPrice,
        minQuantity: minQuantity ?? this.minQuantity,
        maxQuantity: maxQuantity.present ? maxQuantity.value : this.maxQuantity,
        volumeDiscountPercent:
            volumeDiscountPercent ?? this.volumeDiscountPercent,
        isActive: isActive ?? this.isActive,
        lastSync: lastSync.present ? lastSync.value : this.lastSync,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalPriceListItem copyWithCompanion(LocalPriceListItemsCompanion data) {
    return LocalPriceListItem(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      priceListId:
          data.priceListId.present ? data.priceListId.value : this.priceListId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      price: data.price.present ? data.price.value : this.price,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      minQuantity:
          data.minQuantity.present ? data.minQuantity.value : this.minQuantity,
      maxQuantity:
          data.maxQuantity.present ? data.maxQuantity.value : this.maxQuantity,
      volumeDiscountPercent: data.volumeDiscountPercent.present
          ? data.volumeDiscountPercent.value
          : this.volumeDiscountPercent,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      lastSync: data.lastSync.present ? data.lastSync.value : this.lastSync,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('lastSync: $lastSync, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
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
      createdAt,
      updatedAt);
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
          other.lastSync == this.lastSync &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
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
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
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
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
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
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
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
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalPriceListItemsCompanion copyWith(
      {Value<String>? id,
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
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
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
      map['volume_discount_percent'] =
          Variable<double>(volumeDiscountPercent.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (lastSync.present) {
      map['last_sync'] = Variable<DateTime>(lastSync.value);
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
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalInventoryLotsTable extends LocalInventoryLots
    with TableInfo<$LocalInventoryLotsTable, LocalInventoryLot> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalInventoryLotsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lotNumberMeta =
      const VerificationMeta('lotNumber');
  @override
  late final GeneratedColumn<String> lotNumber = GeneratedColumn<String>(
      'lot_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_product_variants (id)'));
  static const VerificationMeta _purchaseInvoiceIdMeta =
      const VerificationMeta('purchaseInvoiceId');
  @override
  late final GeneratedColumn<String> purchaseInvoiceId =
      GeneratedColumn<String>('purchase_invoice_id', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _initialQuantityMeta =
      const VerificationMeta('initialQuantity');
  @override
  late final GeneratedColumn<int> initialQuantity = GeneratedColumn<int>(
      'initial_quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _currentQuantityMeta =
      const VerificationMeta('currentQuantity');
  @override
  late final GeneratedColumn<int> currentQuantity = GeneratedColumn<int>(
      'current_quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _purchasePriceMeta =
      const VerificationMeta('purchasePrice');
  @override
  late final GeneratedColumn<double> purchasePrice = GeneratedColumn<double>(
      'purchase_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitCostMeta =
      const VerificationMeta('unitCost');
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
      'unit_cost', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _productionDateMeta =
      const VerificationMeta('productionDate');
  @override
  late final GeneratedColumn<DateTime> productionDate =
      GeneratedColumn<DateTime>('production_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _expiryDateMeta =
      const VerificationMeta('expiryDate');
  @override
  late final GeneratedColumn<DateTime> expiryDate = GeneratedColumn<DateTime>(
      'expiry_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<LotStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('active'))
          .withConverter<LotStatus>($LocalInventoryLotsTable.$converterstatus);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        lotNumber,
        variantId,
        purchaseInvoiceId,
        branchId,
        initialQuantity,
        currentQuantity,
        purchasePrice,
        unitCost,
        productionDate,
        expiryDate,
        status,
        notes,
        synced,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_inventory_lots';
  @override
  VerificationContext validateIntegrity(Insertable<LocalInventoryLot> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('lot_number')) {
      context.handle(_lotNumberMeta,
          lotNumber.isAcceptableOrUnknown(data['lot_number']!, _lotNumberMeta));
    } else if (isInserting) {
      context.missing(_lotNumberMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('purchase_invoice_id')) {
      context.handle(
          _purchaseInvoiceIdMeta,
          purchaseInvoiceId.isAcceptableOrUnknown(
              data['purchase_invoice_id']!, _purchaseInvoiceIdMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('initial_quantity')) {
      context.handle(
          _initialQuantityMeta,
          initialQuantity.isAcceptableOrUnknown(
              data['initial_quantity']!, _initialQuantityMeta));
    } else if (isInserting) {
      context.missing(_initialQuantityMeta);
    }
    if (data.containsKey('current_quantity')) {
      context.handle(
          _currentQuantityMeta,
          currentQuantity.isAcceptableOrUnknown(
              data['current_quantity']!, _currentQuantityMeta));
    } else if (isInserting) {
      context.missing(_currentQuantityMeta);
    }
    if (data.containsKey('purchase_price')) {
      context.handle(
          _purchasePriceMeta,
          purchasePrice.isAcceptableOrUnknown(
              data['purchase_price']!, _purchasePriceMeta));
    } else if (isInserting) {
      context.missing(_purchasePriceMeta);
    }
    if (data.containsKey('unit_cost')) {
      context.handle(_unitCostMeta,
          unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta));
    }
    if (data.containsKey('production_date')) {
      context.handle(
          _productionDateMeta,
          productionDate.isAcceptableOrUnknown(
              data['production_date']!, _productionDateMeta));
    }
    if (data.containsKey('expiry_date')) {
      context.handle(
          _expiryDateMeta,
          expiryDate.isAcceptableOrUnknown(
              data['expiry_date']!, _expiryDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalInventoryLot map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalInventoryLot(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      lotNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lot_number'])!,
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id'])!,
      purchaseInvoiceId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}purchase_invoice_id']),
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      initialQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}initial_quantity'])!,
      currentQuantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}current_quantity'])!,
      purchasePrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}purchase_price'])!,
      unitCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_cost']),
      productionDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}production_date']),
      expiryDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}expiry_date']),
      status: $LocalInventoryLotsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalInventoryLotsTable createAlias(String alias) {
    return $LocalInventoryLotsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LotStatus, String, String> $converterstatus =
      const EnumNameConverter<LotStatus>(LotStatus.values);
}

class LocalInventoryLot extends DataClass
    implements Insertable<LocalInventoryLot> {
  final String id;
  final String tenantId;
  final String lotNumber;
  final String variantId;
  final String? purchaseInvoiceId;
  final String branchId;
  final int initialQuantity;
  final int currentQuantity;
  final double purchasePrice;
  final double? unitCost;
  final DateTime? productionDate;
  final DateTime? expiryDate;
  final LotStatus status;
  final String? notes;
  final bool synced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalInventoryLot(
      {required this.id,
      required this.tenantId,
      required this.lotNumber,
      required this.variantId,
      this.purchaseInvoiceId,
      required this.branchId,
      required this.initialQuantity,
      required this.currentQuantity,
      required this.purchasePrice,
      this.unitCost,
      this.productionDate,
      this.expiryDate,
      required this.status,
      this.notes,
      required this.synced,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['lot_number'] = Variable<String>(lotNumber);
    map['variant_id'] = Variable<String>(variantId);
    if (!nullToAbsent || purchaseInvoiceId != null) {
      map['purchase_invoice_id'] = Variable<String>(purchaseInvoiceId);
    }
    map['branch_id'] = Variable<String>(branchId);
    map['initial_quantity'] = Variable<int>(initialQuantity);
    map['current_quantity'] = Variable<int>(currentQuantity);
    map['purchase_price'] = Variable<double>(purchasePrice);
    if (!nullToAbsent || unitCost != null) {
      map['unit_cost'] = Variable<double>(unitCost);
    }
    if (!nullToAbsent || productionDate != null) {
      map['production_date'] = Variable<DateTime>(productionDate);
    }
    if (!nullToAbsent || expiryDate != null) {
      map['expiry_date'] = Variable<DateTime>(expiryDate);
    }
    {
      map['status'] = Variable<String>(
          $LocalInventoryLotsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalInventoryLotsCompanion toCompanion(bool nullToAbsent) {
    return LocalInventoryLotsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      lotNumber: Value(lotNumber),
      variantId: Value(variantId),
      purchaseInvoiceId: purchaseInvoiceId == null && nullToAbsent
          ? const Value.absent()
          : Value(purchaseInvoiceId),
      branchId: Value(branchId),
      initialQuantity: Value(initialQuantity),
      currentQuantity: Value(currentQuantity),
      purchasePrice: Value(purchasePrice),
      unitCost: unitCost == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCost),
      productionDate: productionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(productionDate),
      expiryDate: expiryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(expiryDate),
      status: Value(status),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      synced: Value(synced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalInventoryLot.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalInventoryLot(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      lotNumber: serializer.fromJson<String>(json['lotNumber']),
      variantId: serializer.fromJson<String>(json['variantId']),
      purchaseInvoiceId:
          serializer.fromJson<String?>(json['purchaseInvoiceId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      initialQuantity: serializer.fromJson<int>(json['initialQuantity']),
      currentQuantity: serializer.fromJson<int>(json['currentQuantity']),
      purchasePrice: serializer.fromJson<double>(json['purchasePrice']),
      unitCost: serializer.fromJson<double?>(json['unitCost']),
      productionDate: serializer.fromJson<DateTime?>(json['productionDate']),
      expiryDate: serializer.fromJson<DateTime?>(json['expiryDate']),
      status: $LocalInventoryLotsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'lotNumber': serializer.toJson<String>(lotNumber),
      'variantId': serializer.toJson<String>(variantId),
      'purchaseInvoiceId': serializer.toJson<String?>(purchaseInvoiceId),
      'branchId': serializer.toJson<String>(branchId),
      'initialQuantity': serializer.toJson<int>(initialQuantity),
      'currentQuantity': serializer.toJson<int>(currentQuantity),
      'purchasePrice': serializer.toJson<double>(purchasePrice),
      'unitCost': serializer.toJson<double?>(unitCost),
      'productionDate': serializer.toJson<DateTime?>(productionDate),
      'expiryDate': serializer.toJson<DateTime?>(expiryDate),
      'status': serializer.toJson<String>(
          $LocalInventoryLotsTable.$converterstatus.toJson(status)),
      'notes': serializer.toJson<String?>(notes),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalInventoryLot copyWith(
          {String? id,
          String? tenantId,
          String? lotNumber,
          String? variantId,
          Value<String?> purchaseInvoiceId = const Value.absent(),
          String? branchId,
          int? initialQuantity,
          int? currentQuantity,
          double? purchasePrice,
          Value<double?> unitCost = const Value.absent(),
          Value<DateTime?> productionDate = const Value.absent(),
          Value<DateTime?> expiryDate = const Value.absent(),
          LotStatus? status,
          Value<String?> notes = const Value.absent(),
          bool? synced,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalInventoryLot(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        lotNumber: lotNumber ?? this.lotNumber,
        variantId: variantId ?? this.variantId,
        purchaseInvoiceId: purchaseInvoiceId.present
            ? purchaseInvoiceId.value
            : this.purchaseInvoiceId,
        branchId: branchId ?? this.branchId,
        initialQuantity: initialQuantity ?? this.initialQuantity,
        currentQuantity: currentQuantity ?? this.currentQuantity,
        purchasePrice: purchasePrice ?? this.purchasePrice,
        unitCost: unitCost.present ? unitCost.value : this.unitCost,
        productionDate:
            productionDate.present ? productionDate.value : this.productionDate,
        expiryDate: expiryDate.present ? expiryDate.value : this.expiryDate,
        status: status ?? this.status,
        notes: notes.present ? notes.value : this.notes,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalInventoryLot copyWithCompanion(LocalInventoryLotsCompanion data) {
    return LocalInventoryLot(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      lotNumber: data.lotNumber.present ? data.lotNumber.value : this.lotNumber,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      purchaseInvoiceId: data.purchaseInvoiceId.present
          ? data.purchaseInvoiceId.value
          : this.purchaseInvoiceId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      initialQuantity: data.initialQuantity.present
          ? data.initialQuantity.value
          : this.initialQuantity,
      currentQuantity: data.currentQuantity.present
          ? data.currentQuantity.value
          : this.currentQuantity,
      purchasePrice: data.purchasePrice.present
          ? data.purchasePrice.value
          : this.purchasePrice,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      productionDate: data.productionDate.present
          ? data.productionDate.value
          : this.productionDate,
      expiryDate:
          data.expiryDate.present ? data.expiryDate.value : this.expiryDate,
      status: data.status.present ? data.status.value : this.status,
      notes: data.notes.present ? data.notes.value : this.notes,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryLot(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('variantId: $variantId, ')
          ..write('purchaseInvoiceId: $purchaseInvoiceId, ')
          ..write('branchId: $branchId, ')
          ..write('initialQuantity: $initialQuantity, ')
          ..write('currentQuantity: $currentQuantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('unitCost: $unitCost, ')
          ..write('productionDate: $productionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
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
      lotNumber,
      variantId,
      purchaseInvoiceId,
      branchId,
      initialQuantity,
      currentQuantity,
      purchasePrice,
      unitCost,
      productionDate,
      expiryDate,
      status,
      notes,
      synced,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalInventoryLot &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.lotNumber == this.lotNumber &&
          other.variantId == this.variantId &&
          other.purchaseInvoiceId == this.purchaseInvoiceId &&
          other.branchId == this.branchId &&
          other.initialQuantity == this.initialQuantity &&
          other.currentQuantity == this.currentQuantity &&
          other.purchasePrice == this.purchasePrice &&
          other.unitCost == this.unitCost &&
          other.productionDate == this.productionDate &&
          other.expiryDate == this.expiryDate &&
          other.status == this.status &&
          other.notes == this.notes &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalInventoryLotsCompanion extends UpdateCompanion<LocalInventoryLot> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> lotNumber;
  final Value<String> variantId;
  final Value<String?> purchaseInvoiceId;
  final Value<String> branchId;
  final Value<int> initialQuantity;
  final Value<int> currentQuantity;
  final Value<double> purchasePrice;
  final Value<double?> unitCost;
  final Value<DateTime?> productionDate;
  final Value<DateTime?> expiryDate;
  final Value<LotStatus> status;
  final Value<String?> notes;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalInventoryLotsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.lotNumber = const Value.absent(),
    this.variantId = const Value.absent(),
    this.purchaseInvoiceId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.initialQuantity = const Value.absent(),
    this.currentQuantity = const Value.absent(),
    this.purchasePrice = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.productionDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalInventoryLotsCompanion.insert({
    required String id,
    required String tenantId,
    required String lotNumber,
    required String variantId,
    this.purchaseInvoiceId = const Value.absent(),
    required String branchId,
    required int initialQuantity,
    required int currentQuantity,
    required double purchasePrice,
    this.unitCost = const Value.absent(),
    this.productionDate = const Value.absent(),
    this.expiryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        lotNumber = Value(lotNumber),
        variantId = Value(variantId),
        branchId = Value(branchId),
        initialQuantity = Value(initialQuantity),
        currentQuantity = Value(currentQuantity),
        purchasePrice = Value(purchasePrice);
  static Insertable<LocalInventoryLot> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? lotNumber,
    Expression<String>? variantId,
    Expression<String>? purchaseInvoiceId,
    Expression<String>? branchId,
    Expression<int>? initialQuantity,
    Expression<int>? currentQuantity,
    Expression<double>? purchasePrice,
    Expression<double>? unitCost,
    Expression<DateTime>? productionDate,
    Expression<DateTime>? expiryDate,
    Expression<String>? status,
    Expression<String>? notes,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (lotNumber != null) 'lot_number': lotNumber,
      if (variantId != null) 'variant_id': variantId,
      if (purchaseInvoiceId != null) 'purchase_invoice_id': purchaseInvoiceId,
      if (branchId != null) 'branch_id': branchId,
      if (initialQuantity != null) 'initial_quantity': initialQuantity,
      if (currentQuantity != null) 'current_quantity': currentQuantity,
      if (purchasePrice != null) 'purchase_price': purchasePrice,
      if (unitCost != null) 'unit_cost': unitCost,
      if (productionDate != null) 'production_date': productionDate,
      if (expiryDate != null) 'expiry_date': expiryDate,
      if (status != null) 'status': status,
      if (notes != null) 'notes': notes,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalInventoryLotsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? lotNumber,
      Value<String>? variantId,
      Value<String?>? purchaseInvoiceId,
      Value<String>? branchId,
      Value<int>? initialQuantity,
      Value<int>? currentQuantity,
      Value<double>? purchasePrice,
      Value<double?>? unitCost,
      Value<DateTime?>? productionDate,
      Value<DateTime?>? expiryDate,
      Value<LotStatus>? status,
      Value<String?>? notes,
      Value<bool>? synced,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalInventoryLotsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      lotNumber: lotNumber ?? this.lotNumber,
      variantId: variantId ?? this.variantId,
      purchaseInvoiceId: purchaseInvoiceId ?? this.purchaseInvoiceId,
      branchId: branchId ?? this.branchId,
      initialQuantity: initialQuantity ?? this.initialQuantity,
      currentQuantity: currentQuantity ?? this.currentQuantity,
      purchasePrice: purchasePrice ?? this.purchasePrice,
      unitCost: unitCost ?? this.unitCost,
      productionDate: productionDate ?? this.productionDate,
      expiryDate: expiryDate ?? this.expiryDate,
      status: status ?? this.status,
      notes: notes ?? this.notes,
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
    if (lotNumber.present) {
      map['lot_number'] = Variable<String>(lotNumber.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (purchaseInvoiceId.present) {
      map['purchase_invoice_id'] = Variable<String>(purchaseInvoiceId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (initialQuantity.present) {
      map['initial_quantity'] = Variable<int>(initialQuantity.value);
    }
    if (currentQuantity.present) {
      map['current_quantity'] = Variable<int>(currentQuantity.value);
    }
    if (purchasePrice.present) {
      map['purchase_price'] = Variable<double>(purchasePrice.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (productionDate.present) {
      map['production_date'] = Variable<DateTime>(productionDate.value);
    }
    if (expiryDate.present) {
      map['expiry_date'] = Variable<DateTime>(expiryDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $LocalInventoryLotsTable.$converterstatus.toSql(status.value));
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    return (StringBuffer('LocalInventoryLotsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('lotNumber: $lotNumber, ')
          ..write('variantId: $variantId, ')
          ..write('purchaseInvoiceId: $purchaseInvoiceId, ')
          ..write('branchId: $branchId, ')
          ..write('initialQuantity: $initialQuantity, ')
          ..write('currentQuantity: $currentQuantity, ')
          ..write('purchasePrice: $purchasePrice, ')
          ..write('unitCost: $unitCost, ')
          ..write('productionDate: $productionDate, ')
          ..write('expiryDate: $expiryDate, ')
          ..write('status: $status, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
      'lot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_product_variants (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<MovementType, String>
      movementType = GeneratedColumn<String>(
              'movement_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<MovementType>(
              $LocalInventoryMovementsTable.$convertermovementType);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _referenceTypeMeta =
      const VerificationMeta('referenceType');
  @override
  late final GeneratedColumn<String> referenceType = GeneratedColumn<String>(
      'reference_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _referenceIdMeta =
      const VerificationMeta('referenceId');
  @override
  late final GeneratedColumn<String> referenceId = GeneratedColumn<String>(
      'reference_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _unitCostMeta =
      const VerificationMeta('unitCost');
  @override
  late final GeneratedColumn<double> unitCost = GeneratedColumn<double>(
      'unit_cost', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _totalCostMeta =
      const VerificationMeta('totalCost');
  @override
  late final GeneratedColumn<double> totalCost = GeneratedColumn<double>(
      'total_cost', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _movementDateMeta =
      const VerificationMeta('movementDate');
  @override
  late final GeneratedColumn<DateTime> movementDate = GeneratedColumn<DateTime>(
      'movement_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        lotId,
        branchId,
        variantId,
        movementType,
        quantity,
        referenceType,
        referenceId,
        notes,
        unitCost,
        totalCost,
        createdBy,
        movementDate,
        localId,
        synced,
        syncedAt,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_inventory_movements';
  @override
  VerificationContext validateIntegrity(
      Insertable<LocalInventoryMovement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
          _lotIdMeta, lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('reference_type')) {
      context.handle(
          _referenceTypeMeta,
          referenceType.isAcceptableOrUnknown(
              data['reference_type']!, _referenceTypeMeta));
    }
    if (data.containsKey('reference_id')) {
      context.handle(
          _referenceIdMeta,
          referenceId.isAcceptableOrUnknown(
              data['reference_id']!, _referenceIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('unit_cost')) {
      context.handle(_unitCostMeta,
          unitCost.isAcceptableOrUnknown(data['unit_cost']!, _unitCostMeta));
    }
    if (data.containsKey('total_cost')) {
      context.handle(_totalCostMeta,
          totalCost.isAcceptableOrUnknown(data['total_cost']!, _totalCostMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('movement_date')) {
      context.handle(
          _movementDateMeta,
          movementDate.isAcceptableOrUnknown(
              data['movement_date']!, _movementDateMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalInventoryMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalInventoryMovement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      lotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lot_id']),
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id'])!,
      movementType: $LocalInventoryMovementsTable.$convertermovementType
          .fromSql(attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}movement_type'])!),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      referenceType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_type']),
      referenceId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      unitCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_cost']),
      totalCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_cost']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      movementDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}movement_date'])!,
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LocalInventoryMovementsTable createAlias(String alias) {
    return $LocalInventoryMovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<MovementType, String, String>
      $convertermovementType =
      const EnumNameConverter<MovementType>(MovementType.values);
}

class LocalInventoryMovement extends DataClass
    implements Insertable<LocalInventoryMovement> {
  final String id;
  final String tenantId;
  final String? lotId;
  final String branchId;
  final String variantId;
  final MovementType movementType;
  final int quantity;
  final String? referenceType;
  final String? referenceId;
  final String? notes;
  final double? unitCost;
  final double? totalCost;
  final String? createdBy;
  final DateTime movementDate;
  final String localId;
  final bool synced;
  final DateTime? syncedAt;
  final DateTime createdAt;
  const LocalInventoryMovement(
      {required this.id,
      required this.tenantId,
      this.lotId,
      required this.branchId,
      required this.variantId,
      required this.movementType,
      required this.quantity,
      this.referenceType,
      this.referenceId,
      this.notes,
      this.unitCost,
      this.totalCost,
      this.createdBy,
      required this.movementDate,
      required this.localId,
      required this.synced,
      this.syncedAt,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    if (!nullToAbsent || lotId != null) {
      map['lot_id'] = Variable<String>(lotId);
    }
    map['branch_id'] = Variable<String>(branchId);
    map['variant_id'] = Variable<String>(variantId);
    {
      map['movement_type'] = Variable<String>($LocalInventoryMovementsTable
          .$convertermovementType
          .toSql(movementType));
    }
    map['quantity'] = Variable<int>(quantity);
    if (!nullToAbsent || referenceType != null) {
      map['reference_type'] = Variable<String>(referenceType);
    }
    if (!nullToAbsent || referenceId != null) {
      map['reference_id'] = Variable<String>(referenceId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || unitCost != null) {
      map['unit_cost'] = Variable<double>(unitCost);
    }
    if (!nullToAbsent || totalCost != null) {
      map['total_cost'] = Variable<double>(totalCost);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
    map['movement_date'] = Variable<DateTime>(movementDate);
    map['local_id'] = Variable<String>(localId);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalInventoryMovementsCompanion toCompanion(bool nullToAbsent) {
    return LocalInventoryMovementsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      lotId:
          lotId == null && nullToAbsent ? const Value.absent() : Value(lotId),
      branchId: Value(branchId),
      variantId: Value(variantId),
      movementType: Value(movementType),
      quantity: Value(quantity),
      referenceType: referenceType == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceType),
      referenceId: referenceId == null && nullToAbsent
          ? const Value.absent()
          : Value(referenceId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      unitCost: unitCost == null && nullToAbsent
          ? const Value.absent()
          : Value(unitCost),
      totalCost: totalCost == null && nullToAbsent
          ? const Value.absent()
          : Value(totalCost),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      movementDate: Value(movementDate),
      localId: Value(localId),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      createdAt: Value(createdAt),
    );
  }

  factory LocalInventoryMovement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalInventoryMovement(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      lotId: serializer.fromJson<String?>(json['lotId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      movementType: $LocalInventoryMovementsTable.$convertermovementType
          .fromJson(serializer.fromJson<String>(json['movementType'])),
      quantity: serializer.fromJson<int>(json['quantity']),
      referenceType: serializer.fromJson<String?>(json['referenceType']),
      referenceId: serializer.fromJson<String?>(json['referenceId']),
      notes: serializer.fromJson<String?>(json['notes']),
      unitCost: serializer.fromJson<double?>(json['unitCost']),
      totalCost: serializer.fromJson<double?>(json['totalCost']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
      movementDate: serializer.fromJson<DateTime>(json['movementDate']),
      localId: serializer.fromJson<String>(json['localId']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'lotId': serializer.toJson<String?>(lotId),
      'branchId': serializer.toJson<String>(branchId),
      'variantId': serializer.toJson<String>(variantId),
      'movementType': serializer.toJson<String>($LocalInventoryMovementsTable
          .$convertermovementType
          .toJson(movementType)),
      'quantity': serializer.toJson<int>(quantity),
      'referenceType': serializer.toJson<String?>(referenceType),
      'referenceId': serializer.toJson<String?>(referenceId),
      'notes': serializer.toJson<String?>(notes),
      'unitCost': serializer.toJson<double?>(unitCost),
      'totalCost': serializer.toJson<double?>(totalCost),
      'createdBy': serializer.toJson<String?>(createdBy),
      'movementDate': serializer.toJson<DateTime>(movementDate),
      'localId': serializer.toJson<String>(localId),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalInventoryMovement copyWith(
          {String? id,
          String? tenantId,
          Value<String?> lotId = const Value.absent(),
          String? branchId,
          String? variantId,
          MovementType? movementType,
          int? quantity,
          Value<String?> referenceType = const Value.absent(),
          Value<String?> referenceId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          Value<double?> unitCost = const Value.absent(),
          Value<double?> totalCost = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          DateTime? movementDate,
          String? localId,
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          DateTime? createdAt}) =>
      LocalInventoryMovement(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        lotId: lotId.present ? lotId.value : this.lotId,
        branchId: branchId ?? this.branchId,
        variantId: variantId ?? this.variantId,
        movementType: movementType ?? this.movementType,
        quantity: quantity ?? this.quantity,
        referenceType:
            referenceType.present ? referenceType.value : this.referenceType,
        referenceId: referenceId.present ? referenceId.value : this.referenceId,
        notes: notes.present ? notes.value : this.notes,
        unitCost: unitCost.present ? unitCost.value : this.unitCost,
        totalCost: totalCost.present ? totalCost.value : this.totalCost,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
        movementDate: movementDate ?? this.movementDate,
        localId: localId ?? this.localId,
        synced: synced ?? this.synced,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        createdAt: createdAt ?? this.createdAt,
      );
  LocalInventoryMovement copyWithCompanion(
      LocalInventoryMovementsCompanion data) {
    return LocalInventoryMovement(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      referenceType: data.referenceType.present
          ? data.referenceType.value
          : this.referenceType,
      referenceId:
          data.referenceId.present ? data.referenceId.value : this.referenceId,
      notes: data.notes.present ? data.notes.value : this.notes,
      unitCost: data.unitCost.present ? data.unitCost.value : this.unitCost,
      totalCost: data.totalCost.present ? data.totalCost.value : this.totalCost,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
      movementDate: data.movementDate.present
          ? data.movementDate.value
          : this.movementDate,
      localId: data.localId.present ? data.localId.value : this.localId,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalInventoryMovement(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('lotId: $lotId, ')
          ..write('branchId: $branchId, ')
          ..write('variantId: $variantId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('unitCost: $unitCost, ')
          ..write('totalCost: $totalCost, ')
          ..write('createdBy: $createdBy, ')
          ..write('movementDate: $movementDate, ')
          ..write('localId: $localId, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      lotId,
      branchId,
      variantId,
      movementType,
      quantity,
      referenceType,
      referenceId,
      notes,
      unitCost,
      totalCost,
      createdBy,
      movementDate,
      localId,
      synced,
      syncedAt,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalInventoryMovement &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.lotId == this.lotId &&
          other.branchId == this.branchId &&
          other.variantId == this.variantId &&
          other.movementType == this.movementType &&
          other.quantity == this.quantity &&
          other.referenceType == this.referenceType &&
          other.referenceId == this.referenceId &&
          other.notes == this.notes &&
          other.unitCost == this.unitCost &&
          other.totalCost == this.totalCost &&
          other.createdBy == this.createdBy &&
          other.movementDate == this.movementDate &&
          other.localId == this.localId &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.createdAt == this.createdAt);
}

class LocalInventoryMovementsCompanion
    extends UpdateCompanion<LocalInventoryMovement> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String?> lotId;
  final Value<String> branchId;
  final Value<String> variantId;
  final Value<MovementType> movementType;
  final Value<int> quantity;
  final Value<String?> referenceType;
  final Value<String?> referenceId;
  final Value<String?> notes;
  final Value<double?> unitCost;
  final Value<double?> totalCost;
  final Value<String?> createdBy;
  final Value<DateTime> movementDate;
  final Value<String> localId;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalInventoryMovementsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.lotId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.quantity = const Value.absent(),
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.movementDate = const Value.absent(),
    this.localId = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalInventoryMovementsCompanion.insert({
    required String id,
    required String tenantId,
    this.lotId = const Value.absent(),
    required String branchId,
    required String variantId,
    required MovementType movementType,
    required int quantity,
    this.referenceType = const Value.absent(),
    this.referenceId = const Value.absent(),
    this.notes = const Value.absent(),
    this.unitCost = const Value.absent(),
    this.totalCost = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.movementDate = const Value.absent(),
    required String localId,
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        variantId = Value(variantId),
        movementType = Value(movementType),
        quantity = Value(quantity),
        localId = Value(localId);
  static Insertable<LocalInventoryMovement> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? lotId,
    Expression<String>? branchId,
    Expression<String>? variantId,
    Expression<String>? movementType,
    Expression<int>? quantity,
    Expression<String>? referenceType,
    Expression<String>? referenceId,
    Expression<String>? notes,
    Expression<double>? unitCost,
    Expression<double>? totalCost,
    Expression<String>? createdBy,
    Expression<DateTime>? movementDate,
    Expression<String>? localId,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (lotId != null) 'lot_id': lotId,
      if (branchId != null) 'branch_id': branchId,
      if (variantId != null) 'variant_id': variantId,
      if (movementType != null) 'movement_type': movementType,
      if (quantity != null) 'quantity': quantity,
      if (referenceType != null) 'reference_type': referenceType,
      if (referenceId != null) 'reference_id': referenceId,
      if (notes != null) 'notes': notes,
      if (unitCost != null) 'unit_cost': unitCost,
      if (totalCost != null) 'total_cost': totalCost,
      if (createdBy != null) 'created_by': createdBy,
      if (movementDate != null) 'movement_date': movementDate,
      if (localId != null) 'local_id': localId,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalInventoryMovementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String?>? lotId,
      Value<String>? branchId,
      Value<String>? variantId,
      Value<MovementType>? movementType,
      Value<int>? quantity,
      Value<String?>? referenceType,
      Value<String?>? referenceId,
      Value<String?>? notes,
      Value<double?>? unitCost,
      Value<double?>? totalCost,
      Value<String?>? createdBy,
      Value<DateTime>? movementDate,
      Value<String>? localId,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LocalInventoryMovementsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      lotId: lotId ?? this.lotId,
      branchId: branchId ?? this.branchId,
      variantId: variantId ?? this.variantId,
      movementType: movementType ?? this.movementType,
      quantity: quantity ?? this.quantity,
      referenceType: referenceType ?? this.referenceType,
      referenceId: referenceId ?? this.referenceId,
      notes: notes ?? this.notes,
      unitCost: unitCost ?? this.unitCost,
      totalCost: totalCost ?? this.totalCost,
      createdBy: createdBy ?? this.createdBy,
      movementDate: movementDate ?? this.movementDate,
      localId: localId ?? this.localId,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
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
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
    }
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>($LocalInventoryMovementsTable
          .$convertermovementType
          .toSql(movementType.value));
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (referenceType.present) {
      map['reference_type'] = Variable<String>(referenceType.value);
    }
    if (referenceId.present) {
      map['reference_id'] = Variable<String>(referenceId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (unitCost.present) {
      map['unit_cost'] = Variable<double>(unitCost.value);
    }
    if (totalCost.present) {
      map['total_cost'] = Variable<double>(totalCost.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
    }
    if (movementDate.present) {
      map['movement_date'] = Variable<DateTime>(movementDate.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
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
    return (StringBuffer('LocalInventoryMovementsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('lotId: $lotId, ')
          ..write('branchId: $branchId, ')
          ..write('variantId: $variantId, ')
          ..write('movementType: $movementType, ')
          ..write('quantity: $quantity, ')
          ..write('referenceType: $referenceType, ')
          ..write('referenceId: $referenceId, ')
          ..write('notes: $notes, ')
          ..write('unitCost: $unitCost, ')
          ..write('totalCost: $totalCost, ')
          ..write('createdBy: $createdBy, ')
          ..write('movementDate: $movementDate, ')
          ..write('localId: $localId, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<CustomerType, String>
      customerType = GeneratedColumn<String>(
              'customer_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CustomerType>(
              $LocalCustomersTable.$convertercustomerType);
  static const VerificationMeta _fullNameMeta =
      const VerificationMeta('fullName');
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
      'full_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tradeNameMeta =
      const VerificationMeta('tradeName');
  @override
  late final GeneratedColumn<String> tradeName = GeneratedColumn<String>(
      'trade_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _taxIdMeta = const VerificationMeta('taxId');
  @override
  late final GeneratedColumn<String> taxId = GeneratedColumn<String>(
      'tax_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _documentTypeMeta =
      const VerificationMeta('documentType');
  @override
  late final GeneratedColumn<String> documentType = GeneratedColumn<String>(
      'document_type', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _documentNumberMeta =
      const VerificationMeta('documentNumber');
  @override
  late final GeneratedColumn<String> documentNumber = GeneratedColumn<String>(
      'document_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneNumberMeta =
      const VerificationMeta('phoneNumber');
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
      'phone_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _whatsappMeta =
      const VerificationMeta('whatsapp');
  @override
  late final GeneratedColumn<String> whatsapp = GeneratedColumn<String>(
      'whatsapp', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _addressMeta =
      const VerificationMeta('address');
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
      'address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
      'city', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deliveryZoneMeta =
      const VerificationMeta('deliveryZone');
  @override
  late final GeneratedColumn<String> deliveryZone = GeneratedColumn<String>(
      'delivery_zone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _creditLimitMeta =
      const VerificationMeta('creditLimit');
  @override
  late final GeneratedColumn<double> creditLimit = GeneratedColumn<double>(
      'credit_limit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _creditDaysMeta =
      const VerificationMeta('creditDays');
  @override
  late final GeneratedColumn<int> creditDays = GeneratedColumn<int>(
      'credit_days', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _currentCreditMeta =
      const VerificationMeta('currentCredit');
  @override
  late final GeneratedColumn<double> currentCredit = GeneratedColumn<double>(
      'current_credit', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _priceListIdMeta =
      const VerificationMeta('priceListId');
  @override
  late final GeneratedColumn<String> priceListId = GeneratedColumn<String>(
      'price_list_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_price_lists (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<CustomerStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('active'))
          .withConverter<CustomerStatus>($LocalCustomersTable.$converterstatus);
  static const VerificationMeta _totalPurchasesMeta =
      const VerificationMeta('totalPurchases');
  @override
  late final GeneratedColumn<double> totalPurchases = GeneratedColumn<double>(
      'total_purchases', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalOrdersMeta =
      const VerificationMeta('totalOrders');
  @override
  late final GeneratedColumn<int> totalOrders = GeneratedColumn<int>(
      'total_orders', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _lastPurchaseDateMeta =
      const VerificationMeta('lastPurchaseDate');
  @override
  late final GeneratedColumn<DateTime> lastPurchaseDate =
      GeneratedColumn<DateTime>('last_purchase_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        code,
        customerType,
        fullName,
        tradeName,
        taxId,
        documentType,
        documentNumber,
        email,
        phoneNumber,
        whatsapp,
        address,
        city,
        deliveryZone,
        creditLimit,
        creditDays,
        currentCredit,
        priceListId,
        status,
        totalPurchases,
        totalOrders,
        lastPurchaseDate,
        notes,
        synced,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_customers';
  @override
  VerificationContext validateIntegrity(Insertable<LocalCustomer> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(_fullNameMeta,
          fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta));
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('trade_name')) {
      context.handle(_tradeNameMeta,
          tradeName.isAcceptableOrUnknown(data['trade_name']!, _tradeNameMeta));
    }
    if (data.containsKey('tax_id')) {
      context.handle(
          _taxIdMeta, taxId.isAcceptableOrUnknown(data['tax_id']!, _taxIdMeta));
    }
    if (data.containsKey('document_type')) {
      context.handle(
          _documentTypeMeta,
          documentType.isAcceptableOrUnknown(
              data['document_type']!, _documentTypeMeta));
    }
    if (data.containsKey('document_number')) {
      context.handle(
          _documentNumberMeta,
          documentNumber.isAcceptableOrUnknown(
              data['document_number']!, _documentNumberMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone_number')) {
      context.handle(
          _phoneNumberMeta,
          phoneNumber.isAcceptableOrUnknown(
              data['phone_number']!, _phoneNumberMeta));
    }
    if (data.containsKey('whatsapp')) {
      context.handle(_whatsappMeta,
          whatsapp.isAcceptableOrUnknown(data['whatsapp']!, _whatsappMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('delivery_zone')) {
      context.handle(
          _deliveryZoneMeta,
          deliveryZone.isAcceptableOrUnknown(
              data['delivery_zone']!, _deliveryZoneMeta));
    }
    if (data.containsKey('credit_limit')) {
      context.handle(
          _creditLimitMeta,
          creditLimit.isAcceptableOrUnknown(
              data['credit_limit']!, _creditLimitMeta));
    }
    if (data.containsKey('credit_days')) {
      context.handle(
          _creditDaysMeta,
          creditDays.isAcceptableOrUnknown(
              data['credit_days']!, _creditDaysMeta));
    }
    if (data.containsKey('current_credit')) {
      context.handle(
          _currentCreditMeta,
          currentCredit.isAcceptableOrUnknown(
              data['current_credit']!, _currentCreditMeta));
    }
    if (data.containsKey('price_list_id')) {
      context.handle(
          _priceListIdMeta,
          priceListId.isAcceptableOrUnknown(
              data['price_list_id']!, _priceListIdMeta));
    }
    if (data.containsKey('total_purchases')) {
      context.handle(
          _totalPurchasesMeta,
          totalPurchases.isAcceptableOrUnknown(
              data['total_purchases']!, _totalPurchasesMeta));
    }
    if (data.containsKey('total_orders')) {
      context.handle(
          _totalOrdersMeta,
          totalOrders.isAcceptableOrUnknown(
              data['total_orders']!, _totalOrdersMeta));
    }
    if (data.containsKey('last_purchase_date')) {
      context.handle(
          _lastPurchaseDateMeta,
          lastPurchaseDate.isAcceptableOrUnknown(
              data['last_purchase_date']!, _lastPurchaseDateMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCustomer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCustomer(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      customerType: $LocalCustomersTable.$convertercustomerType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}customer_type'])!),
      fullName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}full_name'])!,
      tradeName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}trade_name']),
      taxId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tax_id']),
      documentType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document_type']),
      documentNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}document_number']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phoneNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone_number']),
      whatsapp: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}whatsapp']),
      address: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}address']),
      city: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}city']),
      deliveryZone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}delivery_zone']),
      creditLimit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}credit_limit'])!,
      creditDays: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}credit_days'])!,
      currentCredit: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_credit'])!,
      priceListId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}price_list_id']),
      status: $LocalCustomersTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      totalPurchases: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}total_purchases'])!,
      totalOrders: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}total_orders'])!,
      lastPurchaseDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}last_purchase_date']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalCustomersTable createAlias(String alias) {
    return $LocalCustomersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CustomerType, String, String>
      $convertercustomerType =
      const EnumNameConverter<CustomerType>(CustomerType.values);
  static JsonTypeConverter2<CustomerStatus, String, String> $converterstatus =
      const EnumNameConverter<CustomerStatus>(CustomerStatus.values);
}

class LocalCustomer extends DataClass implements Insertable<LocalCustomer> {
  final String id;
  final String tenantId;
  final String code;
  final CustomerType customerType;
  final String fullName;
  final String? tradeName;
  final String? taxId;
  final String? documentType;
  final String? documentNumber;
  final String? email;
  final String? phoneNumber;
  final String? whatsapp;
  final String? address;
  final String? city;
  final String? deliveryZone;
  final double creditLimit;
  final int creditDays;
  final double currentCredit;
  final String? priceListId;
  final CustomerStatus status;
  final double totalPurchases;
  final int totalOrders;
  final DateTime? lastPurchaseDate;
  final String? notes;
  final bool synced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalCustomer(
      {required this.id,
      required this.tenantId,
      required this.code,
      required this.customerType,
      required this.fullName,
      this.tradeName,
      this.taxId,
      this.documentType,
      this.documentNumber,
      this.email,
      this.phoneNumber,
      this.whatsapp,
      this.address,
      this.city,
      this.deliveryZone,
      required this.creditLimit,
      required this.creditDays,
      required this.currentCredit,
      this.priceListId,
      required this.status,
      required this.totalPurchases,
      required this.totalOrders,
      this.lastPurchaseDate,
      this.notes,
      required this.synced,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['code'] = Variable<String>(code);
    {
      map['customer_type'] = Variable<String>(
          $LocalCustomersTable.$convertercustomerType.toSql(customerType));
    }
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || tradeName != null) {
      map['trade_name'] = Variable<String>(tradeName);
    }
    if (!nullToAbsent || taxId != null) {
      map['tax_id'] = Variable<String>(taxId);
    }
    if (!nullToAbsent || documentType != null) {
      map['document_type'] = Variable<String>(documentType);
    }
    if (!nullToAbsent || documentNumber != null) {
      map['document_number'] = Variable<String>(documentNumber);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || whatsapp != null) {
      map['whatsapp'] = Variable<String>(whatsapp);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String>(address);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String>(city);
    }
    if (!nullToAbsent || deliveryZone != null) {
      map['delivery_zone'] = Variable<String>(deliveryZone);
    }
    map['credit_limit'] = Variable<double>(creditLimit);
    map['credit_days'] = Variable<int>(creditDays);
    map['current_credit'] = Variable<double>(currentCredit);
    if (!nullToAbsent || priceListId != null) {
      map['price_list_id'] = Variable<String>(priceListId);
    }
    {
      map['status'] =
          Variable<String>($LocalCustomersTable.$converterstatus.toSql(status));
    }
    map['total_purchases'] = Variable<double>(totalPurchases);
    map['total_orders'] = Variable<int>(totalOrders);
    if (!nullToAbsent || lastPurchaseDate != null) {
      map['last_purchase_date'] = Variable<DateTime>(lastPurchaseDate);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalCustomersCompanion toCompanion(bool nullToAbsent) {
    return LocalCustomersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      code: Value(code),
      customerType: Value(customerType),
      fullName: Value(fullName),
      tradeName: tradeName == null && nullToAbsent
          ? const Value.absent()
          : Value(tradeName),
      taxId:
          taxId == null && nullToAbsent ? const Value.absent() : Value(taxId),
      documentType: documentType == null && nullToAbsent
          ? const Value.absent()
          : Value(documentType),
      documentNumber: documentNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(documentNumber),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      whatsapp: whatsapp == null && nullToAbsent
          ? const Value.absent()
          : Value(whatsapp),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      deliveryZone: deliveryZone == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryZone),
      creditLimit: Value(creditLimit),
      creditDays: Value(creditDays),
      currentCredit: Value(currentCredit),
      priceListId: priceListId == null && nullToAbsent
          ? const Value.absent()
          : Value(priceListId),
      status: Value(status),
      totalPurchases: Value(totalPurchases),
      totalOrders: Value(totalOrders),
      lastPurchaseDate: lastPurchaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastPurchaseDate),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      synced: Value(synced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalCustomer.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCustomer(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      code: serializer.fromJson<String>(json['code']),
      customerType: $LocalCustomersTable.$convertercustomerType
          .fromJson(serializer.fromJson<String>(json['customerType'])),
      fullName: serializer.fromJson<String>(json['fullName']),
      tradeName: serializer.fromJson<String?>(json['tradeName']),
      taxId: serializer.fromJson<String?>(json['taxId']),
      documentType: serializer.fromJson<String?>(json['documentType']),
      documentNumber: serializer.fromJson<String?>(json['documentNumber']),
      email: serializer.fromJson<String?>(json['email']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      whatsapp: serializer.fromJson<String?>(json['whatsapp']),
      address: serializer.fromJson<String?>(json['address']),
      city: serializer.fromJson<String?>(json['city']),
      deliveryZone: serializer.fromJson<String?>(json['deliveryZone']),
      creditLimit: serializer.fromJson<double>(json['creditLimit']),
      creditDays: serializer.fromJson<int>(json['creditDays']),
      currentCredit: serializer.fromJson<double>(json['currentCredit']),
      priceListId: serializer.fromJson<String?>(json['priceListId']),
      status: $LocalCustomersTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      totalPurchases: serializer.fromJson<double>(json['totalPurchases']),
      totalOrders: serializer.fromJson<int>(json['totalOrders']),
      lastPurchaseDate:
          serializer.fromJson<DateTime?>(json['lastPurchaseDate']),
      notes: serializer.fromJson<String?>(json['notes']),
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
      'code': serializer.toJson<String>(code),
      'customerType': serializer.toJson<String>(
          $LocalCustomersTable.$convertercustomerType.toJson(customerType)),
      'fullName': serializer.toJson<String>(fullName),
      'tradeName': serializer.toJson<String?>(tradeName),
      'taxId': serializer.toJson<String?>(taxId),
      'documentType': serializer.toJson<String?>(documentType),
      'documentNumber': serializer.toJson<String?>(documentNumber),
      'email': serializer.toJson<String?>(email),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'whatsapp': serializer.toJson<String?>(whatsapp),
      'address': serializer.toJson<String?>(address),
      'city': serializer.toJson<String?>(city),
      'deliveryZone': serializer.toJson<String?>(deliveryZone),
      'creditLimit': serializer.toJson<double>(creditLimit),
      'creditDays': serializer.toJson<int>(creditDays),
      'currentCredit': serializer.toJson<double>(currentCredit),
      'priceListId': serializer.toJson<String?>(priceListId),
      'status': serializer
          .toJson<String>($LocalCustomersTable.$converterstatus.toJson(status)),
      'totalPurchases': serializer.toJson<double>(totalPurchases),
      'totalOrders': serializer.toJson<int>(totalOrders),
      'lastPurchaseDate': serializer.toJson<DateTime?>(lastPurchaseDate),
      'notes': serializer.toJson<String?>(notes),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalCustomer copyWith(
          {String? id,
          String? tenantId,
          String? code,
          CustomerType? customerType,
          String? fullName,
          Value<String?> tradeName = const Value.absent(),
          Value<String?> taxId = const Value.absent(),
          Value<String?> documentType = const Value.absent(),
          Value<String?> documentNumber = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phoneNumber = const Value.absent(),
          Value<String?> whatsapp = const Value.absent(),
          Value<String?> address = const Value.absent(),
          Value<String?> city = const Value.absent(),
          Value<String?> deliveryZone = const Value.absent(),
          double? creditLimit,
          int? creditDays,
          double? currentCredit,
          Value<String?> priceListId = const Value.absent(),
          CustomerStatus? status,
          double? totalPurchases,
          int? totalOrders,
          Value<DateTime?> lastPurchaseDate = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? synced,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalCustomer(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        code: code ?? this.code,
        customerType: customerType ?? this.customerType,
        fullName: fullName ?? this.fullName,
        tradeName: tradeName.present ? tradeName.value : this.tradeName,
        taxId: taxId.present ? taxId.value : this.taxId,
        documentType:
            documentType.present ? documentType.value : this.documentType,
        documentNumber:
            documentNumber.present ? documentNumber.value : this.documentNumber,
        email: email.present ? email.value : this.email,
        phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
        whatsapp: whatsapp.present ? whatsapp.value : this.whatsapp,
        address: address.present ? address.value : this.address,
        city: city.present ? city.value : this.city,
        deliveryZone:
            deliveryZone.present ? deliveryZone.value : this.deliveryZone,
        creditLimit: creditLimit ?? this.creditLimit,
        creditDays: creditDays ?? this.creditDays,
        currentCredit: currentCredit ?? this.currentCredit,
        priceListId: priceListId.present ? priceListId.value : this.priceListId,
        status: status ?? this.status,
        totalPurchases: totalPurchases ?? this.totalPurchases,
        totalOrders: totalOrders ?? this.totalOrders,
        lastPurchaseDate: lastPurchaseDate.present
            ? lastPurchaseDate.value
            : this.lastPurchaseDate,
        notes: notes.present ? notes.value : this.notes,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalCustomer copyWithCompanion(LocalCustomersCompanion data) {
    return LocalCustomer(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      code: data.code.present ? data.code.value : this.code,
      customerType: data.customerType.present
          ? data.customerType.value
          : this.customerType,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      tradeName: data.tradeName.present ? data.tradeName.value : this.tradeName,
      taxId: data.taxId.present ? data.taxId.value : this.taxId,
      documentType: data.documentType.present
          ? data.documentType.value
          : this.documentType,
      documentNumber: data.documentNumber.present
          ? data.documentNumber.value
          : this.documentNumber,
      email: data.email.present ? data.email.value : this.email,
      phoneNumber:
          data.phoneNumber.present ? data.phoneNumber.value : this.phoneNumber,
      whatsapp: data.whatsapp.present ? data.whatsapp.value : this.whatsapp,
      address: data.address.present ? data.address.value : this.address,
      city: data.city.present ? data.city.value : this.city,
      deliveryZone: data.deliveryZone.present
          ? data.deliveryZone.value
          : this.deliveryZone,
      creditLimit:
          data.creditLimit.present ? data.creditLimit.value : this.creditLimit,
      creditDays:
          data.creditDays.present ? data.creditDays.value : this.creditDays,
      currentCredit: data.currentCredit.present
          ? data.currentCredit.value
          : this.currentCredit,
      priceListId:
          data.priceListId.present ? data.priceListId.value : this.priceListId,
      status: data.status.present ? data.status.value : this.status,
      totalPurchases: data.totalPurchases.present
          ? data.totalPurchases.value
          : this.totalPurchases,
      totalOrders:
          data.totalOrders.present ? data.totalOrders.value : this.totalOrders,
      lastPurchaseDate: data.lastPurchaseDate.present
          ? data.lastPurchaseDate.value
          : this.lastPurchaseDate,
      notes: data.notes.present ? data.notes.value : this.notes,
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
          ..write('code: $code, ')
          ..write('customerType: $customerType, ')
          ..write('fullName: $fullName, ')
          ..write('tradeName: $tradeName, ')
          ..write('taxId: $taxId, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('deliveryZone: $deliveryZone, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('creditDays: $creditDays, ')
          ..write('currentCredit: $currentCredit, ')
          ..write('priceListId: $priceListId, ')
          ..write('status: $status, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('lastPurchaseDate: $lastPurchaseDate, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        tenantId,
        code,
        customerType,
        fullName,
        tradeName,
        taxId,
        documentType,
        documentNumber,
        email,
        phoneNumber,
        whatsapp,
        address,
        city,
        deliveryZone,
        creditLimit,
        creditDays,
        currentCredit,
        priceListId,
        status,
        totalPurchases,
        totalOrders,
        lastPurchaseDate,
        notes,
        synced,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCustomer &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.code == this.code &&
          other.customerType == this.customerType &&
          other.fullName == this.fullName &&
          other.tradeName == this.tradeName &&
          other.taxId == this.taxId &&
          other.documentType == this.documentType &&
          other.documentNumber == this.documentNumber &&
          other.email == this.email &&
          other.phoneNumber == this.phoneNumber &&
          other.whatsapp == this.whatsapp &&
          other.address == this.address &&
          other.city == this.city &&
          other.deliveryZone == this.deliveryZone &&
          other.creditLimit == this.creditLimit &&
          other.creditDays == this.creditDays &&
          other.currentCredit == this.currentCredit &&
          other.priceListId == this.priceListId &&
          other.status == this.status &&
          other.totalPurchases == this.totalPurchases &&
          other.totalOrders == this.totalOrders &&
          other.lastPurchaseDate == this.lastPurchaseDate &&
          other.notes == this.notes &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalCustomersCompanion extends UpdateCompanion<LocalCustomer> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> code;
  final Value<CustomerType> customerType;
  final Value<String> fullName;
  final Value<String?> tradeName;
  final Value<String?> taxId;
  final Value<String?> documentType;
  final Value<String?> documentNumber;
  final Value<String?> email;
  final Value<String?> phoneNumber;
  final Value<String?> whatsapp;
  final Value<String?> address;
  final Value<String?> city;
  final Value<String?> deliveryZone;
  final Value<double> creditLimit;
  final Value<int> creditDays;
  final Value<double> currentCredit;
  final Value<String?> priceListId;
  final Value<CustomerStatus> status;
  final Value<double> totalPurchases;
  final Value<int> totalOrders;
  final Value<DateTime?> lastPurchaseDate;
  final Value<String?> notes;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalCustomersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.code = const Value.absent(),
    this.customerType = const Value.absent(),
    this.fullName = const Value.absent(),
    this.tradeName = const Value.absent(),
    this.taxId = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.deliveryZone = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.creditDays = const Value.absent(),
    this.currentCredit = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.status = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.lastPurchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCustomersCompanion.insert({
    required String id,
    required String tenantId,
    required String code,
    required CustomerType customerType,
    required String fullName,
    this.tradeName = const Value.absent(),
    this.taxId = const Value.absent(),
    this.documentType = const Value.absent(),
    this.documentNumber = const Value.absent(),
    this.email = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.whatsapp = const Value.absent(),
    this.address = const Value.absent(),
    this.city = const Value.absent(),
    this.deliveryZone = const Value.absent(),
    this.creditLimit = const Value.absent(),
    this.creditDays = const Value.absent(),
    this.currentCredit = const Value.absent(),
    this.priceListId = const Value.absent(),
    this.status = const Value.absent(),
    this.totalPurchases = const Value.absent(),
    this.totalOrders = const Value.absent(),
    this.lastPurchaseDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        code = Value(code),
        customerType = Value(customerType),
        fullName = Value(fullName);
  static Insertable<LocalCustomer> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? code,
    Expression<String>? customerType,
    Expression<String>? fullName,
    Expression<String>? tradeName,
    Expression<String>? taxId,
    Expression<String>? documentType,
    Expression<String>? documentNumber,
    Expression<String>? email,
    Expression<String>? phoneNumber,
    Expression<String>? whatsapp,
    Expression<String>? address,
    Expression<String>? city,
    Expression<String>? deliveryZone,
    Expression<double>? creditLimit,
    Expression<int>? creditDays,
    Expression<double>? currentCredit,
    Expression<String>? priceListId,
    Expression<String>? status,
    Expression<double>? totalPurchases,
    Expression<int>? totalOrders,
    Expression<DateTime>? lastPurchaseDate,
    Expression<String>? notes,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (code != null) 'code': code,
      if (customerType != null) 'customer_type': customerType,
      if (fullName != null) 'full_name': fullName,
      if (tradeName != null) 'trade_name': tradeName,
      if (taxId != null) 'tax_id': taxId,
      if (documentType != null) 'document_type': documentType,
      if (documentNumber != null) 'document_number': documentNumber,
      if (email != null) 'email': email,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (whatsapp != null) 'whatsapp': whatsapp,
      if (address != null) 'address': address,
      if (city != null) 'city': city,
      if (deliveryZone != null) 'delivery_zone': deliveryZone,
      if (creditLimit != null) 'credit_limit': creditLimit,
      if (creditDays != null) 'credit_days': creditDays,
      if (currentCredit != null) 'current_credit': currentCredit,
      if (priceListId != null) 'price_list_id': priceListId,
      if (status != null) 'status': status,
      if (totalPurchases != null) 'total_purchases': totalPurchases,
      if (totalOrders != null) 'total_orders': totalOrders,
      if (lastPurchaseDate != null) 'last_purchase_date': lastPurchaseDate,
      if (notes != null) 'notes': notes,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCustomersCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? code,
      Value<CustomerType>? customerType,
      Value<String>? fullName,
      Value<String?>? tradeName,
      Value<String?>? taxId,
      Value<String?>? documentType,
      Value<String?>? documentNumber,
      Value<String?>? email,
      Value<String?>? phoneNumber,
      Value<String?>? whatsapp,
      Value<String?>? address,
      Value<String?>? city,
      Value<String?>? deliveryZone,
      Value<double>? creditLimit,
      Value<int>? creditDays,
      Value<double>? currentCredit,
      Value<String?>? priceListId,
      Value<CustomerStatus>? status,
      Value<double>? totalPurchases,
      Value<int>? totalOrders,
      Value<DateTime?>? lastPurchaseDate,
      Value<String?>? notes,
      Value<bool>? synced,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalCustomersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      code: code ?? this.code,
      customerType: customerType ?? this.customerType,
      fullName: fullName ?? this.fullName,
      tradeName: tradeName ?? this.tradeName,
      taxId: taxId ?? this.taxId,
      documentType: documentType ?? this.documentType,
      documentNumber: documentNumber ?? this.documentNumber,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      whatsapp: whatsapp ?? this.whatsapp,
      address: address ?? this.address,
      city: city ?? this.city,
      deliveryZone: deliveryZone ?? this.deliveryZone,
      creditLimit: creditLimit ?? this.creditLimit,
      creditDays: creditDays ?? this.creditDays,
      currentCredit: currentCredit ?? this.currentCredit,
      priceListId: priceListId ?? this.priceListId,
      status: status ?? this.status,
      totalPurchases: totalPurchases ?? this.totalPurchases,
      totalOrders: totalOrders ?? this.totalOrders,
      lastPurchaseDate: lastPurchaseDate ?? this.lastPurchaseDate,
      notes: notes ?? this.notes,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (customerType.present) {
      map['customer_type'] = Variable<String>($LocalCustomersTable
          .$convertercustomerType
          .toSql(customerType.value));
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (tradeName.present) {
      map['trade_name'] = Variable<String>(tradeName.value);
    }
    if (taxId.present) {
      map['tax_id'] = Variable<String>(taxId.value);
    }
    if (documentType.present) {
      map['document_type'] = Variable<String>(documentType.value);
    }
    if (documentNumber.present) {
      map['document_number'] = Variable<String>(documentNumber.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (whatsapp.present) {
      map['whatsapp'] = Variable<String>(whatsapp.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (deliveryZone.present) {
      map['delivery_zone'] = Variable<String>(deliveryZone.value);
    }
    if (creditLimit.present) {
      map['credit_limit'] = Variable<double>(creditLimit.value);
    }
    if (creditDays.present) {
      map['credit_days'] = Variable<int>(creditDays.value);
    }
    if (currentCredit.present) {
      map['current_credit'] = Variable<double>(currentCredit.value);
    }
    if (priceListId.present) {
      map['price_list_id'] = Variable<String>(priceListId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $LocalCustomersTable.$converterstatus.toSql(status.value));
    }
    if (totalPurchases.present) {
      map['total_purchases'] = Variable<double>(totalPurchases.value);
    }
    if (totalOrders.present) {
      map['total_orders'] = Variable<int>(totalOrders.value);
    }
    if (lastPurchaseDate.present) {
      map['last_purchase_date'] = Variable<DateTime>(lastPurchaseDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
          ..write('code: $code, ')
          ..write('customerType: $customerType, ')
          ..write('fullName: $fullName, ')
          ..write('tradeName: $tradeName, ')
          ..write('taxId: $taxId, ')
          ..write('documentType: $documentType, ')
          ..write('documentNumber: $documentNumber, ')
          ..write('email: $email, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('whatsapp: $whatsapp, ')
          ..write('address: $address, ')
          ..write('city: $city, ')
          ..write('deliveryZone: $deliveryZone, ')
          ..write('creditLimit: $creditLimit, ')
          ..write('creditDays: $creditDays, ')
          ..write('currentCredit: $currentCredit, ')
          ..write('priceListId: $priceListId, ')
          ..write('status: $status, ')
          ..write('totalPurchases: $totalPurchases, ')
          ..write('totalOrders: $totalOrders, ')
          ..write('lastPurchaseDate: $lastPurchaseDate, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalSalesTable extends LocalSales
    with TableInfo<$LocalSalesTable, LocalSale> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSalesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _saleNumberMeta =
      const VerificationMeta('saleNumber');
  @override
  late final GeneratedColumn<String> saleNumber = GeneratedColumn<String>(
      'sale_number', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_customers (id)'));
  static const VerificationMeta _saleDateMeta =
      const VerificationMeta('saleDate');
  @override
  late final GeneratedColumn<DateTime> saleDate = GeneratedColumn<DateTime>(
      'sale_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  late final GeneratedColumnWithTypeConverter<SaleType, String> saleType =
      GeneratedColumn<String>('sale_type', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('retail'))
          .withConverter<SaleType>($LocalSalesTable.$convertersaleType);
  @override
  late final GeneratedColumnWithTypeConverter<SaleStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('completed'))
          .withConverter<SaleStatus>($LocalSalesTable.$converterstatus);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _discountPercentMeta =
      const VerificationMeta('discountPercent');
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
      'discount_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _discountAmountMeta =
      const VerificationMeta('discountAmount');
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
      'discount_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _taxAmountMeta =
      const VerificationMeta('taxAmount');
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
      'tax_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _cashierIdMeta =
      const VerificationMeta('cashierId');
  @override
  late final GeneratedColumn<String> cashierId = GeneratedColumn<String>(
      'cashier_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _internalNotesMeta =
      const VerificationMeta('internalNotes');
  @override
  late final GeneratedColumn<String> internalNotes = GeneratedColumn<String>(
      'internal_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        saleNumber,
        customerId,
        saleDate,
        saleType,
        status,
        subtotal,
        discountPercent,
        discountAmount,
        taxAmount,
        totalAmount,
        cashierId,
        notes,
        internalNotes,
        localId,
        synced,
        syncedAt,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sales';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSale> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('sale_number')) {
      context.handle(
          _saleNumberMeta,
          saleNumber.isAcceptableOrUnknown(
              data['sale_number']!, _saleNumberMeta));
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    }
    if (data.containsKey('sale_date')) {
      context.handle(_saleDateMeta,
          saleDate.isAcceptableOrUnknown(data['sale_date']!, _saleDateMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
          _discountPercentMeta,
          discountPercent.isAcceptableOrUnknown(
              data['discount_percent']!, _discountPercentMeta));
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discountAmountMeta,
          discountAmount.isAcceptableOrUnknown(
              data['discount_amount']!, _discountAmountMeta));
    }
    if (data.containsKey('tax_amount')) {
      context.handle(_taxAmountMeta,
          taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('cashier_id')) {
      context.handle(_cashierIdMeta,
          cashierId.isAcceptableOrUnknown(data['cashier_id']!, _cashierIdMeta));
    } else if (isInserting) {
      context.missing(_cashierIdMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('internal_notes')) {
      context.handle(
          _internalNotesMeta,
          internalNotes.isAcceptableOrUnknown(
              data['internal_notes']!, _internalNotesMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSale map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSale(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      saleNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_number']),
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id']),
      saleDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}sale_date'])!,
      saleType: $LocalSalesTable.$convertersaleType.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_type'])!),
      status: $LocalSalesTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      discountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_percent'])!,
      discountAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_amount'])!,
      taxAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_amount'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      cashierId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cashier_id'])!,
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      internalNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}internal_notes']),
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
    );
  }

  @override
  $LocalSalesTable createAlias(String alias) {
    return $LocalSalesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<SaleType, String, String> $convertersaleType =
      const EnumNameConverter<SaleType>(SaleType.values);
  static JsonTypeConverter2<SaleStatus, String, String> $converterstatus =
      const EnumNameConverter<SaleStatus>(SaleStatus.values);
}

class LocalSale extends DataClass implements Insertable<LocalSale> {
  final String id;
  final String tenantId;
  final String branchId;
  final String? saleNumber;
  final String? customerId;
  final DateTime saleDate;
  final SaleType saleType;
  final SaleStatus status;
  final double subtotal;
  final double discountPercent;
  final double discountAmount;
  final double taxAmount;
  final double totalAmount;
  final String cashierId;
  final String? notes;
  final String? internalNotes;
  final String localId;
  final bool synced;
  final DateTime? syncedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalSale(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      this.saleNumber,
      this.customerId,
      required this.saleDate,
      required this.saleType,
      required this.status,
      required this.subtotal,
      required this.discountPercent,
      required this.discountAmount,
      required this.taxAmount,
      required this.totalAmount,
      required this.cashierId,
      this.notes,
      this.internalNotes,
      required this.localId,
      required this.synced,
      this.syncedAt,
      required this.createdAt,
      required this.updatedAt});
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
    map['sale_date'] = Variable<DateTime>(saleDate);
    {
      map['sale_type'] =
          Variable<String>($LocalSalesTable.$convertersaleType.toSql(saleType));
    }
    {
      map['status'] =
          Variable<String>($LocalSalesTable.$converterstatus.toSql(status));
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['discount_percent'] = Variable<double>(discountPercent);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    map['cashier_id'] = Variable<String>(cashierId);
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || internalNotes != null) {
      map['internal_notes'] = Variable<String>(internalNotes);
    }
    map['local_id'] = Variable<String>(localId);
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
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
      saleDate: Value(saleDate),
      saleType: Value(saleType),
      status: Value(status),
      subtotal: Value(subtotal),
      discountPercent: Value(discountPercent),
      discountAmount: Value(discountAmount),
      taxAmount: Value(taxAmount),
      totalAmount: Value(totalAmount),
      cashierId: Value(cashierId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      internalNotes: internalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(internalNotes),
      localId: Value(localId),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalSale.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSale(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      saleNumber: serializer.fromJson<String?>(json['saleNumber']),
      customerId: serializer.fromJson<String?>(json['customerId']),
      saleDate: serializer.fromJson<DateTime>(json['saleDate']),
      saleType: $LocalSalesTable.$convertersaleType
          .fromJson(serializer.fromJson<String>(json['saleType'])),
      status: $LocalSalesTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      cashierId: serializer.fromJson<String>(json['cashierId']),
      notes: serializer.fromJson<String?>(json['notes']),
      internalNotes: serializer.fromJson<String?>(json['internalNotes']),
      localId: serializer.fromJson<String>(json['localId']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
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
      'saleDate': serializer.toJson<DateTime>(saleDate),
      'saleType': serializer
          .toJson<String>($LocalSalesTable.$convertersaleType.toJson(saleType)),
      'status': serializer
          .toJson<String>($LocalSalesTable.$converterstatus.toJson(status)),
      'subtotal': serializer.toJson<double>(subtotal),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'cashierId': serializer.toJson<String>(cashierId),
      'notes': serializer.toJson<String?>(notes),
      'internalNotes': serializer.toJson<String?>(internalNotes),
      'localId': serializer.toJson<String>(localId),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalSale copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          Value<String?> saleNumber = const Value.absent(),
          Value<String?> customerId = const Value.absent(),
          DateTime? saleDate,
          SaleType? saleType,
          SaleStatus? status,
          double? subtotal,
          double? discountPercent,
          double? discountAmount,
          double? taxAmount,
          double? totalAmount,
          String? cashierId,
          Value<String?> notes = const Value.absent(),
          Value<String?> internalNotes = const Value.absent(),
          String? localId,
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalSale(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        saleNumber: saleNumber.present ? saleNumber.value : this.saleNumber,
        customerId: customerId.present ? customerId.value : this.customerId,
        saleDate: saleDate ?? this.saleDate,
        saleType: saleType ?? this.saleType,
        status: status ?? this.status,
        subtotal: subtotal ?? this.subtotal,
        discountPercent: discountPercent ?? this.discountPercent,
        discountAmount: discountAmount ?? this.discountAmount,
        taxAmount: taxAmount ?? this.taxAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        cashierId: cashierId ?? this.cashierId,
        notes: notes.present ? notes.value : this.notes,
        internalNotes:
            internalNotes.present ? internalNotes.value : this.internalNotes,
        localId: localId ?? this.localId,
        synced: synced ?? this.synced,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalSale copyWithCompanion(LocalSalesCompanion data) {
    return LocalSale(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      saleNumber:
          data.saleNumber.present ? data.saleNumber.value : this.saleNumber,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      saleDate: data.saleDate.present ? data.saleDate.value : this.saleDate,
      saleType: data.saleType.present ? data.saleType.value : this.saleType,
      status: data.status.present ? data.status.value : this.status,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      cashierId: data.cashierId.present ? data.cashierId.value : this.cashierId,
      notes: data.notes.present ? data.notes.value : this.notes,
      internalNotes: data.internalNotes.present
          ? data.internalNotes.value
          : this.internalNotes,
      localId: data.localId.present ? data.localId.value : this.localId,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
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
          ..write('saleDate: $saleDate, ')
          ..write('saleType: $saleType, ')
          ..write('status: $status, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('cashierId: $cashierId, ')
          ..write('notes: $notes, ')
          ..write('internalNotes: $internalNotes, ')
          ..write('localId: $localId, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        tenantId,
        branchId,
        saleNumber,
        customerId,
        saleDate,
        saleType,
        status,
        subtotal,
        discountPercent,
        discountAmount,
        taxAmount,
        totalAmount,
        cashierId,
        notes,
        internalNotes,
        localId,
        synced,
        syncedAt,
        createdAt,
        updatedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSale &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.saleNumber == this.saleNumber &&
          other.customerId == this.customerId &&
          other.saleDate == this.saleDate &&
          other.saleType == this.saleType &&
          other.status == this.status &&
          other.subtotal == this.subtotal &&
          other.discountPercent == this.discountPercent &&
          other.discountAmount == this.discountAmount &&
          other.taxAmount == this.taxAmount &&
          other.totalAmount == this.totalAmount &&
          other.cashierId == this.cashierId &&
          other.notes == this.notes &&
          other.internalNotes == this.internalNotes &&
          other.localId == this.localId &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalSalesCompanion extends UpdateCompanion<LocalSale> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String?> saleNumber;
  final Value<String?> customerId;
  final Value<DateTime> saleDate;
  final Value<SaleType> saleType;
  final Value<SaleStatus> status;
  final Value<double> subtotal;
  final Value<double> discountPercent;
  final Value<double> discountAmount;
  final Value<double> taxAmount;
  final Value<double> totalAmount;
  final Value<String> cashierId;
  final Value<String?> notes;
  final Value<String?> internalNotes;
  final Value<String> localId;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalSalesCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.saleNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.saleDate = const Value.absent(),
    this.saleType = const Value.absent(),
    this.status = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.cashierId = const Value.absent(),
    this.notes = const Value.absent(),
    this.internalNotes = const Value.absent(),
    this.localId = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
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
    this.saleDate = const Value.absent(),
    this.saleType = const Value.absent(),
    this.status = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    required String cashierId,
    this.notes = const Value.absent(),
    this.internalNotes = const Value.absent(),
    required String localId,
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
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
    Expression<DateTime>? saleDate,
    Expression<String>? saleType,
    Expression<String>? status,
    Expression<double>? subtotal,
    Expression<double>? discountPercent,
    Expression<double>? discountAmount,
    Expression<double>? taxAmount,
    Expression<double>? totalAmount,
    Expression<String>? cashierId,
    Expression<String>? notes,
    Expression<String>? internalNotes,
    Expression<String>? localId,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
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
      if (saleDate != null) 'sale_date': saleDate,
      if (saleType != null) 'sale_type': saleType,
      if (status != null) 'status': status,
      if (subtotal != null) 'subtotal': subtotal,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (cashierId != null) 'cashier_id': cashierId,
      if (notes != null) 'notes': notes,
      if (internalNotes != null) 'internal_notes': internalNotes,
      if (localId != null) 'local_id': localId,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSalesCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String?>? saleNumber,
      Value<String?>? customerId,
      Value<DateTime>? saleDate,
      Value<SaleType>? saleType,
      Value<SaleStatus>? status,
      Value<double>? subtotal,
      Value<double>? discountPercent,
      Value<double>? discountAmount,
      Value<double>? taxAmount,
      Value<double>? totalAmount,
      Value<String>? cashierId,
      Value<String?>? notes,
      Value<String?>? internalNotes,
      Value<String>? localId,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalSalesCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      saleNumber: saleNumber ?? this.saleNumber,
      customerId: customerId ?? this.customerId,
      saleDate: saleDate ?? this.saleDate,
      saleType: saleType ?? this.saleType,
      status: status ?? this.status,
      subtotal: subtotal ?? this.subtotal,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      cashierId: cashierId ?? this.cashierId,
      notes: notes ?? this.notes,
      internalNotes: internalNotes ?? this.internalNotes,
      localId: localId ?? this.localId,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
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
    if (saleDate.present) {
      map['sale_date'] = Variable<DateTime>(saleDate.value);
    }
    if (saleType.present) {
      map['sale_type'] = Variable<String>(
          $LocalSalesTable.$convertersaleType.toSql(saleType.value));
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $LocalSalesTable.$converterstatus.toSql(status.value));
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (discountPercent.present) {
      map['discount_percent'] = Variable<double>(discountPercent.value);
    }
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (cashierId.present) {
      map['cashier_id'] = Variable<String>(cashierId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (internalNotes.present) {
      map['internal_notes'] = Variable<String>(internalNotes.value);
    }
    if (localId.present) {
      map['local_id'] = Variable<String>(localId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
    }
    if (syncedAt.present) {
      map['synced_at'] = Variable<DateTime>(syncedAt.value);
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
          ..write('saleDate: $saleDate, ')
          ..write('saleType: $saleType, ')
          ..write('status: $status, ')
          ..write('subtotal: $subtotal, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('cashierId: $cashierId, ')
          ..write('notes: $notes, ')
          ..write('internalNotes: $internalNotes, ')
          ..write('localId: $localId, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES local_sales (id)'));
  static const VerificationMeta _lotIdMeta = const VerificationMeta('lotId');
  @override
  late final GeneratedColumn<String> lotId = GeneratedColumn<String>(
      'lot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_product_variants (id)'));
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _costPriceMeta =
      const VerificationMeta('costPrice');
  @override
  late final GeneratedColumn<double> costPrice = GeneratedColumn<double>(
      'cost_price', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _discountPercentMeta =
      const VerificationMeta('discountPercent');
  @override
  late final GeneratedColumn<double> discountPercent = GeneratedColumn<double>(
      'discount_percent', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _discountAmountMeta =
      const VerificationMeta('discountAmount');
  @override
  late final GeneratedColumn<double> discountAmount = GeneratedColumn<double>(
      'discount_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        saleId,
        lotId,
        variantId,
        quantity,
        unitPrice,
        costPrice,
        discountPercent,
        discountAmount,
        subtotal,
        synced,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSaleItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('lot_id')) {
      context.handle(
          _lotIdMeta, lotId.isAcceptableOrUnknown(data['lot_id']!, _lotIdMeta));
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('cost_price')) {
      context.handle(_costPriceMeta,
          costPrice.isAcceptableOrUnknown(data['cost_price']!, _costPriceMeta));
    }
    if (data.containsKey('discount_percent')) {
      context.handle(
          _discountPercentMeta,
          discountPercent.isAcceptableOrUnknown(
              data['discount_percent']!, _discountPercentMeta));
    }
    if (data.containsKey('discount_amount')) {
      context.handle(
          _discountAmountMeta,
          discountAmount.isAcceptableOrUnknown(
              data['discount_amount']!, _discountAmountMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSaleItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSaleItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id']),
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      lotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}lot_id']),
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      costPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}cost_price']),
      discountPercent: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_percent'])!,
      discountAmount: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}discount_amount'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LocalSaleItemsTable createAlias(String alias) {
    return $LocalSaleItemsTable(attachedDatabase, alias);
  }
}

class LocalSaleItem extends DataClass implements Insertable<LocalSaleItem> {
  final String id;
  final String? tenantId;
  final String saleId;
  final String? lotId;
  final String variantId;
  final int quantity;
  final double unitPrice;
  final double? costPrice;
  final double discountPercent;
  final double discountAmount;
  final double subtotal;
  final bool synced;
  final DateTime createdAt;
  const LocalSaleItem(
      {required this.id,
      this.tenantId,
      required this.saleId,
      this.lotId,
      required this.variantId,
      required this.quantity,
      required this.unitPrice,
      this.costPrice,
      required this.discountPercent,
      required this.discountAmount,
      required this.subtotal,
      required this.synced,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || tenantId != null) {
      map['tenant_id'] = Variable<String>(tenantId);
    }
    map['sale_id'] = Variable<String>(saleId);
    if (!nullToAbsent || lotId != null) {
      map['lot_id'] = Variable<String>(lotId);
    }
    map['variant_id'] = Variable<String>(variantId);
    map['quantity'] = Variable<int>(quantity);
    map['unit_price'] = Variable<double>(unitPrice);
    if (!nullToAbsent || costPrice != null) {
      map['cost_price'] = Variable<double>(costPrice);
    }
    map['discount_percent'] = Variable<double>(discountPercent);
    map['discount_amount'] = Variable<double>(discountAmount);
    map['subtotal'] = Variable<double>(subtotal);
    map['synced'] = Variable<bool>(synced);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalSaleItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalSaleItemsCompanion(
      id: Value(id),
      tenantId: tenantId == null && nullToAbsent
          ? const Value.absent()
          : Value(tenantId),
      saleId: Value(saleId),
      lotId:
          lotId == null && nullToAbsent ? const Value.absent() : Value(lotId),
      variantId: Value(variantId),
      quantity: Value(quantity),
      unitPrice: Value(unitPrice),
      costPrice: costPrice == null && nullToAbsent
          ? const Value.absent()
          : Value(costPrice),
      discountPercent: Value(discountPercent),
      discountAmount: Value(discountAmount),
      subtotal: Value(subtotal),
      synced: Value(synced),
      createdAt: Value(createdAt),
    );
  }

  factory LocalSaleItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSaleItem(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String?>(json['tenantId']),
      saleId: serializer.fromJson<String>(json['saleId']),
      lotId: serializer.fromJson<String?>(json['lotId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      costPrice: serializer.fromJson<double?>(json['costPrice']),
      discountPercent: serializer.fromJson<double>(json['discountPercent']),
      discountAmount: serializer.fromJson<double>(json['discountAmount']),
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
      'tenantId': serializer.toJson<String?>(tenantId),
      'saleId': serializer.toJson<String>(saleId),
      'lotId': serializer.toJson<String?>(lotId),
      'variantId': serializer.toJson<String>(variantId),
      'quantity': serializer.toJson<int>(quantity),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'costPrice': serializer.toJson<double?>(costPrice),
      'discountPercent': serializer.toJson<double>(discountPercent),
      'discountAmount': serializer.toJson<double>(discountAmount),
      'subtotal': serializer.toJson<double>(subtotal),
      'synced': serializer.toJson<bool>(synced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalSaleItem copyWith(
          {String? id,
          Value<String?> tenantId = const Value.absent(),
          String? saleId,
          Value<String?> lotId = const Value.absent(),
          String? variantId,
          int? quantity,
          double? unitPrice,
          Value<double?> costPrice = const Value.absent(),
          double? discountPercent,
          double? discountAmount,
          double? subtotal,
          bool? synced,
          DateTime? createdAt}) =>
      LocalSaleItem(
        id: id ?? this.id,
        tenantId: tenantId.present ? tenantId.value : this.tenantId,
        saleId: saleId ?? this.saleId,
        lotId: lotId.present ? lotId.value : this.lotId,
        variantId: variantId ?? this.variantId,
        quantity: quantity ?? this.quantity,
        unitPrice: unitPrice ?? this.unitPrice,
        costPrice: costPrice.present ? costPrice.value : this.costPrice,
        discountPercent: discountPercent ?? this.discountPercent,
        discountAmount: discountAmount ?? this.discountAmount,
        subtotal: subtotal ?? this.subtotal,
        synced: synced ?? this.synced,
        createdAt: createdAt ?? this.createdAt,
      );
  LocalSaleItem copyWithCompanion(LocalSaleItemsCompanion data) {
    return LocalSaleItem(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      lotId: data.lotId.present ? data.lotId.value : this.lotId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      costPrice: data.costPrice.present ? data.costPrice.value : this.costPrice,
      discountPercent: data.discountPercent.present
          ? data.discountPercent.value
          : this.discountPercent,
      discountAmount: data.discountAmount.present
          ? data.discountAmount.value
          : this.discountAmount,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      synced: data.synced.present ? data.synced.value : this.synced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalSaleItem(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('saleId: $saleId, ')
          ..write('lotId: $lotId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('subtotal: $subtotal, ')
          ..write('synced: $synced, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      saleId,
      lotId,
      variantId,
      quantity,
      unitPrice,
      costPrice,
      discountPercent,
      discountAmount,
      subtotal,
      synced,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSaleItem &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.saleId == this.saleId &&
          other.lotId == this.lotId &&
          other.variantId == this.variantId &&
          other.quantity == this.quantity &&
          other.unitPrice == this.unitPrice &&
          other.costPrice == this.costPrice &&
          other.discountPercent == this.discountPercent &&
          other.discountAmount == this.discountAmount &&
          other.subtotal == this.subtotal &&
          other.synced == this.synced &&
          other.createdAt == this.createdAt);
}

class LocalSaleItemsCompanion extends UpdateCompanion<LocalSaleItem> {
  final Value<String> id;
  final Value<String?> tenantId;
  final Value<String> saleId;
  final Value<String?> lotId;
  final Value<String> variantId;
  final Value<int> quantity;
  final Value<double> unitPrice;
  final Value<double?> costPrice;
  final Value<double> discountPercent;
  final Value<double> discountAmount;
  final Value<double> subtotal;
  final Value<bool> synced;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalSaleItemsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.lotId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.costPrice = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSaleItemsCompanion.insert({
    required String id,
    this.tenantId = const Value.absent(),
    required String saleId,
    this.lotId = const Value.absent(),
    required String variantId,
    required int quantity,
    required double unitPrice,
    this.costPrice = const Value.absent(),
    this.discountPercent = const Value.absent(),
    this.discountAmount = const Value.absent(),
    required double subtotal,
    this.synced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        saleId = Value(saleId),
        variantId = Value(variantId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        subtotal = Value(subtotal);
  static Insertable<LocalSaleItem> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? saleId,
    Expression<String>? lotId,
    Expression<String>? variantId,
    Expression<int>? quantity,
    Expression<double>? unitPrice,
    Expression<double>? costPrice,
    Expression<double>? discountPercent,
    Expression<double>? discountAmount,
    Expression<double>? subtotal,
    Expression<bool>? synced,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (saleId != null) 'sale_id': saleId,
      if (lotId != null) 'lot_id': lotId,
      if (variantId != null) 'variant_id': variantId,
      if (quantity != null) 'quantity': quantity,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (costPrice != null) 'cost_price': costPrice,
      if (discountPercent != null) 'discount_percent': discountPercent,
      if (discountAmount != null) 'discount_amount': discountAmount,
      if (subtotal != null) 'subtotal': subtotal,
      if (synced != null) 'synced': synced,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSaleItemsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? tenantId,
      Value<String>? saleId,
      Value<String?>? lotId,
      Value<String>? variantId,
      Value<int>? quantity,
      Value<double>? unitPrice,
      Value<double?>? costPrice,
      Value<double>? discountPercent,
      Value<double>? discountAmount,
      Value<double>? subtotal,
      Value<bool>? synced,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LocalSaleItemsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      saleId: saleId ?? this.saleId,
      lotId: lotId ?? this.lotId,
      variantId: variantId ?? this.variantId,
      quantity: quantity ?? this.quantity,
      unitPrice: unitPrice ?? this.unitPrice,
      costPrice: costPrice ?? this.costPrice,
      discountPercent: discountPercent ?? this.discountPercent,
      discountAmount: discountAmount ?? this.discountAmount,
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
    if (tenantId.present) {
      map['tenant_id'] = Variable<String>(tenantId.value);
    }
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (lotId.present) {
      map['lot_id'] = Variable<String>(lotId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
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
    if (discountAmount.present) {
      map['discount_amount'] = Variable<double>(discountAmount.value);
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
          ..write('tenantId: $tenantId, ')
          ..write('saleId: $saleId, ')
          ..write('lotId: $lotId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('costPrice: $costPrice, ')
          ..write('discountPercent: $discountPercent, ')
          ..write('discountAmount: $discountAmount, ')
          ..write('subtotal: $subtotal, ')
          ..write('synced: $synced, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _saleIdMeta = const VerificationMeta('saleId');
  @override
  late final GeneratedColumn<String> saleId = GeneratedColumn<String>(
      'sale_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES local_sales (id)'));
  @override
  late final GeneratedColumnWithTypeConverter<PaymentMethod, String>
      paymentMethod = GeneratedColumn<String>(
              'payment_method', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<PaymentMethod>(
              $LocalSalePaymentsTable.$converterpaymentMethod);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _cardLastFourMeta =
      const VerificationMeta('cardLastFour');
  @override
  late final GeneratedColumn<String> cardLastFour = GeneratedColumn<String>(
      'card_last_four', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        saleId,
        paymentMethod,
        amount,
        reference,
        cardLastFour,
        synced,
        syncedAt,
        localId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_sale_payments';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSalePayment> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    }
    if (data.containsKey('sale_id')) {
      context.handle(_saleIdMeta,
          saleId.isAcceptableOrUnknown(data['sale_id']!, _saleIdMeta));
    } else if (isInserting) {
      context.missing(_saleIdMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('card_last_four')) {
      context.handle(
          _cardLastFourMeta,
          cardLastFour.isAcceptableOrUnknown(
              data['card_last_four']!, _cardLastFourMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalSalePayment map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalSalePayment(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id']),
      saleId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sale_id'])!,
      paymentMethod: $LocalSalePaymentsTable.$converterpaymentMethod.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}payment_method'])!),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      cardLastFour: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}card_last_four']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LocalSalePaymentsTable createAlias(String alias) {
    return $LocalSalePaymentsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<PaymentMethod, String, String>
      $converterpaymentMethod =
      const EnumNameConverter<PaymentMethod>(PaymentMethod.values);
}

class LocalSalePayment extends DataClass
    implements Insertable<LocalSalePayment> {
  final String id;
  final String? tenantId;
  final String saleId;
  final PaymentMethod paymentMethod;
  final double amount;
  final String? reference;
  final String? cardLastFour;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  const LocalSalePayment(
      {required this.id,
      this.tenantId,
      required this.saleId,
      required this.paymentMethod,
      required this.amount,
      this.reference,
      this.cardLastFour,
      required this.synced,
      this.syncedAt,
      required this.localId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || tenantId != null) {
      map['tenant_id'] = Variable<String>(tenantId);
    }
    map['sale_id'] = Variable<String>(saleId);
    {
      map['payment_method'] = Variable<String>(
          $LocalSalePaymentsTable.$converterpaymentMethod.toSql(paymentMethod));
    }
    map['amount'] = Variable<double>(amount);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || cardLastFour != null) {
      map['card_last_four'] = Variable<String>(cardLastFour);
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
      tenantId: tenantId == null && nullToAbsent
          ? const Value.absent()
          : Value(tenantId),
      saleId: Value(saleId),
      paymentMethod: Value(paymentMethod),
      amount: Value(amount),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      cardLastFour: cardLastFour == null && nullToAbsent
          ? const Value.absent()
          : Value(cardLastFour),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
    );
  }

  factory LocalSalePayment.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSalePayment(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String?>(json['tenantId']),
      saleId: serializer.fromJson<String>(json['saleId']),
      paymentMethod: $LocalSalePaymentsTable.$converterpaymentMethod
          .fromJson(serializer.fromJson<String>(json['paymentMethod'])),
      amount: serializer.fromJson<double>(json['amount']),
      reference: serializer.fromJson<String?>(json['reference']),
      cardLastFour: serializer.fromJson<String?>(json['cardLastFour']),
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
      'tenantId': serializer.toJson<String?>(tenantId),
      'saleId': serializer.toJson<String>(saleId),
      'paymentMethod': serializer.toJson<String>($LocalSalePaymentsTable
          .$converterpaymentMethod
          .toJson(paymentMethod)),
      'amount': serializer.toJson<double>(amount),
      'reference': serializer.toJson<String?>(reference),
      'cardLastFour': serializer.toJson<String?>(cardLastFour),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalSalePayment copyWith(
          {String? id,
          Value<String?> tenantId = const Value.absent(),
          String? saleId,
          PaymentMethod? paymentMethod,
          double? amount,
          Value<String?> reference = const Value.absent(),
          Value<String?> cardLastFour = const Value.absent(),
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          String? localId,
          DateTime? createdAt}) =>
      LocalSalePayment(
        id: id ?? this.id,
        tenantId: tenantId.present ? tenantId.value : this.tenantId,
        saleId: saleId ?? this.saleId,
        paymentMethod: paymentMethod ?? this.paymentMethod,
        amount: amount ?? this.amount,
        reference: reference.present ? reference.value : this.reference,
        cardLastFour:
            cardLastFour.present ? cardLastFour.value : this.cardLastFour,
        synced: synced ?? this.synced,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        localId: localId ?? this.localId,
        createdAt: createdAt ?? this.createdAt,
      );
  LocalSalePayment copyWithCompanion(LocalSalePaymentsCompanion data) {
    return LocalSalePayment(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      saleId: data.saleId.present ? data.saleId.value : this.saleId,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      amount: data.amount.present ? data.amount.value : this.amount,
      reference: data.reference.present ? data.reference.value : this.reference,
      cardLastFour: data.cardLastFour.present
          ? data.cardLastFour.value
          : this.cardLastFour,
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
          ..write('tenantId: $tenantId, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('cardLastFour: $cardLastFour, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, saleId, paymentMethod, amount,
      reference, cardLastFour, synced, syncedAt, localId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSalePayment &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.saleId == this.saleId &&
          other.paymentMethod == this.paymentMethod &&
          other.amount == this.amount &&
          other.reference == this.reference &&
          other.cardLastFour == this.cardLastFour &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt);
}

class LocalSalePaymentsCompanion extends UpdateCompanion<LocalSalePayment> {
  final Value<String> id;
  final Value<String?> tenantId;
  final Value<String> saleId;
  final Value<PaymentMethod> paymentMethod;
  final Value<double> amount;
  final Value<String?> reference;
  final Value<String?> cardLastFour;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalSalePaymentsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.saleId = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.amount = const Value.absent(),
    this.reference = const Value.absent(),
    this.cardLastFour = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalSalePaymentsCompanion.insert({
    required String id,
    this.tenantId = const Value.absent(),
    required String saleId,
    required PaymentMethod paymentMethod,
    required double amount,
    this.reference = const Value.absent(),
    this.cardLastFour = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        saleId = Value(saleId),
        paymentMethod = Value(paymentMethod),
        amount = Value(amount),
        localId = Value(localId);
  static Insertable<LocalSalePayment> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? saleId,
    Expression<String>? paymentMethod,
    Expression<double>? amount,
    Expression<String>? reference,
    Expression<String>? cardLastFour,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (saleId != null) 'sale_id': saleId,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (amount != null) 'amount': amount,
      if (reference != null) 'reference': reference,
      if (cardLastFour != null) 'card_last_four': cardLastFour,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalSalePaymentsCompanion copyWith(
      {Value<String>? id,
      Value<String?>? tenantId,
      Value<String>? saleId,
      Value<PaymentMethod>? paymentMethod,
      Value<double>? amount,
      Value<String?>? reference,
      Value<String?>? cardLastFour,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<String>? localId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LocalSalePaymentsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      saleId: saleId ?? this.saleId,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      amount: amount ?? this.amount,
      reference: reference ?? this.reference,
      cardLastFour: cardLastFour ?? this.cardLastFour,
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
    if (saleId.present) {
      map['sale_id'] = Variable<String>(saleId.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>($LocalSalePaymentsTable
          .$converterpaymentMethod
          .toSql(paymentMethod.value));
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (cardLastFour.present) {
      map['card_last_four'] = Variable<String>(cardLastFour.value);
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
          ..write('tenantId: $tenantId, ')
          ..write('saleId: $saleId, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('amount: $amount, ')
          ..write('reference: $reference, ')
          ..write('cardLastFour: $cardLastFour, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalOrdersTable extends LocalOrders
    with TableInfo<$LocalOrdersTable, LocalOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderNumberMeta =
      const VerificationMeta('orderNumber');
  @override
  late final GeneratedColumn<String> orderNumber = GeneratedColumn<String>(
      'order_number', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _customerIdMeta =
      const VerificationMeta('customerId');
  @override
  late final GeneratedColumn<String> customerId = GeneratedColumn<String>(
      'customer_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_customers (id)'));
  static const VerificationMeta _orderDateMeta =
      const VerificationMeta('orderDate');
  @override
  late final GeneratedColumn<DateTime> orderDate = GeneratedColumn<DateTime>(
      'order_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _requestedDeliveryDateMeta =
      const VerificationMeta('requestedDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> requestedDeliveryDate =
      GeneratedColumn<DateTime>('requested_delivery_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _actualDeliveryDateMeta =
      const VerificationMeta('actualDeliveryDate');
  @override
  late final GeneratedColumn<DateTime> actualDeliveryDate =
      GeneratedColumn<DateTime>('actual_delivery_date', aliasedName, true,
          type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<OrderStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('requested'))
          .withConverter<OrderStatus>($LocalOrdersTable.$converterstatus);
  static const VerificationMeta _deliveryAddressMeta =
      const VerificationMeta('deliveryAddress');
  @override
  late final GeneratedColumn<String> deliveryAddress = GeneratedColumn<String>(
      'delivery_address', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deliveryNotesMeta =
      const VerificationMeta('deliveryNotes');
  @override
  late final GeneratedColumn<String> deliveryNotes = GeneratedColumn<String>(
      'delivery_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _deliveryZoneMeta =
      const VerificationMeta('deliveryZone');
  @override
  late final GeneratedColumn<String> deliveryZone = GeneratedColumn<String>(
      'delivery_zone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _shippingCostMeta =
      const VerificationMeta('shippingCost');
  @override
  late final GeneratedColumn<double> shippingCost = GeneratedColumn<double>(
      'shipping_cost', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _taxAmountMeta =
      const VerificationMeta('taxAmount');
  @override
  late final GeneratedColumn<double> taxAmount = GeneratedColumn<double>(
      'tax_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _totalAmountMeta =
      const VerificationMeta('totalAmount');
  @override
  late final GeneratedColumn<double> totalAmount = GeneratedColumn<double>(
      'total_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  @override
  late final GeneratedColumnWithTypeConverter<PaymentStatus, String>
      paymentStatus = GeneratedColumn<String>(
              'payment_status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('pending'))
          .withConverter<PaymentStatus>(
              $LocalOrdersTable.$converterpaymentStatus);
  static const VerificationMeta _amountPaidMeta =
      const VerificationMeta('amountPaid');
  @override
  late final GeneratedColumn<double> amountPaid = GeneratedColumn<double>(
      'amount_paid', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _salesRepIdMeta =
      const VerificationMeta('salesRepId');
  @override
  late final GeneratedColumn<String> salesRepId = GeneratedColumn<String>(
      'sales_rep_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _deletedAtMeta =
      const VerificationMeta('deletedAt');
  @override
  late final GeneratedColumn<DateTime> deletedAt = GeneratedColumn<DateTime>(
      'deleted_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        orderNumber,
        customerId,
        orderDate,
        requestedDeliveryDate,
        actualDeliveryDate,
        status,
        deliveryAddress,
        deliveryNotes,
        deliveryZone,
        subtotal,
        shippingCost,
        taxAmount,
        totalAmount,
        paymentStatus,
        amountPaid,
        salesRepId,
        notes,
        synced,
        syncedAt,
        localId,
        createdAt,
        updatedAt,
        deletedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_orders';
  @override
  VerificationContext validateIntegrity(Insertable<LocalOrder> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('order_number')) {
      context.handle(
          _orderNumberMeta,
          orderNumber.isAcceptableOrUnknown(
              data['order_number']!, _orderNumberMeta));
    } else if (isInserting) {
      context.missing(_orderNumberMeta);
    }
    if (data.containsKey('customer_id')) {
      context.handle(
          _customerIdMeta,
          customerId.isAcceptableOrUnknown(
              data['customer_id']!, _customerIdMeta));
    } else if (isInserting) {
      context.missing(_customerIdMeta);
    }
    if (data.containsKey('order_date')) {
      context.handle(_orderDateMeta,
          orderDate.isAcceptableOrUnknown(data['order_date']!, _orderDateMeta));
    }
    if (data.containsKey('requested_delivery_date')) {
      context.handle(
          _requestedDeliveryDateMeta,
          requestedDeliveryDate.isAcceptableOrUnknown(
              data['requested_delivery_date']!, _requestedDeliveryDateMeta));
    }
    if (data.containsKey('actual_delivery_date')) {
      context.handle(
          _actualDeliveryDateMeta,
          actualDeliveryDate.isAcceptableOrUnknown(
              data['actual_delivery_date']!, _actualDeliveryDateMeta));
    }
    if (data.containsKey('delivery_address')) {
      context.handle(
          _deliveryAddressMeta,
          deliveryAddress.isAcceptableOrUnknown(
              data['delivery_address']!, _deliveryAddressMeta));
    }
    if (data.containsKey('delivery_notes')) {
      context.handle(
          _deliveryNotesMeta,
          deliveryNotes.isAcceptableOrUnknown(
              data['delivery_notes']!, _deliveryNotesMeta));
    }
    if (data.containsKey('delivery_zone')) {
      context.handle(
          _deliveryZoneMeta,
          deliveryZone.isAcceptableOrUnknown(
              data['delivery_zone']!, _deliveryZoneMeta));
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    }
    if (data.containsKey('shipping_cost')) {
      context.handle(
          _shippingCostMeta,
          shippingCost.isAcceptableOrUnknown(
              data['shipping_cost']!, _shippingCostMeta));
    }
    if (data.containsKey('tax_amount')) {
      context.handle(_taxAmountMeta,
          taxAmount.isAcceptableOrUnknown(data['tax_amount']!, _taxAmountMeta));
    }
    if (data.containsKey('total_amount')) {
      context.handle(
          _totalAmountMeta,
          totalAmount.isAcceptableOrUnknown(
              data['total_amount']!, _totalAmountMeta));
    }
    if (data.containsKey('amount_paid')) {
      context.handle(
          _amountPaidMeta,
          amountPaid.isAcceptableOrUnknown(
              data['amount_paid']!, _amountPaidMeta));
    }
    if (data.containsKey('sales_rep_id')) {
      context.handle(
          _salesRepIdMeta,
          salesRepId.isAcceptableOrUnknown(
              data['sales_rep_id']!, _salesRepIdMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    if (data.containsKey('deleted_at')) {
      context.handle(_deletedAtMeta,
          deletedAt.isAcceptableOrUnknown(data['deleted_at']!, _deletedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalOrder(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      orderNumber: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_number'])!,
      customerId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}customer_id'])!,
      orderDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}order_date'])!,
      requestedDeliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}requested_delivery_date']),
      actualDeliveryDate: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime,
          data['${effectivePrefix}actual_delivery_date']),
      status: $LocalOrdersTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      deliveryAddress: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}delivery_address']),
      deliveryNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}delivery_notes']),
      deliveryZone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}delivery_zone']),
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      shippingCost: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}shipping_cost'])!,
      taxAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}tax_amount'])!,
      totalAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}total_amount'])!,
      paymentStatus: $LocalOrdersTable.$converterpaymentStatus.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}payment_status'])!),
      amountPaid: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount_paid'])!,
      salesRepId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sales_rep_id']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
      deletedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}deleted_at']),
    );
  }

  @override
  $LocalOrdersTable createAlias(String alias) {
    return $LocalOrdersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<OrderStatus, String, String> $converterstatus =
      const EnumNameConverter<OrderStatus>(OrderStatus.values);
  static JsonTypeConverter2<PaymentStatus, String, String>
      $converterpaymentStatus =
      const EnumNameConverter<PaymentStatus>(PaymentStatus.values);
}

class LocalOrder extends DataClass implements Insertable<LocalOrder> {
  final String id;
  final String tenantId;
  final String branchId;
  final String orderNumber;
  final String customerId;
  final DateTime orderDate;
  final DateTime? requestedDeliveryDate;
  final DateTime? actualDeliveryDate;
  final OrderStatus status;
  final String? deliveryAddress;
  final String? deliveryNotes;
  final String? deliveryZone;
  final double subtotal;
  final double shippingCost;
  final double taxAmount;
  final double totalAmount;
  final PaymentStatus paymentStatus;
  final double amountPaid;
  final String? salesRepId;
  final String? notes;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  const LocalOrder(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.orderNumber,
      required this.customerId,
      required this.orderDate,
      this.requestedDeliveryDate,
      this.actualDeliveryDate,
      required this.status,
      this.deliveryAddress,
      this.deliveryNotes,
      this.deliveryZone,
      required this.subtotal,
      required this.shippingCost,
      required this.taxAmount,
      required this.totalAmount,
      required this.paymentStatus,
      required this.amountPaid,
      this.salesRepId,
      this.notes,
      required this.synced,
      this.syncedAt,
      required this.localId,
      required this.createdAt,
      required this.updatedAt,
      this.deletedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['order_number'] = Variable<String>(orderNumber);
    map['customer_id'] = Variable<String>(customerId);
    map['order_date'] = Variable<DateTime>(orderDate);
    if (!nullToAbsent || requestedDeliveryDate != null) {
      map['requested_delivery_date'] =
          Variable<DateTime>(requestedDeliveryDate);
    }
    if (!nullToAbsent || actualDeliveryDate != null) {
      map['actual_delivery_date'] = Variable<DateTime>(actualDeliveryDate);
    }
    {
      map['status'] =
          Variable<String>($LocalOrdersTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || deliveryAddress != null) {
      map['delivery_address'] = Variable<String>(deliveryAddress);
    }
    if (!nullToAbsent || deliveryNotes != null) {
      map['delivery_notes'] = Variable<String>(deliveryNotes);
    }
    if (!nullToAbsent || deliveryZone != null) {
      map['delivery_zone'] = Variable<String>(deliveryZone);
    }
    map['subtotal'] = Variable<double>(subtotal);
    map['shipping_cost'] = Variable<double>(shippingCost);
    map['tax_amount'] = Variable<double>(taxAmount);
    map['total_amount'] = Variable<double>(totalAmount);
    {
      map['payment_status'] = Variable<String>(
          $LocalOrdersTable.$converterpaymentStatus.toSql(paymentStatus));
    }
    map['amount_paid'] = Variable<double>(amountPaid);
    if (!nullToAbsent || salesRepId != null) {
      map['sales_rep_id'] = Variable<String>(salesRepId);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || deletedAt != null) {
      map['deleted_at'] = Variable<DateTime>(deletedAt);
    }
    return map;
  }

  LocalOrdersCompanion toCompanion(bool nullToAbsent) {
    return LocalOrdersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      orderNumber: Value(orderNumber),
      customerId: Value(customerId),
      orderDate: Value(orderDate),
      requestedDeliveryDate: requestedDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(requestedDeliveryDate),
      actualDeliveryDate: actualDeliveryDate == null && nullToAbsent
          ? const Value.absent()
          : Value(actualDeliveryDate),
      status: Value(status),
      deliveryAddress: deliveryAddress == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryAddress),
      deliveryNotes: deliveryNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryNotes),
      deliveryZone: deliveryZone == null && nullToAbsent
          ? const Value.absent()
          : Value(deliveryZone),
      subtotal: Value(subtotal),
      shippingCost: Value(shippingCost),
      taxAmount: Value(taxAmount),
      totalAmount: Value(totalAmount),
      paymentStatus: Value(paymentStatus),
      amountPaid: Value(amountPaid),
      salesRepId: salesRepId == null && nullToAbsent
          ? const Value.absent()
          : Value(salesRepId),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      deletedAt: deletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(deletedAt),
    );
  }

  factory LocalOrder.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalOrder(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      orderNumber: serializer.fromJson<String>(json['orderNumber']),
      customerId: serializer.fromJson<String>(json['customerId']),
      orderDate: serializer.fromJson<DateTime>(json['orderDate']),
      requestedDeliveryDate:
          serializer.fromJson<DateTime?>(json['requestedDeliveryDate']),
      actualDeliveryDate:
          serializer.fromJson<DateTime?>(json['actualDeliveryDate']),
      status: $LocalOrdersTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      deliveryAddress: serializer.fromJson<String?>(json['deliveryAddress']),
      deliveryNotes: serializer.fromJson<String?>(json['deliveryNotes']),
      deliveryZone: serializer.fromJson<String?>(json['deliveryZone']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      shippingCost: serializer.fromJson<double>(json['shippingCost']),
      taxAmount: serializer.fromJson<double>(json['taxAmount']),
      totalAmount: serializer.fromJson<double>(json['totalAmount']),
      paymentStatus: $LocalOrdersTable.$converterpaymentStatus
          .fromJson(serializer.fromJson<String>(json['paymentStatus'])),
      amountPaid: serializer.fromJson<double>(json['amountPaid']),
      salesRepId: serializer.fromJson<String?>(json['salesRepId']),
      notes: serializer.fromJson<String?>(json['notes']),
      synced: serializer.fromJson<bool>(json['synced']),
      syncedAt: serializer.fromJson<DateTime?>(json['syncedAt']),
      localId: serializer.fromJson<String>(json['localId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      deletedAt: serializer.fromJson<DateTime?>(json['deletedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'tenantId': serializer.toJson<String>(tenantId),
      'branchId': serializer.toJson<String>(branchId),
      'orderNumber': serializer.toJson<String>(orderNumber),
      'customerId': serializer.toJson<String>(customerId),
      'orderDate': serializer.toJson<DateTime>(orderDate),
      'requestedDeliveryDate':
          serializer.toJson<DateTime?>(requestedDeliveryDate),
      'actualDeliveryDate': serializer.toJson<DateTime?>(actualDeliveryDate),
      'status': serializer
          .toJson<String>($LocalOrdersTable.$converterstatus.toJson(status)),
      'deliveryAddress': serializer.toJson<String?>(deliveryAddress),
      'deliveryNotes': serializer.toJson<String?>(deliveryNotes),
      'deliveryZone': serializer.toJson<String?>(deliveryZone),
      'subtotal': serializer.toJson<double>(subtotal),
      'shippingCost': serializer.toJson<double>(shippingCost),
      'taxAmount': serializer.toJson<double>(taxAmount),
      'totalAmount': serializer.toJson<double>(totalAmount),
      'paymentStatus': serializer.toJson<String>(
          $LocalOrdersTable.$converterpaymentStatus.toJson(paymentStatus)),
      'amountPaid': serializer.toJson<double>(amountPaid),
      'salesRepId': serializer.toJson<String?>(salesRepId),
      'notes': serializer.toJson<String?>(notes),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'deletedAt': serializer.toJson<DateTime?>(deletedAt),
    };
  }

  LocalOrder copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? orderNumber,
          String? customerId,
          DateTime? orderDate,
          Value<DateTime?> requestedDeliveryDate = const Value.absent(),
          Value<DateTime?> actualDeliveryDate = const Value.absent(),
          OrderStatus? status,
          Value<String?> deliveryAddress = const Value.absent(),
          Value<String?> deliveryNotes = const Value.absent(),
          Value<String?> deliveryZone = const Value.absent(),
          double? subtotal,
          double? shippingCost,
          double? taxAmount,
          double? totalAmount,
          PaymentStatus? paymentStatus,
          double? amountPaid,
          Value<String?> salesRepId = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          String? localId,
          DateTime? createdAt,
          DateTime? updatedAt,
          Value<DateTime?> deletedAt = const Value.absent()}) =>
      LocalOrder(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        orderNumber: orderNumber ?? this.orderNumber,
        customerId: customerId ?? this.customerId,
        orderDate: orderDate ?? this.orderDate,
        requestedDeliveryDate: requestedDeliveryDate.present
            ? requestedDeliveryDate.value
            : this.requestedDeliveryDate,
        actualDeliveryDate: actualDeliveryDate.present
            ? actualDeliveryDate.value
            : this.actualDeliveryDate,
        status: status ?? this.status,
        deliveryAddress: deliveryAddress.present
            ? deliveryAddress.value
            : this.deliveryAddress,
        deliveryNotes:
            deliveryNotes.present ? deliveryNotes.value : this.deliveryNotes,
        deliveryZone:
            deliveryZone.present ? deliveryZone.value : this.deliveryZone,
        subtotal: subtotal ?? this.subtotal,
        shippingCost: shippingCost ?? this.shippingCost,
        taxAmount: taxAmount ?? this.taxAmount,
        totalAmount: totalAmount ?? this.totalAmount,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        amountPaid: amountPaid ?? this.amountPaid,
        salesRepId: salesRepId.present ? salesRepId.value : this.salesRepId,
        notes: notes.present ? notes.value : this.notes,
        synced: synced ?? this.synced,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        localId: localId ?? this.localId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt.present ? deletedAt.value : this.deletedAt,
      );
  LocalOrder copyWithCompanion(LocalOrdersCompanion data) {
    return LocalOrder(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      orderNumber:
          data.orderNumber.present ? data.orderNumber.value : this.orderNumber,
      customerId:
          data.customerId.present ? data.customerId.value : this.customerId,
      orderDate: data.orderDate.present ? data.orderDate.value : this.orderDate,
      requestedDeliveryDate: data.requestedDeliveryDate.present
          ? data.requestedDeliveryDate.value
          : this.requestedDeliveryDate,
      actualDeliveryDate: data.actualDeliveryDate.present
          ? data.actualDeliveryDate.value
          : this.actualDeliveryDate,
      status: data.status.present ? data.status.value : this.status,
      deliveryAddress: data.deliveryAddress.present
          ? data.deliveryAddress.value
          : this.deliveryAddress,
      deliveryNotes: data.deliveryNotes.present
          ? data.deliveryNotes.value
          : this.deliveryNotes,
      deliveryZone: data.deliveryZone.present
          ? data.deliveryZone.value
          : this.deliveryZone,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      shippingCost: data.shippingCost.present
          ? data.shippingCost.value
          : this.shippingCost,
      taxAmount: data.taxAmount.present ? data.taxAmount.value : this.taxAmount,
      totalAmount:
          data.totalAmount.present ? data.totalAmount.value : this.totalAmount,
      paymentStatus: data.paymentStatus.present
          ? data.paymentStatus.value
          : this.paymentStatus,
      amountPaid:
          data.amountPaid.present ? data.amountPaid.value : this.amountPaid,
      salesRepId:
          data.salesRepId.present ? data.salesRepId.value : this.salesRepId,
      notes: data.notes.present ? data.notes.value : this.notes,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      deletedAt: data.deletedAt.present ? data.deletedAt.value : this.deletedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalOrder(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('customerId: $customerId, ')
          ..write('orderDate: $orderDate, ')
          ..write('requestedDeliveryDate: $requestedDeliveryDate, ')
          ..write('actualDeliveryDate: $actualDeliveryDate, ')
          ..write('status: $status, ')
          ..write('deliveryAddress: $deliveryAddress, ')
          ..write('deliveryNotes: $deliveryNotes, ')
          ..write('deliveryZone: $deliveryZone, ')
          ..write('subtotal: $subtotal, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('salesRepId: $salesRepId, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
        id,
        tenantId,
        branchId,
        orderNumber,
        customerId,
        orderDate,
        requestedDeliveryDate,
        actualDeliveryDate,
        status,
        deliveryAddress,
        deliveryNotes,
        deliveryZone,
        subtotal,
        shippingCost,
        taxAmount,
        totalAmount,
        paymentStatus,
        amountPaid,
        salesRepId,
        notes,
        synced,
        syncedAt,
        localId,
        createdAt,
        updatedAt,
        deletedAt
      ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalOrder &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.orderNumber == this.orderNumber &&
          other.customerId == this.customerId &&
          other.orderDate == this.orderDate &&
          other.requestedDeliveryDate == this.requestedDeliveryDate &&
          other.actualDeliveryDate == this.actualDeliveryDate &&
          other.status == this.status &&
          other.deliveryAddress == this.deliveryAddress &&
          other.deliveryNotes == this.deliveryNotes &&
          other.deliveryZone == this.deliveryZone &&
          other.subtotal == this.subtotal &&
          other.shippingCost == this.shippingCost &&
          other.taxAmount == this.taxAmount &&
          other.totalAmount == this.totalAmount &&
          other.paymentStatus == this.paymentStatus &&
          other.amountPaid == this.amountPaid &&
          other.salesRepId == this.salesRepId &&
          other.notes == this.notes &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.deletedAt == this.deletedAt);
}

class LocalOrdersCompanion extends UpdateCompanion<LocalOrder> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> orderNumber;
  final Value<String> customerId;
  final Value<DateTime> orderDate;
  final Value<DateTime?> requestedDeliveryDate;
  final Value<DateTime?> actualDeliveryDate;
  final Value<OrderStatus> status;
  final Value<String?> deliveryAddress;
  final Value<String?> deliveryNotes;
  final Value<String?> deliveryZone;
  final Value<double> subtotal;
  final Value<double> shippingCost;
  final Value<double> taxAmount;
  final Value<double> totalAmount;
  final Value<PaymentStatus> paymentStatus;
  final Value<double> amountPaid;
  final Value<String?> salesRepId;
  final Value<String?> notes;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> deletedAt;
  final Value<int> rowid;
  const LocalOrdersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.orderNumber = const Value.absent(),
    this.customerId = const Value.absent(),
    this.orderDate = const Value.absent(),
    this.requestedDeliveryDate = const Value.absent(),
    this.actualDeliveryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.deliveryAddress = const Value.absent(),
    this.deliveryNotes = const Value.absent(),
    this.deliveryZone = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.salesRepId = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalOrdersCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String orderNumber,
    required String customerId,
    this.orderDate = const Value.absent(),
    this.requestedDeliveryDate = const Value.absent(),
    this.actualDeliveryDate = const Value.absent(),
    this.status = const Value.absent(),
    this.deliveryAddress = const Value.absent(),
    this.deliveryNotes = const Value.absent(),
    this.deliveryZone = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.shippingCost = const Value.absent(),
    this.taxAmount = const Value.absent(),
    this.totalAmount = const Value.absent(),
    this.paymentStatus = const Value.absent(),
    this.amountPaid = const Value.absent(),
    this.salesRepId = const Value.absent(),
    this.notes = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.deletedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        branchId = Value(branchId),
        orderNumber = Value(orderNumber),
        customerId = Value(customerId),
        localId = Value(localId);
  static Insertable<LocalOrder> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? branchId,
    Expression<String>? orderNumber,
    Expression<String>? customerId,
    Expression<DateTime>? orderDate,
    Expression<DateTime>? requestedDeliveryDate,
    Expression<DateTime>? actualDeliveryDate,
    Expression<String>? status,
    Expression<String>? deliveryAddress,
    Expression<String>? deliveryNotes,
    Expression<String>? deliveryZone,
    Expression<double>? subtotal,
    Expression<double>? shippingCost,
    Expression<double>? taxAmount,
    Expression<double>? totalAmount,
    Expression<String>? paymentStatus,
    Expression<double>? amountPaid,
    Expression<String>? salesRepId,
    Expression<String>? notes,
    Expression<bool>? synced,
    Expression<DateTime>? syncedAt,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? deletedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (orderNumber != null) 'order_number': orderNumber,
      if (customerId != null) 'customer_id': customerId,
      if (orderDate != null) 'order_date': orderDate,
      if (requestedDeliveryDate != null)
        'requested_delivery_date': requestedDeliveryDate,
      if (actualDeliveryDate != null)
        'actual_delivery_date': actualDeliveryDate,
      if (status != null) 'status': status,
      if (deliveryAddress != null) 'delivery_address': deliveryAddress,
      if (deliveryNotes != null) 'delivery_notes': deliveryNotes,
      if (deliveryZone != null) 'delivery_zone': deliveryZone,
      if (subtotal != null) 'subtotal': subtotal,
      if (shippingCost != null) 'shipping_cost': shippingCost,
      if (taxAmount != null) 'tax_amount': taxAmount,
      if (totalAmount != null) 'total_amount': totalAmount,
      if (paymentStatus != null) 'payment_status': paymentStatus,
      if (amountPaid != null) 'amount_paid': amountPaid,
      if (salesRepId != null) 'sales_rep_id': salesRepId,
      if (notes != null) 'notes': notes,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (deletedAt != null) 'deleted_at': deletedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalOrdersCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? orderNumber,
      Value<String>? customerId,
      Value<DateTime>? orderDate,
      Value<DateTime?>? requestedDeliveryDate,
      Value<DateTime?>? actualDeliveryDate,
      Value<OrderStatus>? status,
      Value<String?>? deliveryAddress,
      Value<String?>? deliveryNotes,
      Value<String?>? deliveryZone,
      Value<double>? subtotal,
      Value<double>? shippingCost,
      Value<double>? taxAmount,
      Value<double>? totalAmount,
      Value<PaymentStatus>? paymentStatus,
      Value<double>? amountPaid,
      Value<String?>? salesRepId,
      Value<String?>? notes,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<String>? localId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<DateTime?>? deletedAt,
      Value<int>? rowid}) {
    return LocalOrdersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      orderNumber: orderNumber ?? this.orderNumber,
      customerId: customerId ?? this.customerId,
      orderDate: orderDate ?? this.orderDate,
      requestedDeliveryDate:
          requestedDeliveryDate ?? this.requestedDeliveryDate,
      actualDeliveryDate: actualDeliveryDate ?? this.actualDeliveryDate,
      status: status ?? this.status,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      deliveryNotes: deliveryNotes ?? this.deliveryNotes,
      deliveryZone: deliveryZone ?? this.deliveryZone,
      subtotal: subtotal ?? this.subtotal,
      shippingCost: shippingCost ?? this.shippingCost,
      taxAmount: taxAmount ?? this.taxAmount,
      totalAmount: totalAmount ?? this.totalAmount,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      amountPaid: amountPaid ?? this.amountPaid,
      salesRepId: salesRepId ?? this.salesRepId,
      notes: notes ?? this.notes,
      synced: synced ?? this.synced,
      syncedAt: syncedAt ?? this.syncedAt,
      localId: localId ?? this.localId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
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
    if (orderNumber.present) {
      map['order_number'] = Variable<String>(orderNumber.value);
    }
    if (customerId.present) {
      map['customer_id'] = Variable<String>(customerId.value);
    }
    if (orderDate.present) {
      map['order_date'] = Variable<DateTime>(orderDate.value);
    }
    if (requestedDeliveryDate.present) {
      map['requested_delivery_date'] =
          Variable<DateTime>(requestedDeliveryDate.value);
    }
    if (actualDeliveryDate.present) {
      map['actual_delivery_date'] =
          Variable<DateTime>(actualDeliveryDate.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $LocalOrdersTable.$converterstatus.toSql(status.value));
    }
    if (deliveryAddress.present) {
      map['delivery_address'] = Variable<String>(deliveryAddress.value);
    }
    if (deliveryNotes.present) {
      map['delivery_notes'] = Variable<String>(deliveryNotes.value);
    }
    if (deliveryZone.present) {
      map['delivery_zone'] = Variable<String>(deliveryZone.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (shippingCost.present) {
      map['shipping_cost'] = Variable<double>(shippingCost.value);
    }
    if (taxAmount.present) {
      map['tax_amount'] = Variable<double>(taxAmount.value);
    }
    if (totalAmount.present) {
      map['total_amount'] = Variable<double>(totalAmount.value);
    }
    if (paymentStatus.present) {
      map['payment_status'] = Variable<String>(
          $LocalOrdersTable.$converterpaymentStatus.toSql(paymentStatus.value));
    }
    if (amountPaid.present) {
      map['amount_paid'] = Variable<double>(amountPaid.value);
    }
    if (salesRepId.present) {
      map['sales_rep_id'] = Variable<String>(salesRepId.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
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
    if (deletedAt.present) {
      map['deleted_at'] = Variable<DateTime>(deletedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalOrdersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('orderNumber: $orderNumber, ')
          ..write('customerId: $customerId, ')
          ..write('orderDate: $orderDate, ')
          ..write('requestedDeliveryDate: $requestedDeliveryDate, ')
          ..write('actualDeliveryDate: $actualDeliveryDate, ')
          ..write('status: $status, ')
          ..write('deliveryAddress: $deliveryAddress, ')
          ..write('deliveryNotes: $deliveryNotes, ')
          ..write('deliveryZone: $deliveryZone, ')
          ..write('subtotal: $subtotal, ')
          ..write('shippingCost: $shippingCost, ')
          ..write('taxAmount: $taxAmount, ')
          ..write('totalAmount: $totalAmount, ')
          ..write('paymentStatus: $paymentStatus, ')
          ..write('amountPaid: $amountPaid, ')
          ..write('salesRepId: $salesRepId, ')
          ..write('notes: $notes, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('deletedAt: $deletedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LocalOrderItemsTable extends LocalOrderItems
    with TableInfo<$LocalOrderItemsTable, LocalOrderItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalOrderItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _orderIdMeta =
      const VerificationMeta('orderId');
  @override
  late final GeneratedColumn<String> orderId = GeneratedColumn<String>(
      'order_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES local_orders (id)'));
  static const VerificationMeta _variantIdMeta =
      const VerificationMeta('variantId');
  @override
  late final GeneratedColumn<String> variantId = GeneratedColumn<String>(
      'variant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<int> quantity = GeneratedColumn<int>(
      'quantity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _quantityDeliveredMeta =
      const VerificationMeta('quantityDelivered');
  @override
  late final GeneratedColumn<int> quantityDelivered = GeneratedColumn<int>(
      'quantity_delivered', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _unitPriceMeta =
      const VerificationMeta('unitPrice');
  @override
  late final GeneratedColumn<double> unitPrice = GeneratedColumn<double>(
      'unit_price', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _subtotalMeta =
      const VerificationMeta('subtotal');
  @override
  late final GeneratedColumn<double> subtotal = GeneratedColumn<double>(
      'subtotal', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _reservedLotIdMeta =
      const VerificationMeta('reservedLotId');
  @override
  late final GeneratedColumn<String> reservedLotId = GeneratedColumn<String>(
      'reserved_lot_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        orderId,
        variantId,
        quantity,
        quantityDelivered,
        unitPrice,
        subtotal,
        reservedLotId,
        synced,
        localId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_order_items';
  @override
  VerificationContext validateIntegrity(Insertable<LocalOrderItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('order_id')) {
      context.handle(_orderIdMeta,
          orderId.isAcceptableOrUnknown(data['order_id']!, _orderIdMeta));
    } else if (isInserting) {
      context.missing(_orderIdMeta);
    }
    if (data.containsKey('variant_id')) {
      context.handle(_variantIdMeta,
          variantId.isAcceptableOrUnknown(data['variant_id']!, _variantIdMeta));
    } else if (isInserting) {
      context.missing(_variantIdMeta);
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('quantity_delivered')) {
      context.handle(
          _quantityDeliveredMeta,
          quantityDelivered.isAcceptableOrUnknown(
              data['quantity_delivered']!, _quantityDeliveredMeta));
    }
    if (data.containsKey('unit_price')) {
      context.handle(_unitPriceMeta,
          unitPrice.isAcceptableOrUnknown(data['unit_price']!, _unitPriceMeta));
    } else if (isInserting) {
      context.missing(_unitPriceMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(_subtotalMeta,
          subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta));
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('reserved_lot_id')) {
      context.handle(
          _reservedLotIdMeta,
          reservedLotId.isAcceptableOrUnknown(
              data['reserved_lot_id']!, _reservedLotIdMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalOrderItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalOrderItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      orderId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}order_id'])!,
      variantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}variant_id'])!,
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}quantity'])!,
      quantityDelivered: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}quantity_delivered'])!,
      unitPrice: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}unit_price'])!,
      subtotal: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}subtotal'])!,
      reservedLotId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reserved_lot_id']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LocalOrderItemsTable createAlias(String alias) {
    return $LocalOrderItemsTable(attachedDatabase, alias);
  }
}

class LocalOrderItem extends DataClass implements Insertable<LocalOrderItem> {
  final String id;
  final String tenantId;
  final String orderId;
  final String variantId;
  final int quantity;
  final int quantityDelivered;
  final double unitPrice;
  final double subtotal;
  final String? reservedLotId;
  final bool synced;
  final String localId;
  final DateTime createdAt;
  const LocalOrderItem(
      {required this.id,
      required this.tenantId,
      required this.orderId,
      required this.variantId,
      required this.quantity,
      required this.quantityDelivered,
      required this.unitPrice,
      required this.subtotal,
      this.reservedLotId,
      required this.synced,
      required this.localId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['order_id'] = Variable<String>(orderId);
    map['variant_id'] = Variable<String>(variantId);
    map['quantity'] = Variable<int>(quantity);
    map['quantity_delivered'] = Variable<int>(quantityDelivered);
    map['unit_price'] = Variable<double>(unitPrice);
    map['subtotal'] = Variable<double>(subtotal);
    if (!nullToAbsent || reservedLotId != null) {
      map['reserved_lot_id'] = Variable<String>(reservedLotId);
    }
    map['synced'] = Variable<bool>(synced);
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LocalOrderItemsCompanion toCompanion(bool nullToAbsent) {
    return LocalOrderItemsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      orderId: Value(orderId),
      variantId: Value(variantId),
      quantity: Value(quantity),
      quantityDelivered: Value(quantityDelivered),
      unitPrice: Value(unitPrice),
      subtotal: Value(subtotal),
      reservedLotId: reservedLotId == null && nullToAbsent
          ? const Value.absent()
          : Value(reservedLotId),
      synced: Value(synced),
      localId: Value(localId),
      createdAt: Value(createdAt),
    );
  }

  factory LocalOrderItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalOrderItem(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      orderId: serializer.fromJson<String>(json['orderId']),
      variantId: serializer.fromJson<String>(json['variantId']),
      quantity: serializer.fromJson<int>(json['quantity']),
      quantityDelivered: serializer.fromJson<int>(json['quantityDelivered']),
      unitPrice: serializer.fromJson<double>(json['unitPrice']),
      subtotal: serializer.fromJson<double>(json['subtotal']),
      reservedLotId: serializer.fromJson<String?>(json['reservedLotId']),
      synced: serializer.fromJson<bool>(json['synced']),
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
      'orderId': serializer.toJson<String>(orderId),
      'variantId': serializer.toJson<String>(variantId),
      'quantity': serializer.toJson<int>(quantity),
      'quantityDelivered': serializer.toJson<int>(quantityDelivered),
      'unitPrice': serializer.toJson<double>(unitPrice),
      'subtotal': serializer.toJson<double>(subtotal),
      'reservedLotId': serializer.toJson<String?>(reservedLotId),
      'synced': serializer.toJson<bool>(synced),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalOrderItem copyWith(
          {String? id,
          String? tenantId,
          String? orderId,
          String? variantId,
          int? quantity,
          int? quantityDelivered,
          double? unitPrice,
          double? subtotal,
          Value<String?> reservedLotId = const Value.absent(),
          bool? synced,
          String? localId,
          DateTime? createdAt}) =>
      LocalOrderItem(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        orderId: orderId ?? this.orderId,
        variantId: variantId ?? this.variantId,
        quantity: quantity ?? this.quantity,
        quantityDelivered: quantityDelivered ?? this.quantityDelivered,
        unitPrice: unitPrice ?? this.unitPrice,
        subtotal: subtotal ?? this.subtotal,
        reservedLotId:
            reservedLotId.present ? reservedLotId.value : this.reservedLotId,
        synced: synced ?? this.synced,
        localId: localId ?? this.localId,
        createdAt: createdAt ?? this.createdAt,
      );
  LocalOrderItem copyWithCompanion(LocalOrderItemsCompanion data) {
    return LocalOrderItem(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      orderId: data.orderId.present ? data.orderId.value : this.orderId,
      variantId: data.variantId.present ? data.variantId.value : this.variantId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      quantityDelivered: data.quantityDelivered.present
          ? data.quantityDelivered.value
          : this.quantityDelivered,
      unitPrice: data.unitPrice.present ? data.unitPrice.value : this.unitPrice,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      reservedLotId: data.reservedLotId.present
          ? data.reservedLotId.value
          : this.reservedLotId,
      synced: data.synced.present ? data.synced.value : this.synced,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalOrderItem(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('orderId: $orderId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('quantityDelivered: $quantityDelivered, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('reservedLotId: $reservedLotId, ')
          ..write('synced: $synced, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      tenantId,
      orderId,
      variantId,
      quantity,
      quantityDelivered,
      unitPrice,
      subtotal,
      reservedLotId,
      synced,
      localId,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalOrderItem &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.orderId == this.orderId &&
          other.variantId == this.variantId &&
          other.quantity == this.quantity &&
          other.quantityDelivered == this.quantityDelivered &&
          other.unitPrice == this.unitPrice &&
          other.subtotal == this.subtotal &&
          other.reservedLotId == this.reservedLotId &&
          other.synced == this.synced &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt);
}

class LocalOrderItemsCompanion extends UpdateCompanion<LocalOrderItem> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> orderId;
  final Value<String> variantId;
  final Value<int> quantity;
  final Value<int> quantityDelivered;
  final Value<double> unitPrice;
  final Value<double> subtotal;
  final Value<String?> reservedLotId;
  final Value<bool> synced;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalOrderItemsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.orderId = const Value.absent(),
    this.variantId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.quantityDelivered = const Value.absent(),
    this.unitPrice = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.reservedLotId = const Value.absent(),
    this.synced = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalOrderItemsCompanion.insert({
    required String id,
    required String tenantId,
    required String orderId,
    required String variantId,
    required int quantity,
    this.quantityDelivered = const Value.absent(),
    required double unitPrice,
    required double subtotal,
    this.reservedLotId = const Value.absent(),
    this.synced = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        orderId = Value(orderId),
        variantId = Value(variantId),
        quantity = Value(quantity),
        unitPrice = Value(unitPrice),
        subtotal = Value(subtotal),
        localId = Value(localId);
  static Insertable<LocalOrderItem> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? orderId,
    Expression<String>? variantId,
    Expression<int>? quantity,
    Expression<int>? quantityDelivered,
    Expression<double>? unitPrice,
    Expression<double>? subtotal,
    Expression<String>? reservedLotId,
    Expression<bool>? synced,
    Expression<String>? localId,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (orderId != null) 'order_id': orderId,
      if (variantId != null) 'variant_id': variantId,
      if (quantity != null) 'quantity': quantity,
      if (quantityDelivered != null) 'quantity_delivered': quantityDelivered,
      if (unitPrice != null) 'unit_price': unitPrice,
      if (subtotal != null) 'subtotal': subtotal,
      if (reservedLotId != null) 'reserved_lot_id': reservedLotId,
      if (synced != null) 'synced': synced,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalOrderItemsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? orderId,
      Value<String>? variantId,
      Value<int>? quantity,
      Value<int>? quantityDelivered,
      Value<double>? unitPrice,
      Value<double>? subtotal,
      Value<String?>? reservedLotId,
      Value<bool>? synced,
      Value<String>? localId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LocalOrderItemsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      orderId: orderId ?? this.orderId,
      variantId: variantId ?? this.variantId,
      quantity: quantity ?? this.quantity,
      quantityDelivered: quantityDelivered ?? this.quantityDelivered,
      unitPrice: unitPrice ?? this.unitPrice,
      subtotal: subtotal ?? this.subtotal,
      reservedLotId: reservedLotId ?? this.reservedLotId,
      synced: synced ?? this.synced,
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
    if (orderId.present) {
      map['order_id'] = Variable<String>(orderId.value);
    }
    if (variantId.present) {
      map['variant_id'] = Variable<String>(variantId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<int>(quantity.value);
    }
    if (quantityDelivered.present) {
      map['quantity_delivered'] = Variable<int>(quantityDelivered.value);
    }
    if (unitPrice.present) {
      map['unit_price'] = Variable<double>(unitPrice.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<double>(subtotal.value);
    }
    if (reservedLotId.present) {
      map['reserved_lot_id'] = Variable<String>(reservedLotId.value);
    }
    if (synced.present) {
      map['synced'] = Variable<bool>(synced.value);
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
    return (StringBuffer('LocalOrderItemsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('orderId: $orderId, ')
          ..write('variantId: $variantId, ')
          ..write('quantity: $quantity, ')
          ..write('quantityDelivered: $quantityDelivered, ')
          ..write('unitPrice: $unitPrice, ')
          ..write('subtotal: $subtotal, ')
          ..write('reservedLotId: $reservedLotId, ')
          ..write('synced: $synced, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
      'code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _printerConfigMeta =
      const VerificationMeta('printerConfig');
  @override
  late final GeneratedColumn<String> printerConfig = GeneratedColumn<String>(
      'printer_config', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        branchId,
        code,
        name,
        printerConfig,
        isActive,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_registers';
  @override
  VerificationContext validateIntegrity(Insertable<LocalCashRegister> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    } else if (isInserting) {
      context.missing(_branchIdMeta);
    }
    if (data.containsKey('code')) {
      context.handle(
          _codeMeta, code.isAcceptableOrUnknown(data['code']!, _codeMeta));
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('printer_config')) {
      context.handle(
          _printerConfigMeta,
          printerConfig.isAcceptableOrUnknown(
              data['printer_config']!, _printerConfigMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashRegister map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashRegister(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id'])!,
      code: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}code'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      printerConfig: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}printer_config']),
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final String? printerConfig;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalCashRegister(
      {required this.id,
      required this.tenantId,
      required this.branchId,
      required this.code,
      required this.name,
      this.printerConfig,
      required this.isActive,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['branch_id'] = Variable<String>(branchId);
    map['code'] = Variable<String>(code);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || printerConfig != null) {
      map['printer_config'] = Variable<String>(printerConfig);
    }
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalCashRegistersCompanion toCompanion(bool nullToAbsent) {
    return LocalCashRegistersCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      branchId: Value(branchId),
      code: Value(code),
      name: Value(name),
      printerConfig: printerConfig == null && nullToAbsent
          ? const Value.absent()
          : Value(printerConfig),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalCashRegister.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashRegister(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      branchId: serializer.fromJson<String>(json['branchId']),
      code: serializer.fromJson<String>(json['code']),
      name: serializer.fromJson<String>(json['name']),
      printerConfig: serializer.fromJson<String?>(json['printerConfig']),
      isActive: serializer.fromJson<bool>(json['isActive']),
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
      'code': serializer.toJson<String>(code),
      'name': serializer.toJson<String>(name),
      'printerConfig': serializer.toJson<String?>(printerConfig),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalCashRegister copyWith(
          {String? id,
          String? tenantId,
          String? branchId,
          String? code,
          String? name,
          Value<String?> printerConfig = const Value.absent(),
          bool? isActive,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalCashRegister(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        branchId: branchId ?? this.branchId,
        code: code ?? this.code,
        name: name ?? this.name,
        printerConfig:
            printerConfig.present ? printerConfig.value : this.printerConfig,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalCashRegister copyWithCompanion(LocalCashRegistersCompanion data) {
    return LocalCashRegister(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      code: data.code.present ? data.code.value : this.code,
      name: data.name.present ? data.name.value : this.name,
      printerConfig: data.printerConfig.present
          ? data.printerConfig.value
          : this.printerConfig,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
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
          ..write('printerConfig: $printerConfig, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tenantId, branchId, code, name,
      printerConfig, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashRegister &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.branchId == this.branchId &&
          other.code == this.code &&
          other.name == this.name &&
          other.printerConfig == this.printerConfig &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalCashRegistersCompanion extends UpdateCompanion<LocalCashRegister> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> branchId;
  final Value<String> code;
  final Value<String> name;
  final Value<String?> printerConfig;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalCashRegistersCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.code = const Value.absent(),
    this.name = const Value.absent(),
    this.printerConfig = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashRegistersCompanion.insert({
    required String id,
    required String tenantId,
    required String branchId,
    required String code,
    required String name,
    this.printerConfig = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
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
    Expression<String>? printerConfig,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tenantId != null) 'tenant_id': tenantId,
      if (branchId != null) 'branch_id': branchId,
      if (code != null) 'code': code,
      if (name != null) 'name': name,
      if (printerConfig != null) 'printer_config': printerConfig,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashRegistersCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? branchId,
      Value<String>? code,
      Value<String>? name,
      Value<String?>? printerConfig,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalCashRegistersCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      branchId: branchId ?? this.branchId,
      code: code ?? this.code,
      name: name ?? this.name,
      printerConfig: printerConfig ?? this.printerConfig,
      isActive: isActive ?? this.isActive,
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
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (printerConfig.present) {
      map['printer_config'] = Variable<String>(printerConfig.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
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
    return (StringBuffer('LocalCashRegistersCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('branchId: $branchId, ')
          ..write('code: $code, ')
          ..write('name: $name, ')
          ..write('printerConfig: $printerConfig, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
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
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cashRegisterIdMeta =
      const VerificationMeta('cashRegisterId');
  @override
  late final GeneratedColumn<String> cashRegisterId = GeneratedColumn<String>(
      'cash_register_id', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_cash_registers (id)'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _openingDateMeta =
      const VerificationMeta('openingDate');
  @override
  late final GeneratedColumn<DateTime> openingDate = GeneratedColumn<DateTime>(
      'opening_date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _closingDateMeta =
      const VerificationMeta('closingDate');
  @override
  late final GeneratedColumn<DateTime> closingDate = GeneratedColumn<DateTime>(
      'closing_date', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _initialAmountMeta =
      const VerificationMeta('initialAmount');
  @override
  late final GeneratedColumn<double> initialAmount = GeneratedColumn<double>(
      'initial_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _systemAmountMeta =
      const VerificationMeta('systemAmount');
  @override
  late final GeneratedColumn<double> systemAmount = GeneratedColumn<double>(
      'system_amount', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _declaredAmountMeta =
      const VerificationMeta('declaredAmount');
  @override
  late final GeneratedColumn<double> declaredAmount = GeneratedColumn<double>(
      'declared_amount', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _differenceJustificationMeta =
      const VerificationMeta('differenceJustification');
  @override
  late final GeneratedColumn<String> differenceJustification =
      GeneratedColumn<String>('difference_justification', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<SessionStatus, String> status =
      GeneratedColumn<String>('status', aliasedName, false,
              type: DriftSqlType.string,
              requiredDuringInsert: false,
              defaultValue: const Constant('open'))
          .withConverter<SessionStatus>(
              $LocalCashSessionsTable.$converterstatus);
  static const VerificationMeta _approvedByMeta =
      const VerificationMeta('approvedBy');
  @override
  late final GeneratedColumn<String> approvedBy = GeneratedColumn<String>(
      'approved_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _approvedAtMeta =
      const VerificationMeta('approvedAt');
  @override
  late final GeneratedColumn<DateTime> approvedAt = GeneratedColumn<DateTime>(
      'approved_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _approvalNotesMeta =
      const VerificationMeta('approvalNotes');
  @override
  late final GeneratedColumn<String> approvalNotes = GeneratedColumn<String>(
      'approval_notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _updatedAtMeta =
      const VerificationMeta('updatedAt');
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
      'updated_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        cashRegisterId,
        userId,
        openingDate,
        closingDate,
        initialAmount,
        systemAmount,
        declaredAmount,
        differenceJustification,
        status,
        approvedBy,
        approvedAt,
        approvalNotes,
        synced,
        syncedAt,
        localId,
        createdAt,
        updatedAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_sessions';
  @override
  VerificationContext validateIntegrity(Insertable<LocalCashSession> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('cash_register_id')) {
      context.handle(
          _cashRegisterIdMeta,
          cashRegisterId.isAcceptableOrUnknown(
              data['cash_register_id']!, _cashRegisterIdMeta));
    } else if (isInserting) {
      context.missing(_cashRegisterIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('opening_date')) {
      context.handle(
          _openingDateMeta,
          openingDate.isAcceptableOrUnknown(
              data['opening_date']!, _openingDateMeta));
    }
    if (data.containsKey('closing_date')) {
      context.handle(
          _closingDateMeta,
          closingDate.isAcceptableOrUnknown(
              data['closing_date']!, _closingDateMeta));
    }
    if (data.containsKey('initial_amount')) {
      context.handle(
          _initialAmountMeta,
          initialAmount.isAcceptableOrUnknown(
              data['initial_amount']!, _initialAmountMeta));
    }
    if (data.containsKey('system_amount')) {
      context.handle(
          _systemAmountMeta,
          systemAmount.isAcceptableOrUnknown(
              data['system_amount']!, _systemAmountMeta));
    }
    if (data.containsKey('declared_amount')) {
      context.handle(
          _declaredAmountMeta,
          declaredAmount.isAcceptableOrUnknown(
              data['declared_amount']!, _declaredAmountMeta));
    }
    if (data.containsKey('difference_justification')) {
      context.handle(
          _differenceJustificationMeta,
          differenceJustification.isAcceptableOrUnknown(
              data['difference_justification']!, _differenceJustificationMeta));
    }
    if (data.containsKey('approved_by')) {
      context.handle(
          _approvedByMeta,
          approvedBy.isAcceptableOrUnknown(
              data['approved_by']!, _approvedByMeta));
    }
    if (data.containsKey('approved_at')) {
      context.handle(
          _approvedAtMeta,
          approvedAt.isAcceptableOrUnknown(
              data['approved_at']!, _approvedAtMeta));
    }
    if (data.containsKey('approval_notes')) {
      context.handle(
          _approvalNotesMeta,
          approvalNotes.isAcceptableOrUnknown(
              data['approval_notes']!, _approvalNotesMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('updated_at')) {
      context.handle(_updatedAtMeta,
          updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashSession(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      cashRegisterId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}cash_register_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      openingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}opening_date'])!,
      closingDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}closing_date']),
      initialAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}initial_amount'])!,
      systemAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}system_amount'])!,
      declaredAmount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}declared_amount']),
      differenceJustification: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}difference_justification']),
      status: $LocalCashSessionsTable.$converterstatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!),
      approvedBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}approved_by']),
      approvedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}approved_at']),
      approvalNotes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}approval_notes']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      updatedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}updated_at'])!,
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
  final DateTime openingDate;
  final DateTime? closingDate;
  final double initialAmount;
  final double systemAmount;
  final double? declaredAmount;
  final String? differenceJustification;
  final SessionStatus status;
  final String? approvedBy;
  final DateTime? approvedAt;
  final String? approvalNotes;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  final DateTime updatedAt;
  const LocalCashSession(
      {required this.id,
      required this.tenantId,
      required this.cashRegisterId,
      required this.userId,
      required this.openingDate,
      this.closingDate,
      required this.initialAmount,
      required this.systemAmount,
      this.declaredAmount,
      this.differenceJustification,
      required this.status,
      this.approvedBy,
      this.approvedAt,
      this.approvalNotes,
      required this.synced,
      this.syncedAt,
      required this.localId,
      required this.createdAt,
      required this.updatedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    map['cash_register_id'] = Variable<String>(cashRegisterId);
    map['user_id'] = Variable<String>(userId);
    map['opening_date'] = Variable<DateTime>(openingDate);
    if (!nullToAbsent || closingDate != null) {
      map['closing_date'] = Variable<DateTime>(closingDate);
    }
    map['initial_amount'] = Variable<double>(initialAmount);
    map['system_amount'] = Variable<double>(systemAmount);
    if (!nullToAbsent || declaredAmount != null) {
      map['declared_amount'] = Variable<double>(declaredAmount);
    }
    if (!nullToAbsent || differenceJustification != null) {
      map['difference_justification'] =
          Variable<String>(differenceJustification);
    }
    {
      map['status'] = Variable<String>(
          $LocalCashSessionsTable.$converterstatus.toSql(status));
    }
    if (!nullToAbsent || approvedBy != null) {
      map['approved_by'] = Variable<String>(approvedBy);
    }
    if (!nullToAbsent || approvedAt != null) {
      map['approved_at'] = Variable<DateTime>(approvedAt);
    }
    if (!nullToAbsent || approvalNotes != null) {
      map['approval_notes'] = Variable<String>(approvalNotes);
    }
    map['synced'] = Variable<bool>(synced);
    if (!nullToAbsent || syncedAt != null) {
      map['synced_at'] = Variable<DateTime>(syncedAt);
    }
    map['local_id'] = Variable<String>(localId);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  LocalCashSessionsCompanion toCompanion(bool nullToAbsent) {
    return LocalCashSessionsCompanion(
      id: Value(id),
      tenantId: Value(tenantId),
      cashRegisterId: Value(cashRegisterId),
      userId: Value(userId),
      openingDate: Value(openingDate),
      closingDate: closingDate == null && nullToAbsent
          ? const Value.absent()
          : Value(closingDate),
      initialAmount: Value(initialAmount),
      systemAmount: Value(systemAmount),
      declaredAmount: declaredAmount == null && nullToAbsent
          ? const Value.absent()
          : Value(declaredAmount),
      differenceJustification: differenceJustification == null && nullToAbsent
          ? const Value.absent()
          : Value(differenceJustification),
      status: Value(status),
      approvedBy: approvedBy == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedBy),
      approvedAt: approvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(approvedAt),
      approvalNotes: approvalNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(approvalNotes),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory LocalCashSession.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashSession(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      cashRegisterId: serializer.fromJson<String>(json['cashRegisterId']),
      userId: serializer.fromJson<String>(json['userId']),
      openingDate: serializer.fromJson<DateTime>(json['openingDate']),
      closingDate: serializer.fromJson<DateTime?>(json['closingDate']),
      initialAmount: serializer.fromJson<double>(json['initialAmount']),
      systemAmount: serializer.fromJson<double>(json['systemAmount']),
      declaredAmount: serializer.fromJson<double?>(json['declaredAmount']),
      differenceJustification:
          serializer.fromJson<String?>(json['differenceJustification']),
      status: $LocalCashSessionsTable.$converterstatus
          .fromJson(serializer.fromJson<String>(json['status'])),
      approvedBy: serializer.fromJson<String?>(json['approvedBy']),
      approvedAt: serializer.fromJson<DateTime?>(json['approvedAt']),
      approvalNotes: serializer.fromJson<String?>(json['approvalNotes']),
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
      'cashRegisterId': serializer.toJson<String>(cashRegisterId),
      'userId': serializer.toJson<String>(userId),
      'openingDate': serializer.toJson<DateTime>(openingDate),
      'closingDate': serializer.toJson<DateTime?>(closingDate),
      'initialAmount': serializer.toJson<double>(initialAmount),
      'systemAmount': serializer.toJson<double>(systemAmount),
      'declaredAmount': serializer.toJson<double?>(declaredAmount),
      'differenceJustification':
          serializer.toJson<String?>(differenceJustification),
      'status': serializer.toJson<String>(
          $LocalCashSessionsTable.$converterstatus.toJson(status)),
      'approvedBy': serializer.toJson<String?>(approvedBy),
      'approvedAt': serializer.toJson<DateTime?>(approvedAt),
      'approvalNotes': serializer.toJson<String?>(approvalNotes),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  LocalCashSession copyWith(
          {String? id,
          String? tenantId,
          String? cashRegisterId,
          String? userId,
          DateTime? openingDate,
          Value<DateTime?> closingDate = const Value.absent(),
          double? initialAmount,
          double? systemAmount,
          Value<double?> declaredAmount = const Value.absent(),
          Value<String?> differenceJustification = const Value.absent(),
          SessionStatus? status,
          Value<String?> approvedBy = const Value.absent(),
          Value<DateTime?> approvedAt = const Value.absent(),
          Value<String?> approvalNotes = const Value.absent(),
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          String? localId,
          DateTime? createdAt,
          DateTime? updatedAt}) =>
      LocalCashSession(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        cashRegisterId: cashRegisterId ?? this.cashRegisterId,
        userId: userId ?? this.userId,
        openingDate: openingDate ?? this.openingDate,
        closingDate: closingDate.present ? closingDate.value : this.closingDate,
        initialAmount: initialAmount ?? this.initialAmount,
        systemAmount: systemAmount ?? this.systemAmount,
        declaredAmount:
            declaredAmount.present ? declaredAmount.value : this.declaredAmount,
        differenceJustification: differenceJustification.present
            ? differenceJustification.value
            : this.differenceJustification,
        status: status ?? this.status,
        approvedBy: approvedBy.present ? approvedBy.value : this.approvedBy,
        approvedAt: approvedAt.present ? approvedAt.value : this.approvedAt,
        approvalNotes:
            approvalNotes.present ? approvalNotes.value : this.approvalNotes,
        synced: synced ?? this.synced,
        syncedAt: syncedAt.present ? syncedAt.value : this.syncedAt,
        localId: localId ?? this.localId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );
  LocalCashSession copyWithCompanion(LocalCashSessionsCompanion data) {
    return LocalCashSession(
      id: data.id.present ? data.id.value : this.id,
      tenantId: data.tenantId.present ? data.tenantId.value : this.tenantId,
      cashRegisterId: data.cashRegisterId.present
          ? data.cashRegisterId.value
          : this.cashRegisterId,
      userId: data.userId.present ? data.userId.value : this.userId,
      openingDate:
          data.openingDate.present ? data.openingDate.value : this.openingDate,
      closingDate:
          data.closingDate.present ? data.closingDate.value : this.closingDate,
      initialAmount: data.initialAmount.present
          ? data.initialAmount.value
          : this.initialAmount,
      systemAmount: data.systemAmount.present
          ? data.systemAmount.value
          : this.systemAmount,
      declaredAmount: data.declaredAmount.present
          ? data.declaredAmount.value
          : this.declaredAmount,
      differenceJustification: data.differenceJustification.present
          ? data.differenceJustification.value
          : this.differenceJustification,
      status: data.status.present ? data.status.value : this.status,
      approvedBy:
          data.approvedBy.present ? data.approvedBy.value : this.approvedBy,
      approvedAt:
          data.approvedAt.present ? data.approvedAt.value : this.approvedAt,
      approvalNotes: data.approvalNotes.present
          ? data.approvalNotes.value
          : this.approvalNotes,
      synced: data.synced.present ? data.synced.value : this.synced,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
      localId: data.localId.present ? data.localId.value : this.localId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LocalCashSession(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('userId: $userId, ')
          ..write('openingDate: $openingDate, ')
          ..write('closingDate: $closingDate, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('systemAmount: $systemAmount, ')
          ..write('declaredAmount: $declaredAmount, ')
          ..write('differenceJustification: $differenceJustification, ')
          ..write('status: $status, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('approvalNotes: $approvalNotes, ')
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
      cashRegisterId,
      userId,
      openingDate,
      closingDate,
      initialAmount,
      systemAmount,
      declaredAmount,
      differenceJustification,
      status,
      approvedBy,
      approvedAt,
      approvalNotes,
      synced,
      syncedAt,
      localId,
      createdAt,
      updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashSession &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.cashRegisterId == this.cashRegisterId &&
          other.userId == this.userId &&
          other.openingDate == this.openingDate &&
          other.closingDate == this.closingDate &&
          other.initialAmount == this.initialAmount &&
          other.systemAmount == this.systemAmount &&
          other.declaredAmount == this.declaredAmount &&
          other.differenceJustification == this.differenceJustification &&
          other.status == this.status &&
          other.approvedBy == this.approvedBy &&
          other.approvedAt == this.approvedAt &&
          other.approvalNotes == this.approvalNotes &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class LocalCashSessionsCompanion extends UpdateCompanion<LocalCashSession> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String> cashRegisterId;
  final Value<String> userId;
  final Value<DateTime> openingDate;
  final Value<DateTime?> closingDate;
  final Value<double> initialAmount;
  final Value<double> systemAmount;
  final Value<double?> declaredAmount;
  final Value<String?> differenceJustification;
  final Value<SessionStatus> status;
  final Value<String?> approvedBy;
  final Value<DateTime?> approvedAt;
  final Value<String?> approvalNotes;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const LocalCashSessionsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.cashRegisterId = const Value.absent(),
    this.userId = const Value.absent(),
    this.openingDate = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.initialAmount = const Value.absent(),
    this.systemAmount = const Value.absent(),
    this.declaredAmount = const Value.absent(),
    this.differenceJustification = const Value.absent(),
    this.status = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.approvalNotes = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    this.localId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LocalCashSessionsCompanion.insert({
    required String id,
    required String tenantId,
    required String cashRegisterId,
    required String userId,
    this.openingDate = const Value.absent(),
    this.closingDate = const Value.absent(),
    this.initialAmount = const Value.absent(),
    this.systemAmount = const Value.absent(),
    this.declaredAmount = const Value.absent(),
    this.differenceJustification = const Value.absent(),
    this.status = const Value.absent(),
    this.approvedBy = const Value.absent(),
    this.approvedAt = const Value.absent(),
    this.approvalNotes = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        cashRegisterId = Value(cashRegisterId),
        userId = Value(userId),
        localId = Value(localId);
  static Insertable<LocalCashSession> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? cashRegisterId,
    Expression<String>? userId,
    Expression<DateTime>? openingDate,
    Expression<DateTime>? closingDate,
    Expression<double>? initialAmount,
    Expression<double>? systemAmount,
    Expression<double>? declaredAmount,
    Expression<String>? differenceJustification,
    Expression<String>? status,
    Expression<String>? approvedBy,
    Expression<DateTime>? approvedAt,
    Expression<String>? approvalNotes,
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
      if (cashRegisterId != null) 'cash_register_id': cashRegisterId,
      if (userId != null) 'user_id': userId,
      if (openingDate != null) 'opening_date': openingDate,
      if (closingDate != null) 'closing_date': closingDate,
      if (initialAmount != null) 'initial_amount': initialAmount,
      if (systemAmount != null) 'system_amount': systemAmount,
      if (declaredAmount != null) 'declared_amount': declaredAmount,
      if (differenceJustification != null)
        'difference_justification': differenceJustification,
      if (status != null) 'status': status,
      if (approvedBy != null) 'approved_by': approvedBy,
      if (approvedAt != null) 'approved_at': approvedAt,
      if (approvalNotes != null) 'approval_notes': approvalNotes,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashSessionsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String>? cashRegisterId,
      Value<String>? userId,
      Value<DateTime>? openingDate,
      Value<DateTime?>? closingDate,
      Value<double>? initialAmount,
      Value<double>? systemAmount,
      Value<double?>? declaredAmount,
      Value<String?>? differenceJustification,
      Value<SessionStatus>? status,
      Value<String?>? approvedBy,
      Value<DateTime?>? approvedAt,
      Value<String?>? approvalNotes,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<String>? localId,
      Value<DateTime>? createdAt,
      Value<DateTime>? updatedAt,
      Value<int>? rowid}) {
    return LocalCashSessionsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      cashRegisterId: cashRegisterId ?? this.cashRegisterId,
      userId: userId ?? this.userId,
      openingDate: openingDate ?? this.openingDate,
      closingDate: closingDate ?? this.closingDate,
      initialAmount: initialAmount ?? this.initialAmount,
      systemAmount: systemAmount ?? this.systemAmount,
      declaredAmount: declaredAmount ?? this.declaredAmount,
      differenceJustification:
          differenceJustification ?? this.differenceJustification,
      status: status ?? this.status,
      approvedBy: approvedBy ?? this.approvedBy,
      approvedAt: approvedAt ?? this.approvedAt,
      approvalNotes: approvalNotes ?? this.approvalNotes,
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
    if (cashRegisterId.present) {
      map['cash_register_id'] = Variable<String>(cashRegisterId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (openingDate.present) {
      map['opening_date'] = Variable<DateTime>(openingDate.value);
    }
    if (closingDate.present) {
      map['closing_date'] = Variable<DateTime>(closingDate.value);
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
    if (differenceJustification.present) {
      map['difference_justification'] =
          Variable<String>(differenceJustification.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
          $LocalCashSessionsTable.$converterstatus.toSql(status.value));
    }
    if (approvedBy.present) {
      map['approved_by'] = Variable<String>(approvedBy.value);
    }
    if (approvedAt.present) {
      map['approved_at'] = Variable<DateTime>(approvedAt.value);
    }
    if (approvalNotes.present) {
      map['approval_notes'] = Variable<String>(approvalNotes.value);
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
    return (StringBuffer('LocalCashSessionsCompanion(')
          ..write('id: $id, ')
          ..write('tenantId: $tenantId, ')
          ..write('cashRegisterId: $cashRegisterId, ')
          ..write('userId: $userId, ')
          ..write('openingDate: $openingDate, ')
          ..write('closingDate: $closingDate, ')
          ..write('initialAmount: $initialAmount, ')
          ..write('systemAmount: $systemAmount, ')
          ..write('declaredAmount: $declaredAmount, ')
          ..write('differenceJustification: $differenceJustification, ')
          ..write('status: $status, ')
          ..write('approvedBy: $approvedBy, ')
          ..write('approvedAt: $approvedAt, ')
          ..write('approvalNotes: $approvalNotes, ')
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

class $LocalCashMovementsTable extends LocalCashMovements
    with TableInfo<$LocalCashMovementsTable, LocalCashMovement> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalCashMovementsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tenantIdMeta =
      const VerificationMeta('tenantId');
  @override
  late final GeneratedColumn<String> tenantId = GeneratedColumn<String>(
      'tenant_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _cashSessionIdMeta =
      const VerificationMeta('cashSessionId');
  @override
  late final GeneratedColumn<String> cashSessionId = GeneratedColumn<String>(
      'cash_session_id', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES local_cash_sessions (id)'));
  static const VerificationMeta _branchIdMeta =
      const VerificationMeta('branchId');
  @override
  late final GeneratedColumn<String> branchId = GeneratedColumn<String>(
      'branch_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  late final GeneratedColumnWithTypeConverter<CashMovementType, String>
      movementType = GeneratedColumn<String>(
              'movement_type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<CashMovementType>(
              $LocalCashMovementsTable.$convertermovementType);
  @override
  late final GeneratedColumnWithTypeConverter<CashMovementCategory?, String>
      category = GeneratedColumn<String>('category', aliasedName, true,
              type: DriftSqlType.string, requiredDuringInsert: false)
          .withConverter<CashMovementCategory?>(
              $LocalCashMovementsTable.$convertercategoryn);
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<double> amount = GeneratedColumn<double>(
      'amount', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _conceptMeta =
      const VerificationMeta('concept');
  @override
  late final GeneratedColumn<String> concept = GeneratedColumn<String>(
      'concept', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _referenceMeta =
      const VerificationMeta('reference');
  @override
  late final GeneratedColumn<String> reference = GeneratedColumn<String>(
      'reference', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _evidenceUrlMeta =
      const VerificationMeta('evidenceUrl');
  @override
  late final GeneratedColumn<String> evidenceUrl = GeneratedColumn<String>(
      'evidence_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdByMeta =
      const VerificationMeta('createdBy');
  @override
  late final GeneratedColumn<String> createdBy = GeneratedColumn<String>(
      'created_by', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _syncedMeta = const VerificationMeta('synced');
  @override
  late final GeneratedColumn<bool> synced = GeneratedColumn<bool>(
      'synced', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("synced" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _syncedAtMeta =
      const VerificationMeta('syncedAt');
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
      'synced_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _localIdMeta =
      const VerificationMeta('localId');
  @override
  late final GeneratedColumn<String> localId = GeneratedColumn<String>(
      'local_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        tenantId,
        cashSessionId,
        branchId,
        movementType,
        category,
        amount,
        concept,
        reference,
        evidenceUrl,
        createdBy,
        synced,
        syncedAt,
        localId,
        createdAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'local_cash_movements';
  @override
  VerificationContext validateIntegrity(Insertable<LocalCashMovement> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('tenant_id')) {
      context.handle(_tenantIdMeta,
          tenantId.isAcceptableOrUnknown(data['tenant_id']!, _tenantIdMeta));
    } else if (isInserting) {
      context.missing(_tenantIdMeta);
    }
    if (data.containsKey('cash_session_id')) {
      context.handle(
          _cashSessionIdMeta,
          cashSessionId.isAcceptableOrUnknown(
              data['cash_session_id']!, _cashSessionIdMeta));
    }
    if (data.containsKey('branch_id')) {
      context.handle(_branchIdMeta,
          branchId.isAcceptableOrUnknown(data['branch_id']!, _branchIdMeta));
    }
    if (data.containsKey('amount')) {
      context.handle(_amountMeta,
          amount.isAcceptableOrUnknown(data['amount']!, _amountMeta));
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('concept')) {
      context.handle(_conceptMeta,
          concept.isAcceptableOrUnknown(data['concept']!, _conceptMeta));
    } else if (isInserting) {
      context.missing(_conceptMeta);
    }
    if (data.containsKey('reference')) {
      context.handle(_referenceMeta,
          reference.isAcceptableOrUnknown(data['reference']!, _referenceMeta));
    }
    if (data.containsKey('evidence_url')) {
      context.handle(
          _evidenceUrlMeta,
          evidenceUrl.isAcceptableOrUnknown(
              data['evidence_url']!, _evidenceUrlMeta));
    }
    if (data.containsKey('created_by')) {
      context.handle(_createdByMeta,
          createdBy.isAcceptableOrUnknown(data['created_by']!, _createdByMeta));
    }
    if (data.containsKey('synced')) {
      context.handle(_syncedMeta,
          synced.isAcceptableOrUnknown(data['synced']!, _syncedMeta));
    }
    if (data.containsKey('synced_at')) {
      context.handle(_syncedAtMeta,
          syncedAt.isAcceptableOrUnknown(data['synced_at']!, _syncedAtMeta));
    }
    if (data.containsKey('local_id')) {
      context.handle(_localIdMeta,
          localId.isAcceptableOrUnknown(data['local_id']!, _localIdMeta));
    } else if (isInserting) {
      context.missing(_localIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LocalCashMovement map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LocalCashMovement(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      tenantId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tenant_id'])!,
      cashSessionId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}cash_session_id']),
      branchId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}branch_id']),
      movementType: $LocalCashMovementsTable.$convertermovementType.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}movement_type'])!),
      category: $LocalCashMovementsTable.$convertercategoryn.fromSql(
          attachedDatabase.typeMapping
              .read(DriftSqlType.string, data['${effectivePrefix}category'])),
      amount: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}amount'])!,
      concept: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}concept'])!,
      reference: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}reference']),
      evidenceUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}evidence_url']),
      createdBy: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}created_by']),
      synced: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}synced'])!,
      syncedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}synced_at']),
      localId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_id'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $LocalCashMovementsTable createAlias(String alias) {
    return $LocalCashMovementsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CashMovementType, String, String>
      $convertermovementType =
      const EnumNameConverter<CashMovementType>(CashMovementType.values);
  static JsonTypeConverter2<CashMovementCategory, String, String>
      $convertercategory = const EnumNameConverter<CashMovementCategory>(
          CashMovementCategory.values);
  static JsonTypeConverter2<CashMovementCategory?, String?, String?>
      $convertercategoryn = JsonTypeConverter2.asNullable($convertercategory);
}

class LocalCashMovement extends DataClass
    implements Insertable<LocalCashMovement> {
  final String id;
  final String tenantId;
  final String? cashSessionId;
  final String? branchId;
  final CashMovementType movementType;
  final CashMovementCategory? category;
  final double amount;
  final String concept;
  final String? reference;
  final String? evidenceUrl;
  final String? createdBy;
  final bool synced;
  final DateTime? syncedAt;
  final String localId;
  final DateTime createdAt;
  const LocalCashMovement(
      {required this.id,
      required this.tenantId,
      this.cashSessionId,
      this.branchId,
      required this.movementType,
      this.category,
      required this.amount,
      required this.concept,
      this.reference,
      this.evidenceUrl,
      this.createdBy,
      required this.synced,
      this.syncedAt,
      required this.localId,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['tenant_id'] = Variable<String>(tenantId);
    if (!nullToAbsent || cashSessionId != null) {
      map['cash_session_id'] = Variable<String>(cashSessionId);
    }
    if (!nullToAbsent || branchId != null) {
      map['branch_id'] = Variable<String>(branchId);
    }
    {
      map['movement_type'] = Variable<String>(
          $LocalCashMovementsTable.$convertermovementType.toSql(movementType));
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String>(
          $LocalCashMovementsTable.$convertercategoryn.toSql(category));
    }
    map['amount'] = Variable<double>(amount);
    map['concept'] = Variable<String>(concept);
    if (!nullToAbsent || reference != null) {
      map['reference'] = Variable<String>(reference);
    }
    if (!nullToAbsent || evidenceUrl != null) {
      map['evidence_url'] = Variable<String>(evidenceUrl);
    }
    if (!nullToAbsent || createdBy != null) {
      map['created_by'] = Variable<String>(createdBy);
    }
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
      branchId: branchId == null && nullToAbsent
          ? const Value.absent()
          : Value(branchId),
      movementType: Value(movementType),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
      amount: Value(amount),
      concept: Value(concept),
      reference: reference == null && nullToAbsent
          ? const Value.absent()
          : Value(reference),
      evidenceUrl: evidenceUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(evidenceUrl),
      createdBy: createdBy == null && nullToAbsent
          ? const Value.absent()
          : Value(createdBy),
      synced: Value(synced),
      syncedAt: syncedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(syncedAt),
      localId: Value(localId),
      createdAt: Value(createdAt),
    );
  }

  factory LocalCashMovement.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalCashMovement(
      id: serializer.fromJson<String>(json['id']),
      tenantId: serializer.fromJson<String>(json['tenantId']),
      cashSessionId: serializer.fromJson<String?>(json['cashSessionId']),
      branchId: serializer.fromJson<String?>(json['branchId']),
      movementType: $LocalCashMovementsTable.$convertermovementType
          .fromJson(serializer.fromJson<String>(json['movementType'])),
      category: $LocalCashMovementsTable.$convertercategoryn
          .fromJson(serializer.fromJson<String?>(json['category'])),
      amount: serializer.fromJson<double>(json['amount']),
      concept: serializer.fromJson<String>(json['concept']),
      reference: serializer.fromJson<String?>(json['reference']),
      evidenceUrl: serializer.fromJson<String?>(json['evidenceUrl']),
      createdBy: serializer.fromJson<String?>(json['createdBy']),
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
      'branchId': serializer.toJson<String?>(branchId),
      'movementType': serializer.toJson<String>(
          $LocalCashMovementsTable.$convertermovementType.toJson(movementType)),
      'category': serializer.toJson<String?>(
          $LocalCashMovementsTable.$convertercategoryn.toJson(category)),
      'amount': serializer.toJson<double>(amount),
      'concept': serializer.toJson<String>(concept),
      'reference': serializer.toJson<String?>(reference),
      'evidenceUrl': serializer.toJson<String?>(evidenceUrl),
      'createdBy': serializer.toJson<String?>(createdBy),
      'synced': serializer.toJson<bool>(synced),
      'syncedAt': serializer.toJson<DateTime?>(syncedAt),
      'localId': serializer.toJson<String>(localId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LocalCashMovement copyWith(
          {String? id,
          String? tenantId,
          Value<String?> cashSessionId = const Value.absent(),
          Value<String?> branchId = const Value.absent(),
          CashMovementType? movementType,
          Value<CashMovementCategory?> category = const Value.absent(),
          double? amount,
          String? concept,
          Value<String?> reference = const Value.absent(),
          Value<String?> evidenceUrl = const Value.absent(),
          Value<String?> createdBy = const Value.absent(),
          bool? synced,
          Value<DateTime?> syncedAt = const Value.absent(),
          String? localId,
          DateTime? createdAt}) =>
      LocalCashMovement(
        id: id ?? this.id,
        tenantId: tenantId ?? this.tenantId,
        cashSessionId:
            cashSessionId.present ? cashSessionId.value : this.cashSessionId,
        branchId: branchId.present ? branchId.value : this.branchId,
        movementType: movementType ?? this.movementType,
        category: category.present ? category.value : this.category,
        amount: amount ?? this.amount,
        concept: concept ?? this.concept,
        reference: reference.present ? reference.value : this.reference,
        evidenceUrl: evidenceUrl.present ? evidenceUrl.value : this.evidenceUrl,
        createdBy: createdBy.present ? createdBy.value : this.createdBy,
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
      branchId: data.branchId.present ? data.branchId.value : this.branchId,
      movementType: data.movementType.present
          ? data.movementType.value
          : this.movementType,
      category: data.category.present ? data.category.value : this.category,
      amount: data.amount.present ? data.amount.value : this.amount,
      concept: data.concept.present ? data.concept.value : this.concept,
      reference: data.reference.present ? data.reference.value : this.reference,
      evidenceUrl:
          data.evidenceUrl.present ? data.evidenceUrl.value : this.evidenceUrl,
      createdBy: data.createdBy.present ? data.createdBy.value : this.createdBy,
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
          ..write('branchId: $branchId, ')
          ..write('movementType: $movementType, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('concept: $concept, ')
          ..write('reference: $reference, ')
          ..write('evidenceUrl: $evidenceUrl, ')
          ..write('createdBy: $createdBy, ')
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
      branchId,
      movementType,
      category,
      amount,
      concept,
      reference,
      evidenceUrl,
      createdBy,
      synced,
      syncedAt,
      localId,
      createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalCashMovement &&
          other.id == this.id &&
          other.tenantId == this.tenantId &&
          other.cashSessionId == this.cashSessionId &&
          other.branchId == this.branchId &&
          other.movementType == this.movementType &&
          other.category == this.category &&
          other.amount == this.amount &&
          other.concept == this.concept &&
          other.reference == this.reference &&
          other.evidenceUrl == this.evidenceUrl &&
          other.createdBy == this.createdBy &&
          other.synced == this.synced &&
          other.syncedAt == this.syncedAt &&
          other.localId == this.localId &&
          other.createdAt == this.createdAt);
}

class LocalCashMovementsCompanion extends UpdateCompanion<LocalCashMovement> {
  final Value<String> id;
  final Value<String> tenantId;
  final Value<String?> cashSessionId;
  final Value<String?> branchId;
  final Value<CashMovementType> movementType;
  final Value<CashMovementCategory?> category;
  final Value<double> amount;
  final Value<String> concept;
  final Value<String?> reference;
  final Value<String?> evidenceUrl;
  final Value<String?> createdBy;
  final Value<bool> synced;
  final Value<DateTime?> syncedAt;
  final Value<String> localId;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LocalCashMovementsCompanion({
    this.id = const Value.absent(),
    this.tenantId = const Value.absent(),
    this.cashSessionId = const Value.absent(),
    this.branchId = const Value.absent(),
    this.movementType = const Value.absent(),
    this.category = const Value.absent(),
    this.amount = const Value.absent(),
    this.concept = const Value.absent(),
    this.reference = const Value.absent(),
    this.evidenceUrl = const Value.absent(),
    this.createdBy = const Value.absent(),
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
    this.branchId = const Value.absent(),
    required CashMovementType movementType,
    this.category = const Value.absent(),
    required double amount,
    required String concept,
    this.reference = const Value.absent(),
    this.evidenceUrl = const Value.absent(),
    this.createdBy = const Value.absent(),
    this.synced = const Value.absent(),
    this.syncedAt = const Value.absent(),
    required String localId,
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        tenantId = Value(tenantId),
        movementType = Value(movementType),
        amount = Value(amount),
        concept = Value(concept),
        localId = Value(localId);
  static Insertable<LocalCashMovement> custom({
    Expression<String>? id,
    Expression<String>? tenantId,
    Expression<String>? cashSessionId,
    Expression<String>? branchId,
    Expression<String>? movementType,
    Expression<String>? category,
    Expression<double>? amount,
    Expression<String>? concept,
    Expression<String>? reference,
    Expression<String>? evidenceUrl,
    Expression<String>? createdBy,
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
      if (branchId != null) 'branch_id': branchId,
      if (movementType != null) 'movement_type': movementType,
      if (category != null) 'category': category,
      if (amount != null) 'amount': amount,
      if (concept != null) 'concept': concept,
      if (reference != null) 'reference': reference,
      if (evidenceUrl != null) 'evidence_url': evidenceUrl,
      if (createdBy != null) 'created_by': createdBy,
      if (synced != null) 'synced': synced,
      if (syncedAt != null) 'synced_at': syncedAt,
      if (localId != null) 'local_id': localId,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LocalCashMovementsCompanion copyWith(
      {Value<String>? id,
      Value<String>? tenantId,
      Value<String?>? cashSessionId,
      Value<String?>? branchId,
      Value<CashMovementType>? movementType,
      Value<CashMovementCategory?>? category,
      Value<double>? amount,
      Value<String>? concept,
      Value<String?>? reference,
      Value<String?>? evidenceUrl,
      Value<String?>? createdBy,
      Value<bool>? synced,
      Value<DateTime?>? syncedAt,
      Value<String>? localId,
      Value<DateTime>? createdAt,
      Value<int>? rowid}) {
    return LocalCashMovementsCompanion(
      id: id ?? this.id,
      tenantId: tenantId ?? this.tenantId,
      cashSessionId: cashSessionId ?? this.cashSessionId,
      branchId: branchId ?? this.branchId,
      movementType: movementType ?? this.movementType,
      category: category ?? this.category,
      amount: amount ?? this.amount,
      concept: concept ?? this.concept,
      reference: reference ?? this.reference,
      evidenceUrl: evidenceUrl ?? this.evidenceUrl,
      createdBy: createdBy ?? this.createdBy,
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
    if (branchId.present) {
      map['branch_id'] = Variable<String>(branchId.value);
    }
    if (movementType.present) {
      map['movement_type'] = Variable<String>($LocalCashMovementsTable
          .$convertermovementType
          .toSql(movementType.value));
    }
    if (category.present) {
      map['category'] = Variable<String>(
          $LocalCashMovementsTable.$convertercategoryn.toSql(category.value));
    }
    if (amount.present) {
      map['amount'] = Variable<double>(amount.value);
    }
    if (concept.present) {
      map['concept'] = Variable<String>(concept.value);
    }
    if (reference.present) {
      map['reference'] = Variable<String>(reference.value);
    }
    if (evidenceUrl.present) {
      map['evidence_url'] = Variable<String>(evidenceUrl.value);
    }
    if (createdBy.present) {
      map['created_by'] = Variable<String>(createdBy.value);
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
          ..write('branchId: $branchId, ')
          ..write('movementType: $movementType, ')
          ..write('category: $category, ')
          ..write('amount: $amount, ')
          ..write('concept: $concept, ')
          ..write('reference: $reference, ')
          ..write('evidenceUrl: $evidenceUrl, ')
          ..write('createdBy: $createdBy, ')
          ..write('synced: $synced, ')
          ..write('syncedAt: $syncedAt, ')
          ..write('localId: $localId, ')
          ..write('createdAt: $createdAt, ')
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
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _payloadMeta =
      const VerificationMeta('payload');
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
      'payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _retryCountMeta =
      const VerificationMeta('retryCount');
  @override
  late final GeneratedColumn<int> retryCount = GeneratedColumn<int>(
      'retry_count', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastAttemptMeta =
      const VerificationMeta('lastAttempt');
  @override
  late final GeneratedColumn<DateTime> lastAttempt = GeneratedColumn<DateTime>(
      'last_attempt', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorMeta =
      const VerificationMeta('lastError');
  @override
  late final GeneratedColumn<String> lastError = GeneratedColumn<String>(
      'last_error', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        entityId,
        operation,
        payload,
        retryCount,
        priority,
        createdAt,
        lastAttempt,
        lastError
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_queue';
  @override
  VerificationContext validateIntegrity(Insertable<SyncQueueData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(_payloadMeta,
          payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta));
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('retry_count')) {
      context.handle(
          _retryCountMeta,
          retryCount.isAcceptableOrUnknown(
              data['retry_count']!, _retryCountMeta));
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_attempt')) {
      context.handle(
          _lastAttemptMeta,
          lastAttempt.isAcceptableOrUnknown(
              data['last_attempt']!, _lastAttemptMeta));
    }
    if (data.containsKey('last_error')) {
      context.handle(_lastErrorMeta,
          lastError.isAcceptableOrUnknown(data['last_error']!, _lastErrorMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncQueueData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncQueueData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      payload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}payload'])!,
      retryCount: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}retry_count'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastAttempt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_attempt']),
      lastError: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error']),
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
  final int priority;
  final DateTime createdAt;
  final DateTime? lastAttempt;
  final String? lastError;
  const SyncQueueData(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.payload,
      required this.retryCount,
      required this.priority,
      required this.createdAt,
      this.lastAttempt,
      this.lastError});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['payload'] = Variable<String>(payload);
    map['retry_count'] = Variable<int>(retryCount);
    map['priority'] = Variable<int>(priority);
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
      priority: Value(priority),
      createdAt: Value(createdAt),
      lastAttempt: lastAttempt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastAttempt),
      lastError: lastError == null && nullToAbsent
          ? const Value.absent()
          : Value(lastError),
    );
  }

  factory SyncQueueData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncQueueData(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      payload: serializer.fromJson<String>(json['payload']),
      retryCount: serializer.fromJson<int>(json['retryCount']),
      priority: serializer.fromJson<int>(json['priority']),
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
      'priority': serializer.toJson<int>(priority),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastAttempt': serializer.toJson<DateTime?>(lastAttempt),
      'lastError': serializer.toJson<String?>(lastError),
    };
  }

  SyncQueueData copyWith(
          {int? id,
          String? entityType,
          String? entityId,
          String? operation,
          String? payload,
          int? retryCount,
          int? priority,
          DateTime? createdAt,
          Value<DateTime?> lastAttempt = const Value.absent(),
          Value<String?> lastError = const Value.absent()}) =>
      SyncQueueData(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        payload: payload ?? this.payload,
        retryCount: retryCount ?? this.retryCount,
        priority: priority ?? this.priority,
        createdAt: createdAt ?? this.createdAt,
        lastAttempt: lastAttempt.present ? lastAttempt.value : this.lastAttempt,
        lastError: lastError.present ? lastError.value : this.lastError,
      );
  SyncQueueData copyWithCompanion(SyncQueueCompanion data) {
    return SyncQueueData(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      payload: data.payload.present ? data.payload.value : this.payload,
      retryCount:
          data.retryCount.present ? data.retryCount.value : this.retryCount,
      priority: data.priority.present ? data.priority.value : this.priority,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastAttempt:
          data.lastAttempt.present ? data.lastAttempt.value : this.lastAttempt,
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
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttempt: $lastAttempt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, entityType, entityId, operation, payload,
      retryCount, priority, createdAt, lastAttempt, lastError);
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
          other.priority == this.priority &&
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
  final Value<int> priority;
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
    this.priority = const Value.absent(),
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
    this.priority = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastAttempt = const Value.absent(),
    this.lastError = const Value.absent(),
  })  : entityType = Value(entityType),
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
    Expression<int>? priority,
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
      if (priority != null) 'priority': priority,
      if (createdAt != null) 'created_at': createdAt,
      if (lastAttempt != null) 'last_attempt': lastAttempt,
      if (lastError != null) 'last_error': lastError,
    });
  }

  SyncQueueCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? payload,
      Value<int>? retryCount,
      Value<int>? priority,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastAttempt,
      Value<String?>? lastError}) {
    return SyncQueueCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      payload: payload ?? this.payload,
      retryCount: retryCount ?? this.retryCount,
      priority: priority ?? this.priority,
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
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
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
          ..write('priority: $priority, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastAttempt: $lastAttempt, ')
          ..write('lastError: $lastError')
          ..write(')'))
        .toString();
  }
}

class $SyncConflictsTable extends SyncConflicts
    with TableInfo<$SyncConflictsTable, SyncConflict> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncConflictsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _localPayloadMeta =
      const VerificationMeta('localPayload');
  @override
  late final GeneratedColumn<String> localPayload = GeneratedColumn<String>(
      'local_payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _remotePayloadMeta =
      const VerificationMeta('remotePayload');
  @override
  late final GeneratedColumn<String> remotePayload = GeneratedColumn<String>(
      'remote_payload', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _conflictTypeMeta =
      const VerificationMeta('conflictType');
  @override
  late final GeneratedColumn<String> conflictType = GeneratedColumn<String>(
      'conflict_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _detectedAtMeta =
      const VerificationMeta('detectedAt');
  @override
  late final GeneratedColumn<DateTime> detectedAt = GeneratedColumn<DateTime>(
      'detected_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _resolvedAtMeta =
      const VerificationMeta('resolvedAt');
  @override
  late final GeneratedColumn<DateTime> resolvedAt = GeneratedColumn<DateTime>(
      'resolved_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  static const VerificationMeta _resolutionStrategyMeta =
      const VerificationMeta('resolutionStrategy');
  @override
  late final GeneratedColumn<String> resolutionStrategy =
      GeneratedColumn<String>('resolution_strategy', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _resolvedMeta =
      const VerificationMeta('resolved');
  @override
  late final GeneratedColumn<bool> resolved = GeneratedColumn<bool>(
      'resolved', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("resolved" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        entityType,
        entityId,
        localPayload,
        remotePayload,
        conflictType,
        detectedAt,
        resolvedAt,
        resolutionStrategy,
        resolved
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_conflicts';
  @override
  VerificationContext validateIntegrity(Insertable<SyncConflict> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('local_payload')) {
      context.handle(
          _localPayloadMeta,
          localPayload.isAcceptableOrUnknown(
              data['local_payload']!, _localPayloadMeta));
    } else if (isInserting) {
      context.missing(_localPayloadMeta);
    }
    if (data.containsKey('remote_payload')) {
      context.handle(
          _remotePayloadMeta,
          remotePayload.isAcceptableOrUnknown(
              data['remote_payload']!, _remotePayloadMeta));
    } else if (isInserting) {
      context.missing(_remotePayloadMeta);
    }
    if (data.containsKey('conflict_type')) {
      context.handle(
          _conflictTypeMeta,
          conflictType.isAcceptableOrUnknown(
              data['conflict_type']!, _conflictTypeMeta));
    } else if (isInserting) {
      context.missing(_conflictTypeMeta);
    }
    if (data.containsKey('detected_at')) {
      context.handle(
          _detectedAtMeta,
          detectedAt.isAcceptableOrUnknown(
              data['detected_at']!, _detectedAtMeta));
    }
    if (data.containsKey('resolved_at')) {
      context.handle(
          _resolvedAtMeta,
          resolvedAt.isAcceptableOrUnknown(
              data['resolved_at']!, _resolvedAtMeta));
    }
    if (data.containsKey('resolution_strategy')) {
      context.handle(
          _resolutionStrategyMeta,
          resolutionStrategy.isAcceptableOrUnknown(
              data['resolution_strategy']!, _resolutionStrategyMeta));
    }
    if (data.containsKey('resolved')) {
      context.handle(_resolvedMeta,
          resolved.isAcceptableOrUnknown(data['resolved']!, _resolvedMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncConflict map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncConflict(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      localPayload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}local_payload'])!,
      remotePayload: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}remote_payload'])!,
      conflictType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}conflict_type'])!,
      detectedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}detected_at'])!,
      resolvedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}resolved_at']),
      resolutionStrategy: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}resolution_strategy']),
      resolved: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}resolved'])!,
    );
  }

  @override
  $SyncConflictsTable createAlias(String alias) {
    return $SyncConflictsTable(attachedDatabase, alias);
  }
}

class SyncConflict extends DataClass implements Insertable<SyncConflict> {
  final int id;
  final String entityType;
  final String entityId;
  final String localPayload;
  final String remotePayload;
  final String conflictType;
  final DateTime detectedAt;
  final DateTime? resolvedAt;
  final String? resolutionStrategy;
  final bool resolved;
  const SyncConflict(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.localPayload,
      required this.remotePayload,
      required this.conflictType,
      required this.detectedAt,
      this.resolvedAt,
      this.resolutionStrategy,
      required this.resolved});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['local_payload'] = Variable<String>(localPayload);
    map['remote_payload'] = Variable<String>(remotePayload);
    map['conflict_type'] = Variable<String>(conflictType);
    map['detected_at'] = Variable<DateTime>(detectedAt);
    if (!nullToAbsent || resolvedAt != null) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt);
    }
    if (!nullToAbsent || resolutionStrategy != null) {
      map['resolution_strategy'] = Variable<String>(resolutionStrategy);
    }
    map['resolved'] = Variable<bool>(resolved);
    return map;
  }

  SyncConflictsCompanion toCompanion(bool nullToAbsent) {
    return SyncConflictsCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      localPayload: Value(localPayload),
      remotePayload: Value(remotePayload),
      conflictType: Value(conflictType),
      detectedAt: Value(detectedAt),
      resolvedAt: resolvedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(resolvedAt),
      resolutionStrategy: resolutionStrategy == null && nullToAbsent
          ? const Value.absent()
          : Value(resolutionStrategy),
      resolved: Value(resolved),
    );
  }

  factory SyncConflict.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncConflict(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      localPayload: serializer.fromJson<String>(json['localPayload']),
      remotePayload: serializer.fromJson<String>(json['remotePayload']),
      conflictType: serializer.fromJson<String>(json['conflictType']),
      detectedAt: serializer.fromJson<DateTime>(json['detectedAt']),
      resolvedAt: serializer.fromJson<DateTime?>(json['resolvedAt']),
      resolutionStrategy:
          serializer.fromJson<String?>(json['resolutionStrategy']),
      resolved: serializer.fromJson<bool>(json['resolved']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'entityType': serializer.toJson<String>(entityType),
      'entityId': serializer.toJson<String>(entityId),
      'localPayload': serializer.toJson<String>(localPayload),
      'remotePayload': serializer.toJson<String>(remotePayload),
      'conflictType': serializer.toJson<String>(conflictType),
      'detectedAt': serializer.toJson<DateTime>(detectedAt),
      'resolvedAt': serializer.toJson<DateTime?>(resolvedAt),
      'resolutionStrategy': serializer.toJson<String?>(resolutionStrategy),
      'resolved': serializer.toJson<bool>(resolved),
    };
  }

  SyncConflict copyWith(
          {int? id,
          String? entityType,
          String? entityId,
          String? localPayload,
          String? remotePayload,
          String? conflictType,
          DateTime? detectedAt,
          Value<DateTime?> resolvedAt = const Value.absent(),
          Value<String?> resolutionStrategy = const Value.absent(),
          bool? resolved}) =>
      SyncConflict(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        localPayload: localPayload ?? this.localPayload,
        remotePayload: remotePayload ?? this.remotePayload,
        conflictType: conflictType ?? this.conflictType,
        detectedAt: detectedAt ?? this.detectedAt,
        resolvedAt: resolvedAt.present ? resolvedAt.value : this.resolvedAt,
        resolutionStrategy: resolutionStrategy.present
            ? resolutionStrategy.value
            : this.resolutionStrategy,
        resolved: resolved ?? this.resolved,
      );
  SyncConflict copyWithCompanion(SyncConflictsCompanion data) {
    return SyncConflict(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      localPayload: data.localPayload.present
          ? data.localPayload.value
          : this.localPayload,
      remotePayload: data.remotePayload.present
          ? data.remotePayload.value
          : this.remotePayload,
      conflictType: data.conflictType.present
          ? data.conflictType.value
          : this.conflictType,
      detectedAt:
          data.detectedAt.present ? data.detectedAt.value : this.detectedAt,
      resolvedAt:
          data.resolvedAt.present ? data.resolvedAt.value : this.resolvedAt,
      resolutionStrategy: data.resolutionStrategy.present
          ? data.resolutionStrategy.value
          : this.resolutionStrategy,
      resolved: data.resolved.present ? data.resolved.value : this.resolved,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncConflict(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('localPayload: $localPayload, ')
          ..write('remotePayload: $remotePayload, ')
          ..write('conflictType: $conflictType, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('resolutionStrategy: $resolutionStrategy, ')
          ..write('resolved: $resolved')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      entityType,
      entityId,
      localPayload,
      remotePayload,
      conflictType,
      detectedAt,
      resolvedAt,
      resolutionStrategy,
      resolved);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncConflict &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.localPayload == this.localPayload &&
          other.remotePayload == this.remotePayload &&
          other.conflictType == this.conflictType &&
          other.detectedAt == this.detectedAt &&
          other.resolvedAt == this.resolvedAt &&
          other.resolutionStrategy == this.resolutionStrategy &&
          other.resolved == this.resolved);
}

class SyncConflictsCompanion extends UpdateCompanion<SyncConflict> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> localPayload;
  final Value<String> remotePayload;
  final Value<String> conflictType;
  final Value<DateTime> detectedAt;
  final Value<DateTime?> resolvedAt;
  final Value<String?> resolutionStrategy;
  final Value<bool> resolved;
  const SyncConflictsCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.localPayload = const Value.absent(),
    this.remotePayload = const Value.absent(),
    this.conflictType = const Value.absent(),
    this.detectedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.resolutionStrategy = const Value.absent(),
    this.resolved = const Value.absent(),
  });
  SyncConflictsCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String localPayload,
    required String remotePayload,
    required String conflictType,
    this.detectedAt = const Value.absent(),
    this.resolvedAt = const Value.absent(),
    this.resolutionStrategy = const Value.absent(),
    this.resolved = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        localPayload = Value(localPayload),
        remotePayload = Value(remotePayload),
        conflictType = Value(conflictType);
  static Insertable<SyncConflict> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? localPayload,
    Expression<String>? remotePayload,
    Expression<String>? conflictType,
    Expression<DateTime>? detectedAt,
    Expression<DateTime>? resolvedAt,
    Expression<String>? resolutionStrategy,
    Expression<bool>? resolved,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (localPayload != null) 'local_payload': localPayload,
      if (remotePayload != null) 'remote_payload': remotePayload,
      if (conflictType != null) 'conflict_type': conflictType,
      if (detectedAt != null) 'detected_at': detectedAt,
      if (resolvedAt != null) 'resolved_at': resolvedAt,
      if (resolutionStrategy != null) 'resolution_strategy': resolutionStrategy,
      if (resolved != null) 'resolved': resolved,
    });
  }

  SyncConflictsCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? localPayload,
      Value<String>? remotePayload,
      Value<String>? conflictType,
      Value<DateTime>? detectedAt,
      Value<DateTime?>? resolvedAt,
      Value<String?>? resolutionStrategy,
      Value<bool>? resolved}) {
    return SyncConflictsCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      localPayload: localPayload ?? this.localPayload,
      remotePayload: remotePayload ?? this.remotePayload,
      conflictType: conflictType ?? this.conflictType,
      detectedAt: detectedAt ?? this.detectedAt,
      resolvedAt: resolvedAt ?? this.resolvedAt,
      resolutionStrategy: resolutionStrategy ?? this.resolutionStrategy,
      resolved: resolved ?? this.resolved,
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
    if (localPayload.present) {
      map['local_payload'] = Variable<String>(localPayload.value);
    }
    if (remotePayload.present) {
      map['remote_payload'] = Variable<String>(remotePayload.value);
    }
    if (conflictType.present) {
      map['conflict_type'] = Variable<String>(conflictType.value);
    }
    if (detectedAt.present) {
      map['detected_at'] = Variable<DateTime>(detectedAt.value);
    }
    if (resolvedAt.present) {
      map['resolved_at'] = Variable<DateTime>(resolvedAt.value);
    }
    if (resolutionStrategy.present) {
      map['resolution_strategy'] = Variable<String>(resolutionStrategy.value);
    }
    if (resolved.present) {
      map['resolved'] = Variable<bool>(resolved.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncConflictsCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('localPayload: $localPayload, ')
          ..write('remotePayload: $remotePayload, ')
          ..write('conflictType: $conflictType, ')
          ..write('detectedAt: $detectedAt, ')
          ..write('resolvedAt: $resolvedAt, ')
          ..write('resolutionStrategy: $resolutionStrategy, ')
          ..write('resolved: $resolved')
          ..write(')'))
        .toString();
  }
}

class $SyncAuditTable extends SyncAudit
    with TableInfo<$SyncAuditTable, SyncAuditLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SyncAuditTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _entityTypeMeta =
      const VerificationMeta('entityType');
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
      'entity_type', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _entityIdMeta =
      const VerificationMeta('entityId');
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
      'entity_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _operationMeta =
      const VerificationMeta('operation');
  @override
  late final GeneratedColumn<String> operation = GeneratedColumn<String>(
      'operation', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
      'status', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 20),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _timestampMeta =
      const VerificationMeta('timestamp');
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
      'timestamp', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _detailsMeta =
      const VerificationMeta('details');
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
      'details', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, entityType, entityId, operation, status, timestamp, details];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sync_audit';
  @override
  VerificationContext validateIntegrity(Insertable<SyncAuditLog> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('entity_type')) {
      context.handle(
          _entityTypeMeta,
          entityType.isAcceptableOrUnknown(
              data['entity_type']!, _entityTypeMeta));
    } else if (isInserting) {
      context.missing(_entityTypeMeta);
    }
    if (data.containsKey('entity_id')) {
      context.handle(_entityIdMeta,
          entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta));
    } else if (isInserting) {
      context.missing(_entityIdMeta);
    }
    if (data.containsKey('operation')) {
      context.handle(_operationMeta,
          operation.isAcceptableOrUnknown(data['operation']!, _operationMeta));
    } else if (isInserting) {
      context.missing(_operationMeta);
    }
    if (data.containsKey('status')) {
      context.handle(_statusMeta,
          status.isAcceptableOrUnknown(data['status']!, _statusMeta));
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(_timestampMeta,
          timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta));
    }
    if (data.containsKey('details')) {
      context.handle(_detailsMeta,
          details.isAcceptableOrUnknown(data['details']!, _detailsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SyncAuditLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SyncAuditLog(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      entityType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_type'])!,
      entityId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}entity_id'])!,
      operation: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}operation'])!,
      status: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}status'])!,
      timestamp: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}timestamp'])!,
      details: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}details']),
    );
  }

  @override
  $SyncAuditTable createAlias(String alias) {
    return $SyncAuditTable(attachedDatabase, alias);
  }
}

class SyncAuditLog extends DataClass implements Insertable<SyncAuditLog> {
  final int id;
  final String entityType;
  final String entityId;
  final String operation;
  final String status;
  final DateTime timestamp;
  final String? details;
  const SyncAuditLog(
      {required this.id,
      required this.entityType,
      required this.entityId,
      required this.operation,
      required this.status,
      required this.timestamp,
      this.details});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['entity_type'] = Variable<String>(entityType);
    map['entity_id'] = Variable<String>(entityId);
    map['operation'] = Variable<String>(operation);
    map['status'] = Variable<String>(status);
    map['timestamp'] = Variable<DateTime>(timestamp);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    return map;
  }

  SyncAuditCompanion toCompanion(bool nullToAbsent) {
    return SyncAuditCompanion(
      id: Value(id),
      entityType: Value(entityType),
      entityId: Value(entityId),
      operation: Value(operation),
      status: Value(status),
      timestamp: Value(timestamp),
      details: details == null && nullToAbsent
          ? const Value.absent()
          : Value(details),
    );
  }

  factory SyncAuditLog.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SyncAuditLog(
      id: serializer.fromJson<int>(json['id']),
      entityType: serializer.fromJson<String>(json['entityType']),
      entityId: serializer.fromJson<String>(json['entityId']),
      operation: serializer.fromJson<String>(json['operation']),
      status: serializer.fromJson<String>(json['status']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
      details: serializer.fromJson<String?>(json['details']),
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
      'status': serializer.toJson<String>(status),
      'timestamp': serializer.toJson<DateTime>(timestamp),
      'details': serializer.toJson<String?>(details),
    };
  }

  SyncAuditLog copyWith(
          {int? id,
          String? entityType,
          String? entityId,
          String? operation,
          String? status,
          DateTime? timestamp,
          Value<String?> details = const Value.absent()}) =>
      SyncAuditLog(
        id: id ?? this.id,
        entityType: entityType ?? this.entityType,
        entityId: entityId ?? this.entityId,
        operation: operation ?? this.operation,
        status: status ?? this.status,
        timestamp: timestamp ?? this.timestamp,
        details: details.present ? details.value : this.details,
      );
  SyncAuditLog copyWithCompanion(SyncAuditCompanion data) {
    return SyncAuditLog(
      id: data.id.present ? data.id.value : this.id,
      entityType:
          data.entityType.present ? data.entityType.value : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      operation: data.operation.present ? data.operation.value : this.operation,
      status: data.status.present ? data.status.value : this.status,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
      details: data.details.present ? data.details.value : this.details,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SyncAuditLog(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, entityType, entityId, operation, status, timestamp, details);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SyncAuditLog &&
          other.id == this.id &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.operation == this.operation &&
          other.status == this.status &&
          other.timestamp == this.timestamp &&
          other.details == this.details);
}

class SyncAuditCompanion extends UpdateCompanion<SyncAuditLog> {
  final Value<int> id;
  final Value<String> entityType;
  final Value<String> entityId;
  final Value<String> operation;
  final Value<String> status;
  final Value<DateTime> timestamp;
  final Value<String?> details;
  const SyncAuditCompanion({
    this.id = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.operation = const Value.absent(),
    this.status = const Value.absent(),
    this.timestamp = const Value.absent(),
    this.details = const Value.absent(),
  });
  SyncAuditCompanion.insert({
    this.id = const Value.absent(),
    required String entityType,
    required String entityId,
    required String operation,
    required String status,
    this.timestamp = const Value.absent(),
    this.details = const Value.absent(),
  })  : entityType = Value(entityType),
        entityId = Value(entityId),
        operation = Value(operation),
        status = Value(status);
  static Insertable<SyncAuditLog> custom({
    Expression<int>? id,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? operation,
    Expression<String>? status,
    Expression<DateTime>? timestamp,
    Expression<String>? details,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (operation != null) 'operation': operation,
      if (status != null) 'status': status,
      if (timestamp != null) 'timestamp': timestamp,
      if (details != null) 'details': details,
    });
  }

  SyncAuditCompanion copyWith(
      {Value<int>? id,
      Value<String>? entityType,
      Value<String>? entityId,
      Value<String>? operation,
      Value<String>? status,
      Value<DateTime>? timestamp,
      Value<String?>? details}) {
    return SyncAuditCompanion(
      id: id ?? this.id,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      operation: operation ?? this.operation,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      details: details ?? this.details,
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
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SyncAuditCompanion(')
          ..write('id: $id, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('operation: $operation, ')
          ..write('status: $status, ')
          ..write('timestamp: $timestamp, ')
          ..write('details: $details')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $LocalProductCategoriesTable localProductCategories =
      $LocalProductCategoriesTable(this);
  late final $LocalBrandsTable localBrands = $LocalBrandsTable(this);
  late final $LocalUnitsOfMeasureTable localUnitsOfMeasure =
      $LocalUnitsOfMeasureTable(this);
  late final $LocalProductsTable localProducts = $LocalProductsTable(this);
  late final $LocalProductVariantsTable localProductVariants =
      $LocalProductVariantsTable(this);
  late final $LocalPriceListsTable localPriceLists =
      $LocalPriceListsTable(this);
  late final $LocalPriceListItemsTable localPriceListItems =
      $LocalPriceListItemsTable(this);
  late final $LocalInventoryLotsTable localInventoryLots =
      $LocalInventoryLotsTable(this);
  late final $LocalInventoryMovementsTable localInventoryMovements =
      $LocalInventoryMovementsTable(this);
  late final $LocalCustomersTable localCustomers = $LocalCustomersTable(this);
  late final $LocalSalesTable localSales = $LocalSalesTable(this);
  late final $LocalSaleItemsTable localSaleItems = $LocalSaleItemsTable(this);
  late final $LocalSalePaymentsTable localSalePayments =
      $LocalSalePaymentsTable(this);
  late final $LocalOrdersTable localOrders = $LocalOrdersTable(this);
  late final $LocalOrderItemsTable localOrderItems =
      $LocalOrderItemsTable(this);
  late final $LocalCashRegistersTable localCashRegisters =
      $LocalCashRegistersTable(this);
  late final $LocalCashSessionsTable localCashSessions =
      $LocalCashSessionsTable(this);
  late final $LocalCashMovementsTable localCashMovements =
      $LocalCashMovementsTable(this);
  late final $SyncQueueTable syncQueue = $SyncQueueTable(this);
  late final $SyncConflictsTable syncConflicts = $SyncConflictsTable(this);
  late final $SyncAuditTable syncAudit = $SyncAuditTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        localProductCategories,
        localBrands,
        localUnitsOfMeasure,
        localProducts,
        localProductVariants,
        localPriceLists,
        localPriceListItems,
        localInventoryLots,
        localInventoryMovements,
        localCustomers,
        localSales,
        localSaleItems,
        localSalePayments,
        localOrders,
        localOrderItems,
        localCashRegisters,
        localCashSessions,
        localCashMovements,
        syncQueue,
        syncConflicts,
        syncAudit
      ];
}

typedef $$LocalProductCategoriesTableCreateCompanionBuilder
    = LocalProductCategoriesCompanion Function({
  required String id,
  required String tenantId,
  required String name,
  Value<String?> description,
  Value<String?> code,
  Value<String?> parentId,
  Value<int> level,
  Value<int> displayOrder,
  Value<String?> imageUrl,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalProductCategoriesTableUpdateCompanionBuilder
    = LocalProductCategoriesCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String?> description,
  Value<String?> code,
  Value<String?> parentId,
  Value<int> level,
  Value<int> displayOrder,
  Value<String?> imageUrl,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalProductCategoriesTableFilterComposer
    extends Composer<_$AppDatabase, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalProductCategoriesTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get parentId => $composableBuilder(
      column: $table.parentId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get level => $composableBuilder(
      column: $table.level, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageUrl => $composableBuilder(
      column: $table.imageUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalProductCategoriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalProductCategoriesTable> {
  $$LocalProductCategoriesTableAnnotationComposer({
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
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get parentId =>
      $composableBuilder(column: $table.parentId, builder: (column) => column);

  GeneratedColumn<int> get level =>
      $composableBuilder(column: $table.level, builder: (column) => column);

  GeneratedColumn<int> get displayOrder => $composableBuilder(
      column: $table.displayOrder, builder: (column) => column);

  GeneratedColumn<String> get imageUrl =>
      $composableBuilder(column: $table.imageUrl, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalProductCategoriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalProductCategoriesTable,
    LocalProductCategory,
    $$LocalProductCategoriesTableFilterComposer,
    $$LocalProductCategoriesTableOrderingComposer,
    $$LocalProductCategoriesTableAnnotationComposer,
    $$LocalProductCategoriesTableCreateCompanionBuilder,
    $$LocalProductCategoriesTableUpdateCompanionBuilder,
    (
      LocalProductCategory,
      BaseReferences<_$AppDatabase, $LocalProductCategoriesTable,
          LocalProductCategory>
    ),
    LocalProductCategory,
    PrefetchHooks Function()> {
  $$LocalProductCategoriesTableTableManager(
      _$AppDatabase db, $LocalProductCategoriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductCategoriesTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductCategoriesTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductCategoriesTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductCategoriesCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            description: description,
            code: code,
            parentId: parentId,
            level: level,
            displayOrder: displayOrder,
            imageUrl: imageUrl,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> code = const Value.absent(),
            Value<String?> parentId = const Value.absent(),
            Value<int> level = const Value.absent(),
            Value<int> displayOrder = const Value.absent(),
            Value<String?> imageUrl = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductCategoriesCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            description: description,
            code: code,
            parentId: parentId,
            level: level,
            displayOrder: displayOrder,
            imageUrl: imageUrl,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalProductCategoriesTableProcessedTableManager
    = ProcessedTableManager<
        _$AppDatabase,
        $LocalProductCategoriesTable,
        LocalProductCategory,
        $$LocalProductCategoriesTableFilterComposer,
        $$LocalProductCategoriesTableOrderingComposer,
        $$LocalProductCategoriesTableAnnotationComposer,
        $$LocalProductCategoriesTableCreateCompanionBuilder,
        $$LocalProductCategoriesTableUpdateCompanionBuilder,
        (
          LocalProductCategory,
          BaseReferences<_$AppDatabase, $LocalProductCategoriesTable,
              LocalProductCategory>
        ),
        LocalProductCategory,
        PrefetchHooks Function()>;
typedef $$LocalBrandsTableCreateCompanionBuilder = LocalBrandsCompanion
    Function({
  required String id,
  required String tenantId,
  required String name,
  Value<String?> description,
  Value<String?> logoUrl,
  Value<String?> website,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalBrandsTableUpdateCompanionBuilder = LocalBrandsCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String?> description,
  Value<String?> logoUrl,
  Value<String?> website,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalBrandsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalBrandsTable> {
  $$LocalBrandsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalBrandsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalBrandsTable> {
  $$LocalBrandsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get logoUrl => $composableBuilder(
      column: $table.logoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get website => $composableBuilder(
      column: $table.website, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalBrandsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalBrandsTable> {
  $$LocalBrandsTableAnnotationComposer({
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
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get logoUrl =>
      $composableBuilder(column: $table.logoUrl, builder: (column) => column);

  GeneratedColumn<String> get website =>
      $composableBuilder(column: $table.website, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalBrandsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalBrandsTable,
    LocalBrand,
    $$LocalBrandsTableFilterComposer,
    $$LocalBrandsTableOrderingComposer,
    $$LocalBrandsTableAnnotationComposer,
    $$LocalBrandsTableCreateCompanionBuilder,
    $$LocalBrandsTableUpdateCompanionBuilder,
    (LocalBrand, BaseReferences<_$AppDatabase, $LocalBrandsTable, LocalBrand>),
    LocalBrand,
    PrefetchHooks Function()> {
  $$LocalBrandsTableTableManager(_$AppDatabase db, $LocalBrandsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalBrandsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalBrandsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalBrandsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalBrandsCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            description: description,
            logoUrl: logoUrl,
            website: website,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> logoUrl = const Value.absent(),
            Value<String?> website = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalBrandsCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            description: description,
            logoUrl: logoUrl,
            website: website,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalBrandsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalBrandsTable,
    LocalBrand,
    $$LocalBrandsTableFilterComposer,
    $$LocalBrandsTableOrderingComposer,
    $$LocalBrandsTableAnnotationComposer,
    $$LocalBrandsTableCreateCompanionBuilder,
    $$LocalBrandsTableUpdateCompanionBuilder,
    (LocalBrand, BaseReferences<_$AppDatabase, $LocalBrandsTable, LocalBrand>),
    LocalBrand,
    PrefetchHooks Function()>;
typedef $$LocalUnitsOfMeasureTableCreateCompanionBuilder
    = LocalUnitsOfMeasureCompanion Function({
  required String id,
  required String tenantId,
  required String name,
  required String abbreviation,
  required String unitType,
  Value<double?> conversionFactor,
  Value<String?> baseUnitId,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalUnitsOfMeasureTableUpdateCompanionBuilder
    = LocalUnitsOfMeasureCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> name,
  Value<String> abbreviation,
  Value<String> unitType,
  Value<double?> conversionFactor,
  Value<String?> baseUnitId,
  Value<bool> isActive,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$LocalUnitsOfMeasureTableFilterComposer
    extends Composer<_$AppDatabase, $LocalUnitsOfMeasureTable> {
  $$LocalUnitsOfMeasureTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get abbreviation => $composableBuilder(
      column: $table.abbreviation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitType => $composableBuilder(
      column: $table.unitType, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get conversionFactor => $composableBuilder(
      column: $table.conversionFactor,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get baseUnitId => $composableBuilder(
      column: $table.baseUnitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));
}

class $$LocalUnitsOfMeasureTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalUnitsOfMeasureTable> {
  $$LocalUnitsOfMeasureTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get abbreviation => $composableBuilder(
      column: $table.abbreviation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitType => $composableBuilder(
      column: $table.unitType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get conversionFactor => $composableBuilder(
      column: $table.conversionFactor,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get baseUnitId => $composableBuilder(
      column: $table.baseUnitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
}

class $$LocalUnitsOfMeasureTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalUnitsOfMeasureTable> {
  $$LocalUnitsOfMeasureTableAnnotationComposer({
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

  GeneratedColumn<String> get abbreviation => $composableBuilder(
      column: $table.abbreviation, builder: (column) => column);

  GeneratedColumn<String> get unitType =>
      $composableBuilder(column: $table.unitType, builder: (column) => column);

  GeneratedColumn<double> get conversionFactor => $composableBuilder(
      column: $table.conversionFactor, builder: (column) => column);

  GeneratedColumn<String> get baseUnitId => $composableBuilder(
      column: $table.baseUnitId, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$LocalUnitsOfMeasureTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalUnitsOfMeasureTable,
    LocalUnitsOfMeasureData,
    $$LocalUnitsOfMeasureTableFilterComposer,
    $$LocalUnitsOfMeasureTableOrderingComposer,
    $$LocalUnitsOfMeasureTableAnnotationComposer,
    $$LocalUnitsOfMeasureTableCreateCompanionBuilder,
    $$LocalUnitsOfMeasureTableUpdateCompanionBuilder,
    (
      LocalUnitsOfMeasureData,
      BaseReferences<_$AppDatabase, $LocalUnitsOfMeasureTable,
          LocalUnitsOfMeasureData>
    ),
    LocalUnitsOfMeasureData,
    PrefetchHooks Function()> {
  $$LocalUnitsOfMeasureTableTableManager(
      _$AppDatabase db, $LocalUnitsOfMeasureTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalUnitsOfMeasureTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalUnitsOfMeasureTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalUnitsOfMeasureTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> abbreviation = const Value.absent(),
            Value<String> unitType = const Value.absent(),
            Value<double?> conversionFactor = const Value.absent(),
            Value<String?> baseUnitId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUnitsOfMeasureCompanion(
            id: id,
            tenantId: tenantId,
            name: name,
            abbreviation: abbreviation,
            unitType: unitType,
            conversionFactor: conversionFactor,
            baseUnitId: baseUnitId,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String name,
            required String abbreviation,
            required String unitType,
            Value<double?> conversionFactor = const Value.absent(),
            Value<String?> baseUnitId = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalUnitsOfMeasureCompanion.insert(
            id: id,
            tenantId: tenantId,
            name: name,
            abbreviation: abbreviation,
            unitType: unitType,
            conversionFactor: conversionFactor,
            baseUnitId: baseUnitId,
            isActive: isActive,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$LocalUnitsOfMeasureTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalUnitsOfMeasureTable,
    LocalUnitsOfMeasureData,
    $$LocalUnitsOfMeasureTableFilterComposer,
    $$LocalUnitsOfMeasureTableOrderingComposer,
    $$LocalUnitsOfMeasureTableAnnotationComposer,
    $$LocalUnitsOfMeasureTableCreateCompanionBuilder,
    $$LocalUnitsOfMeasureTableUpdateCompanionBuilder,
    (
      LocalUnitsOfMeasureData,
      BaseReferences<_$AppDatabase, $LocalUnitsOfMeasureTable,
          LocalUnitsOfMeasureData>
    ),
    LocalUnitsOfMeasureData,
    PrefetchHooks Function()>;
typedef $$LocalProductsTableCreateCompanionBuilder = LocalProductsCompanion
    Function({
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
  Value<int> minStock,
  Value<int?> maxStock,
  Value<int?> reorderPoint,
  Value<bool> isActive,
  Value<bool> isSalable,
  Value<bool> isPurchasable,
  Value<bool> isReturnable,
  Value<bool> requiresCooling,
  Value<double?> storageTemperatureMin,
  Value<double?> storageTemperatureMax,
  Value<String?> nutritionalInfo,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalProductsTableUpdateCompanionBuilder = LocalProductsCompanion
    Function({
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
  Value<int> minStock,
  Value<int?> maxStock,
  Value<int?> reorderPoint,
  Value<bool> isActive,
  Value<bool> isSalable,
  Value<bool> isPurchasable,
  Value<bool> isReturnable,
  Value<bool> requiresCooling,
  Value<double?> storageTemperatureMin,
  Value<double?> storageTemperatureMax,
  Value<String?> nutritionalInfo,
  Value<DateTime?> lastSync,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalProductsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalProductsTable, LocalProduct> {
  $$LocalProductsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalProductVariantsTable,
      List<LocalProductVariant>> _localProductVariantsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.localProductVariants,
          aliasName: $_aliasNameGenerator(
              db.localProducts.id, db.localProductVariants.productId));

  $$LocalProductVariantsTableProcessedTableManager
      get localProductVariantsRefs {
    final manager = $$LocalProductVariantsTableTableManager(
            $_db, $_db.localProductVariants)
        .filter((f) => f.productId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localProductVariantsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcodeType => $composableBuilder(
      column: $table.barcodeType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get shortName => $composableBuilder(
      column: $table.shortName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get brandId => $composableBuilder(
      column: $table.brandId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasExpiry => $composableBuilder(
      column: $table.hasExpiry, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasBatchControl => $composableBuilder(
      column: $table.hasBatchControl,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get trackInventory => $composableBuilder(
      column: $table.trackInventory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minStock => $composableBuilder(
      column: $table.minStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxStock => $composableBuilder(
      column: $table.maxStock, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get reorderPoint => $composableBuilder(
      column: $table.reorderPoint, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isSalable => $composableBuilder(
      column: $table.isSalable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPurchasable => $composableBuilder(
      column: $table.isPurchasable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isReturnable => $composableBuilder(
      column: $table.isReturnable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get requiresCooling => $composableBuilder(
      column: $table.requiresCooling,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get storageTemperatureMin => $composableBuilder(
      column: $table.storageTemperatureMin,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get storageTemperatureMax => $composableBuilder(
      column: $table.storageTemperatureMax,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nutritionalInfo => $composableBuilder(
      column: $table.nutritionalInfo,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> localProductVariantsRefs(
      Expression<bool> Function($$LocalProductVariantsTableFilterComposer f)
          f) {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localProductVariants,
        getReferencedColumn: (t) => t.productId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductVariantsTableFilterComposer(
              $db: $db,
              $table: $db.localProductVariants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcodeType => $composableBuilder(
      column: $table.barcodeType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get shortName => $composableBuilder(
      column: $table.shortName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get brandId => $composableBuilder(
      column: $table.brandId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unitId => $composableBuilder(
      column: $table.unitId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasExpiry => $composableBuilder(
      column: $table.hasExpiry, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasBatchControl => $composableBuilder(
      column: $table.hasBatchControl,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get trackInventory => $composableBuilder(
      column: $table.trackInventory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minStock => $composableBuilder(
      column: $table.minStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxStock => $composableBuilder(
      column: $table.maxStock, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get reorderPoint => $composableBuilder(
      column: $table.reorderPoint,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isSalable => $composableBuilder(
      column: $table.isSalable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPurchasable => $composableBuilder(
      column: $table.isPurchasable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isReturnable => $composableBuilder(
      column: $table.isReturnable,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get requiresCooling => $composableBuilder(
      column: $table.requiresCooling,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get storageTemperatureMin => $composableBuilder(
      column: $table.storageTemperatureMin,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get storageTemperatureMax => $composableBuilder(
      column: $table.storageTemperatureMax,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nutritionalInfo => $composableBuilder(
      column: $table.nutritionalInfo,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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
      column: $table.barcodeType, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get shortName =>
      $composableBuilder(column: $table.shortName, builder: (column) => column);

  GeneratedColumn<String> get categoryId => $composableBuilder(
      column: $table.categoryId, builder: (column) => column);

  GeneratedColumn<String> get brandId =>
      $composableBuilder(column: $table.brandId, builder: (column) => column);

  GeneratedColumn<String> get unitId =>
      $composableBuilder(column: $table.unitId, builder: (column) => column);

  GeneratedColumn<bool> get hasExpiry =>
      $composableBuilder(column: $table.hasExpiry, builder: (column) => column);

  GeneratedColumn<bool> get hasBatchControl => $composableBuilder(
      column: $table.hasBatchControl, builder: (column) => column);

  GeneratedColumn<bool> get trackInventory => $composableBuilder(
      column: $table.trackInventory, builder: (column) => column);

  GeneratedColumn<int> get minStock =>
      $composableBuilder(column: $table.minStock, builder: (column) => column);

  GeneratedColumn<int> get maxStock =>
      $composableBuilder(column: $table.maxStock, builder: (column) => column);

  GeneratedColumn<int> get reorderPoint => $composableBuilder(
      column: $table.reorderPoint, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<bool> get isSalable =>
      $composableBuilder(column: $table.isSalable, builder: (column) => column);

  GeneratedColumn<bool> get isPurchasable => $composableBuilder(
      column: $table.isPurchasable, builder: (column) => column);

  GeneratedColumn<bool> get isReturnable => $composableBuilder(
      column: $table.isReturnable, builder: (column) => column);

  GeneratedColumn<bool> get requiresCooling => $composableBuilder(
      column: $table.requiresCooling, builder: (column) => column);

  GeneratedColumn<double> get storageTemperatureMin => $composableBuilder(
      column: $table.storageTemperatureMin, builder: (column) => column);

  GeneratedColumn<double> get storageTemperatureMax => $composableBuilder(
      column: $table.storageTemperatureMax, builder: (column) => column);

  GeneratedColumn<String> get nutritionalInfo => $composableBuilder(
      column: $table.nutritionalInfo, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> localProductVariantsRefs<T extends Object>(
      Expression<T> Function($$LocalProductVariantsTableAnnotationComposer a)
          f) {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.productId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LocalProductsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool localProductVariantsRefs})> {
  $$LocalProductsTableTableManager(_$AppDatabase db, $LocalProductsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
            Value<int> minStock = const Value.absent(),
            Value<int?> maxStock = const Value.absent(),
            Value<int?> reorderPoint = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSalable = const Value.absent(),
            Value<bool> isPurchasable = const Value.absent(),
            Value<bool> isReturnable = const Value.absent(),
            Value<bool> requiresCooling = const Value.absent(),
            Value<double?> storageTemperatureMin = const Value.absent(),
            Value<double?> storageTemperatureMax = const Value.absent(),
            Value<String?> nutritionalInfo = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductsCompanion(
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
            minStock: minStock,
            maxStock: maxStock,
            reorderPoint: reorderPoint,
            isActive: isActive,
            isSalable: isSalable,
            isPurchasable: isPurchasable,
            isReturnable: isReturnable,
            requiresCooling: requiresCooling,
            storageTemperatureMin: storageTemperatureMin,
            storageTemperatureMax: storageTemperatureMax,
            nutritionalInfo: nutritionalInfo,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
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
            Value<int> minStock = const Value.absent(),
            Value<int?> maxStock = const Value.absent(),
            Value<int?> reorderPoint = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<bool> isSalable = const Value.absent(),
            Value<bool> isPurchasable = const Value.absent(),
            Value<bool> isReturnable = const Value.absent(),
            Value<bool> requiresCooling = const Value.absent(),
            Value<double?> storageTemperatureMin = const Value.absent(),
            Value<double?> storageTemperatureMax = const Value.absent(),
            Value<String?> nutritionalInfo = const Value.absent(),
            Value<DateTime?> lastSync = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductsCompanion.insert(
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
            minStock: minStock,
            maxStock: maxStock,
            reorderPoint: reorderPoint,
            isActive: isActive,
            isSalable: isSalable,
            isPurchasable: isPurchasable,
            isReturnable: isReturnable,
            requiresCooling: requiresCooling,
            storageTemperatureMin: storageTemperatureMin,
            storageTemperatureMax: storageTemperatureMax,
            nutritionalInfo: nutritionalInfo,
            lastSync: lastSync,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalProductsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({localProductVariantsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localProductVariantsRefs) db.localProductVariants
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localProductVariantsRefs)
                    await $_getPrefetchedData<LocalProduct, $LocalProductsTable,
                            LocalProductVariant>(
                        currentTable: table,
                        referencedTable: $$LocalProductsTableReferences
                            ._localProductVariantsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalProductsTableReferences(db, table, p0)
                                .localProductVariantsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.productId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalProductsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool localProductVariantsRefs})>;
typedef $$LocalProductVariantsTableCreateCompanionBuilder
    = LocalProductVariantsCompanion Function({
  required String id,
  required String tenantId,
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalProductVariantsTableUpdateCompanionBuilder
    = LocalProductVariantsCompanion Function({
  Value<String> id,
  Value<String> tenantId,
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalProductVariantsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalProductVariantsTable, LocalProductVariant> {
  $$LocalProductVariantsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalProductsTable _productIdTable(_$AppDatabase db) =>
      db.localProducts.createAlias($_aliasNameGenerator(
          db.localProductVariants.productId, db.localProducts.id));

  $$LocalProductsTableProcessedTableManager get productId {
    final $_column = $_itemColumn<String>('product_id')!;

    final manager = $$LocalProductsTableTableManager($_db, $_db.localProducts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LocalPriceListItemsTable,
      List<LocalPriceListItem>> _localPriceListItemsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.localPriceListItems,
          aliasName: $_aliasNameGenerator(
              db.localProductVariants.id, db.localPriceListItems.variantId));

  $$LocalPriceListItemsTableProcessedTableManager get localPriceListItemsRefs {
    final manager = $$LocalPriceListItemsTableTableManager(
            $_db, $_db.localPriceListItems)
        .filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localPriceListItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalInventoryLotsTable, List<LocalInventoryLot>>
      _localInventoryLotsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localInventoryLots,
              aliasName: $_aliasNameGenerator(
                  db.localProductVariants.id, db.localInventoryLots.variantId));

  $$LocalInventoryLotsTableProcessedTableManager get localInventoryLotsRefs {
    final manager = $$LocalInventoryLotsTableTableManager(
            $_db, $_db.localInventoryLots)
        .filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localInventoryLotsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalInventoryMovementsTable,
      List<LocalInventoryMovement>> _localInventoryMovementsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.localInventoryMovements,
          aliasName: $_aliasNameGenerator(db.localProductVariants.id,
              db.localInventoryMovements.variantId));

  $$LocalInventoryMovementsTableProcessedTableManager
      get localInventoryMovementsRefs {
    final manager = $$LocalInventoryMovementsTableTableManager(
            $_db, $_db.localInventoryMovements)
        .filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localInventoryMovementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
      _localSaleItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localSaleItems,
              aliasName: $_aliasNameGenerator(
                  db.localProductVariants.id, db.localSaleItems.variantId));

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager($_db, $_db.localSaleItems)
        .filter((f) => f.variantId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get attributes => $composableBuilder(
      column: $table.attributes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get volumeLiters => $composableBuilder(
      column: $table.volumeLiters, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalProductsTableFilterComposer get productId {
    final $$LocalProductsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.localProducts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductsTableFilterComposer(
              $db: $db,
              $table: $db.localProducts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> localPriceListItemsRefs(
      Expression<bool> Function($$LocalPriceListItemsTableFilterComposer f) f) {
    final $$LocalPriceListItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localPriceListItems,
        getReferencedColumn: (t) => t.variantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListItemsTableFilterComposer(
              $db: $db,
              $table: $db.localPriceListItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> localInventoryLotsRefs(
      Expression<bool> Function($$LocalInventoryLotsTableFilterComposer f) f) {
    final $$LocalInventoryLotsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localInventoryLots,
        getReferencedColumn: (t) => t.variantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalInventoryLotsTableFilterComposer(
              $db: $db,
              $table: $db.localInventoryLots,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> localInventoryMovementsRefs(
      Expression<bool> Function($$LocalInventoryMovementsTableFilterComposer f)
          f) {
    final $$LocalInventoryMovementsTableFilterComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localInventoryMovements,
            getReferencedColumn: (t) => t.variantId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalInventoryMovementsTableFilterComposer(
                  $db: $db,
                  $table: $db.localInventoryMovements,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<bool> localSaleItemsRefs(
      Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSaleItems,
        getReferencedColumn: (t) => t.variantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSaleItemsTableFilterComposer(
              $db: $db,
              $table: $db.localSaleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get sku => $composableBuilder(
      column: $table.sku, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get barcode => $composableBuilder(
      column: $table.barcode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get attributes => $composableBuilder(
      column: $table.attributes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get weightKg => $composableBuilder(
      column: $table.weightKg, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get volumeLiters => $composableBuilder(
      column: $table.volumeLiters,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalProductsTableOrderingComposer get productId {
    final $$LocalProductsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.localProducts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductsTableOrderingComposer(
              $db: $db,
              $table: $db.localProducts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get sku =>
      $composableBuilder(column: $table.sku, builder: (column) => column);

  GeneratedColumn<String> get barcode =>
      $composableBuilder(column: $table.barcode, builder: (column) => column);

  GeneratedColumn<String> get attributes => $composableBuilder(
      column: $table.attributes, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<double> get volumeLiters => $composableBuilder(
      column: $table.volumeLiters, builder: (column) => column);

  GeneratedColumn<bool> get isDefault =>
      $composableBuilder(column: $table.isDefault, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalProductsTableAnnotationComposer get productId {
    final $$LocalProductsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.productId,
        referencedTable: $db.localProducts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductsTableAnnotationComposer(
              $db: $db,
              $table: $db.localProducts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> localPriceListItemsRefs<T extends Object>(
      Expression<T> Function($$LocalPriceListItemsTableAnnotationComposer a)
          f) {
    final $$LocalPriceListItemsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localPriceListItems,
            getReferencedColumn: (t) => t.variantId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalPriceListItemsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localPriceListItems,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> localInventoryLotsRefs<T extends Object>(
      Expression<T> Function($$LocalInventoryLotsTableAnnotationComposer a) f) {
    final $$LocalInventoryLotsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localInventoryLots,
            getReferencedColumn: (t) => t.variantId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalInventoryLotsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localInventoryLots,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> localInventoryMovementsRefs<T extends Object>(
      Expression<T> Function($$LocalInventoryMovementsTableAnnotationComposer a)
          f) {
    final $$LocalInventoryMovementsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localInventoryMovements,
            getReferencedColumn: (t) => t.variantId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalInventoryMovementsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localInventoryMovements,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> localSaleItemsRefs<T extends Object>(
      Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSaleItems,
        getReferencedColumn: (t) => t.variantId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSaleItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.localSaleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocalProductVariantsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool productId,
        bool localPriceListItemsRefs,
        bool localInventoryLotsRefs,
        bool localInventoryMovementsRefs,
        bool localSaleItemsRefs})> {
  $$LocalProductVariantsTableTableManager(
      _$AppDatabase db, $LocalProductVariantsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalProductVariantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalProductVariantsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalProductVariantsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductVariantsCompanion(
            id: id,
            tenantId: tenantId,
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalProductVariantsCompanion.insert(
            id: id,
            tenantId: tenantId,
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalProductVariantsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {productId = false,
              localPriceListItemsRefs = false,
              localInventoryLotsRefs = false,
              localInventoryMovementsRefs = false,
              localSaleItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localPriceListItemsRefs) db.localPriceListItems,
                if (localInventoryLotsRefs) db.localInventoryLots,
                if (localInventoryMovementsRefs) db.localInventoryMovements,
                if (localSaleItemsRefs) db.localSaleItems
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (productId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.productId,
                    referencedTable: $$LocalProductVariantsTableReferences
                        ._productIdTable(db),
                    referencedColumn: $$LocalProductVariantsTableReferences
                        ._productIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localPriceListItemsRefs)
                    await $_getPrefetchedData<LocalProductVariant,
                            $LocalProductVariantsTable, LocalPriceListItem>(
                        currentTable: table,
                        referencedTable: $$LocalProductVariantsTableReferences
                            ._localPriceListItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalProductVariantsTableReferences(db, table, p0)
                                .localPriceListItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.variantId == item.id),
                        typedResults: items),
                  if (localInventoryLotsRefs)
                    await $_getPrefetchedData<LocalProductVariant,
                            $LocalProductVariantsTable, LocalInventoryLot>(
                        currentTable: table,
                        referencedTable: $$LocalProductVariantsTableReferences
                            ._localInventoryLotsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalProductVariantsTableReferences(db, table, p0)
                                .localInventoryLotsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.variantId == item.id),
                        typedResults: items),
                  if (localInventoryMovementsRefs)
                    await $_getPrefetchedData<LocalProductVariant,
                            $LocalProductVariantsTable, LocalInventoryMovement>(
                        currentTable: table,
                        referencedTable: $$LocalProductVariantsTableReferences
                            ._localInventoryMovementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalProductVariantsTableReferences(db, table, p0)
                                .localInventoryMovementsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.variantId == item.id),
                        typedResults: items),
                  if (localSaleItemsRefs)
                    await $_getPrefetchedData<LocalProductVariant,
                            $LocalProductVariantsTable, LocalSaleItem>(
                        currentTable: table,
                        referencedTable: $$LocalProductVariantsTableReferences
                            ._localSaleItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalProductVariantsTableReferences(db, table, p0)
                                .localSaleItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.variantId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalProductVariantsTableProcessedTableManager
    = ProcessedTableManager<
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
        PrefetchHooks Function(
            {bool productId,
            bool localPriceListItemsRefs,
            bool localInventoryLotsRefs,
            bool localInventoryMovementsRefs,
            bool localSaleItemsRefs})>;
typedef $$LocalPriceListsTableCreateCompanionBuilder = LocalPriceListsCompanion
    Function({
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalPriceListsTableUpdateCompanionBuilder = LocalPriceListsCompanion
    Function({
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalPriceListsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalPriceListsTable, LocalPriceList> {
  $$LocalPriceListsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalPriceListItemsTable,
      List<LocalPriceListItem>> _localPriceListItemsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.localPriceListItems,
          aliasName: $_aliasNameGenerator(
              db.localPriceLists.id, db.localPriceListItems.priceListId));

  $$LocalPriceListItemsTableProcessedTableManager get localPriceListItemsRefs {
    final manager = $$LocalPriceListItemsTableTableManager(
            $_db, $_db.localPriceListItems)
        .filter((f) => f.priceListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localPriceListItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalCustomersTable, List<LocalCustomer>>
      _localCustomersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localCustomers,
              aliasName: $_aliasNameGenerator(
                  db.localPriceLists.id, db.localCustomers.priceListId));

  $$LocalCustomersTableProcessedTableManager get localCustomersRefs {
    final manager = $$LocalCustomersTableTableManager($_db, $_db.localCustomers)
        .filter((f) => f.priceListId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localCustomersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customerType => $composableBuilder(
      column: $table.customerType, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get validFrom => $composableBuilder(
      column: $table.validFrom, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get validTo => $composableBuilder(
      column: $table.validTo, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> localPriceListItemsRefs(
      Expression<bool> Function($$LocalPriceListItemsTableFilterComposer f) f) {
    final $$LocalPriceListItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localPriceListItems,
        getReferencedColumn: (t) => t.priceListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListItemsTableFilterComposer(
              $db: $db,
              $table: $db.localPriceListItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> localCustomersRefs(
      Expression<bool> Function($$LocalCustomersTableFilterComposer f) f) {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.priceListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableFilterComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerType => $composableBuilder(
      column: $table.customerType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isDefault => $composableBuilder(
      column: $table.isDefault, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get validFrom => $composableBuilder(
      column: $table.validFrom, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get validTo => $composableBuilder(
      column: $table.validTo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get customerType => $composableBuilder(
      column: $table.customerType, builder: (column) => column);

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

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> localPriceListItemsRefs<T extends Object>(
      Expression<T> Function($$LocalPriceListItemsTableAnnotationComposer a)
          f) {
    final $$LocalPriceListItemsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localPriceListItems,
            getReferencedColumn: (t) => t.priceListId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalPriceListItemsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localPriceListItems,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }

  Expression<T> localCustomersRefs<T extends Object>(
      Expression<T> Function($$LocalCustomersTableAnnotationComposer a) f) {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.priceListId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocalPriceListsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool localPriceListItemsRefs, bool localCustomersRefs})> {
  $$LocalPriceListsTableTableManager(
      _$AppDatabase db, $LocalPriceListsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPriceListsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPriceListsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPriceListsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalPriceListsCompanion(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalPriceListsCompanion.insert(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalPriceListsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {localPriceListItemsRefs = false, localCustomersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localPriceListItemsRefs) db.localPriceListItems,
                if (localCustomersRefs) db.localCustomers
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localPriceListItemsRefs)
                    await $_getPrefetchedData<LocalPriceList,
                            $LocalPriceListsTable, LocalPriceListItem>(
                        currentTable: table,
                        referencedTable: $$LocalPriceListsTableReferences
                            ._localPriceListItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalPriceListsTableReferences(db, table, p0)
                                .localPriceListItemsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.priceListId == item.id),
                        typedResults: items),
                  if (localCustomersRefs)
                    await $_getPrefetchedData<LocalPriceList,
                            $LocalPriceListsTable, LocalCustomer>(
                        currentTable: table,
                        referencedTable: $$LocalPriceListsTableReferences
                            ._localCustomersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalPriceListsTableReferences(db, table, p0)
                                .localCustomersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.priceListId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalPriceListsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function(
        {bool localPriceListItemsRefs, bool localCustomersRefs})>;
typedef $$LocalPriceListItemsTableCreateCompanionBuilder
    = LocalPriceListItemsCompanion Function({
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalPriceListItemsTableUpdateCompanionBuilder
    = LocalPriceListItemsCompanion Function({
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
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalPriceListItemsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalPriceListItemsTable, LocalPriceListItem> {
  $$LocalPriceListItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalPriceListsTable _priceListIdTable(_$AppDatabase db) =>
      db.localPriceLists.createAlias($_aliasNameGenerator(
          db.localPriceListItems.priceListId, db.localPriceLists.id));

  $$LocalPriceListsTableProcessedTableManager get priceListId {
    final $_column = $_itemColumn<String>('price_list_id')!;

    final manager =
        $$LocalPriceListsTableTableManager($_db, $_db.localPriceLists)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_priceListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias($_aliasNameGenerator(
          db.localPriceListItems.variantId, db.localProductVariants.id));

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager =
        $$LocalProductVariantsTableTableManager($_db, $_db.localProductVariants)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get minQuantity => $composableBuilder(
      column: $table.minQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get maxQuantity => $composableBuilder(
      column: $table.maxQuantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get volumeDiscountPercent => $composableBuilder(
      column: $table.volumeDiscountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalPriceListsTableFilterComposer get priceListId {
    final $$LocalPriceListsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.priceListId,
        referencedTable: $db.localPriceLists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableFilterComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variantId,
        referencedTable: $db.localProductVariants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductVariantsTableFilterComposer(
              $db: $db,
              $table: $db.localProductVariants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get price => $composableBuilder(
      column: $table.price, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get minQuantity => $composableBuilder(
      column: $table.minQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get maxQuantity => $composableBuilder(
      column: $table.maxQuantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get volumeDiscountPercent => $composableBuilder(
      column: $table.volumeDiscountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastSync => $composableBuilder(
      column: $table.lastSync, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalPriceListsTableOrderingComposer get priceListId {
    final $$LocalPriceListsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.priceListId,
        referencedTable: $db.localPriceLists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableOrderingComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableOrderingComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
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
      column: $table.minQuantity, builder: (column) => column);

  GeneratedColumn<int> get maxQuantity => $composableBuilder(
      column: $table.maxQuantity, builder: (column) => column);

  GeneratedColumn<double> get volumeDiscountPercent => $composableBuilder(
      column: $table.volumeDiscountPercent, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get lastSync =>
      $composableBuilder(column: $table.lastSync, builder: (column) => column);

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
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableAnnotationComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalPriceListItemsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool priceListId, bool variantId})> {
  $$LocalPriceListItemsTableTableManager(
      _$AppDatabase db, $LocalPriceListItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalPriceListItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalPriceListItemsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalPriceListItemsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalPriceListItemsCompanion(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
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
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalPriceListItemsCompanion.insert(
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
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalPriceListItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({priceListId = false, variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (priceListId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.priceListId,
                    referencedTable: $$LocalPriceListItemsTableReferences
                        ._priceListIdTable(db),
                    referencedColumn: $$LocalPriceListItemsTableReferences
                        ._priceListIdTable(db)
                        .id,
                  ) as T;
                }
                if (variantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.variantId,
                    referencedTable: $$LocalPriceListItemsTableReferences
                        ._variantIdTable(db),
                    referencedColumn: $$LocalPriceListItemsTableReferences
                        ._variantIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalPriceListItemsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool priceListId, bool variantId})>;
typedef $$LocalInventoryLotsTableCreateCompanionBuilder
    = LocalInventoryLotsCompanion Function({
  required String id,
  required String tenantId,
  required String lotNumber,
  required String variantId,
  Value<String?> purchaseInvoiceId,
  required String branchId,
  required int initialQuantity,
  required int currentQuantity,
  required double purchasePrice,
  Value<double?> unitCost,
  Value<DateTime?> productionDate,
  Value<DateTime?> expiryDate,
  Value<LotStatus> status,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalInventoryLotsTableUpdateCompanionBuilder
    = LocalInventoryLotsCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> lotNumber,
  Value<String> variantId,
  Value<String?> purchaseInvoiceId,
  Value<String> branchId,
  Value<int> initialQuantity,
  Value<int> currentQuantity,
  Value<double> purchasePrice,
  Value<double?> unitCost,
  Value<DateTime?> productionDate,
  Value<DateTime?> expiryDate,
  Value<LotStatus> status,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalInventoryLotsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalInventoryLotsTable, LocalInventoryLot> {
  $$LocalInventoryLotsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias($_aliasNameGenerator(
          db.localInventoryLots.variantId, db.localProductVariants.id));

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager =
        $$LocalProductVariantsTableTableManager($_db, $_db.localProductVariants)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LocalInventoryLotsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalInventoryLotsTable> {
  $$LocalInventoryLotsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lotNumber => $composableBuilder(
      column: $table.lotNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get purchaseInvoiceId => $composableBuilder(
      column: $table.purchaseInvoiceId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get initialQuantity => $composableBuilder(
      column: $table.initialQuantity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get currentQuantity => $composableBuilder(
      column: $table.currentQuantity,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get productionDate => $composableBuilder(
      column: $table.productionDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LotStatus, LotStatus, String> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variantId,
        referencedTable: $db.localProductVariants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductVariantsTableFilterComposer(
              $db: $db,
              $table: $db.localProductVariants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalInventoryLotsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalInventoryLotsTable> {
  $$LocalInventoryLotsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lotNumber => $composableBuilder(
      column: $table.lotNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get purchaseInvoiceId => $composableBuilder(
      column: $table.purchaseInvoiceId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get initialQuantity => $composableBuilder(
      column: $table.initialQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get currentQuantity => $composableBuilder(
      column: $table.currentQuantity,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get productionDate => $composableBuilder(
      column: $table.productionDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableOrderingComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalInventoryLotsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalInventoryLotsTable> {
  $$LocalInventoryLotsTableAnnotationComposer({
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

  GeneratedColumn<String> get lotNumber =>
      $composableBuilder(column: $table.lotNumber, builder: (column) => column);

  GeneratedColumn<String> get purchaseInvoiceId => $composableBuilder(
      column: $table.purchaseInvoiceId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumn<int> get initialQuantity => $composableBuilder(
      column: $table.initialQuantity, builder: (column) => column);

  GeneratedColumn<int> get currentQuantity => $composableBuilder(
      column: $table.currentQuantity, builder: (column) => column);

  GeneratedColumn<double> get purchasePrice => $composableBuilder(
      column: $table.purchasePrice, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<DateTime> get productionDate => $composableBuilder(
      column: $table.productionDate, builder: (column) => column);

  GeneratedColumn<DateTime> get expiryDate => $composableBuilder(
      column: $table.expiryDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LotStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalInventoryLotsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalInventoryLotsTable,
    LocalInventoryLot,
    $$LocalInventoryLotsTableFilterComposer,
    $$LocalInventoryLotsTableOrderingComposer,
    $$LocalInventoryLotsTableAnnotationComposer,
    $$LocalInventoryLotsTableCreateCompanionBuilder,
    $$LocalInventoryLotsTableUpdateCompanionBuilder,
    (LocalInventoryLot, $$LocalInventoryLotsTableReferences),
    LocalInventoryLot,
    PrefetchHooks Function({bool variantId})> {
  $$LocalInventoryLotsTableTableManager(
      _$AppDatabase db, $LocalInventoryLotsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalInventoryLotsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalInventoryLotsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalInventoryLotsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> lotNumber = const Value.absent(),
            Value<String> variantId = const Value.absent(),
            Value<String?> purchaseInvoiceId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<int> initialQuantity = const Value.absent(),
            Value<int> currentQuantity = const Value.absent(),
            Value<double> purchasePrice = const Value.absent(),
            Value<double?> unitCost = const Value.absent(),
            Value<DateTime?> productionDate = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<LotStatus> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryLotsCompanion(
            id: id,
            tenantId: tenantId,
            lotNumber: lotNumber,
            variantId: variantId,
            purchaseInvoiceId: purchaseInvoiceId,
            branchId: branchId,
            initialQuantity: initialQuantity,
            currentQuantity: currentQuantity,
            purchasePrice: purchasePrice,
            unitCost: unitCost,
            productionDate: productionDate,
            expiryDate: expiryDate,
            status: status,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String lotNumber,
            required String variantId,
            Value<String?> purchaseInvoiceId = const Value.absent(),
            required String branchId,
            required int initialQuantity,
            required int currentQuantity,
            required double purchasePrice,
            Value<double?> unitCost = const Value.absent(),
            Value<DateTime?> productionDate = const Value.absent(),
            Value<DateTime?> expiryDate = const Value.absent(),
            Value<LotStatus> status = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryLotsCompanion.insert(
            id: id,
            tenantId: tenantId,
            lotNumber: lotNumber,
            variantId: variantId,
            purchaseInvoiceId: purchaseInvoiceId,
            branchId: branchId,
            initialQuantity: initialQuantity,
            currentQuantity: currentQuantity,
            purchasePrice: purchasePrice,
            unitCost: unitCost,
            productionDate: productionDate,
            expiryDate: expiryDate,
            status: status,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalInventoryLotsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (variantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.variantId,
                    referencedTable:
                        $$LocalInventoryLotsTableReferences._variantIdTable(db),
                    referencedColumn: $$LocalInventoryLotsTableReferences
                        ._variantIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalInventoryLotsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalInventoryLotsTable,
    LocalInventoryLot,
    $$LocalInventoryLotsTableFilterComposer,
    $$LocalInventoryLotsTableOrderingComposer,
    $$LocalInventoryLotsTableAnnotationComposer,
    $$LocalInventoryLotsTableCreateCompanionBuilder,
    $$LocalInventoryLotsTableUpdateCompanionBuilder,
    (LocalInventoryLot, $$LocalInventoryLotsTableReferences),
    LocalInventoryLot,
    PrefetchHooks Function({bool variantId})>;
typedef $$LocalInventoryMovementsTableCreateCompanionBuilder
    = LocalInventoryMovementsCompanion Function({
  required String id,
  required String tenantId,
  Value<String?> lotId,
  required String branchId,
  required String variantId,
  required MovementType movementType,
  required int quantity,
  Value<String?> referenceType,
  Value<String?> referenceId,
  Value<String?> notes,
  Value<double?> unitCost,
  Value<double?> totalCost,
  Value<String?> createdBy,
  Value<DateTime> movementDate,
  required String localId,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LocalInventoryMovementsTableUpdateCompanionBuilder
    = LocalInventoryMovementsCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String?> lotId,
  Value<String> branchId,
  Value<String> variantId,
  Value<MovementType> movementType,
  Value<int> quantity,
  Value<String?> referenceType,
  Value<String?> referenceId,
  Value<String?> notes,
  Value<double?> unitCost,
  Value<double?> totalCost,
  Value<String?> createdBy,
  Value<DateTime> movementDate,
  Value<String> localId,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LocalInventoryMovementsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalInventoryMovementsTable, LocalInventoryMovement> {
  $$LocalInventoryMovementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias($_aliasNameGenerator(
          db.localInventoryMovements.variantId, db.localProductVariants.id));

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager =
        $$LocalProductVariantsTableTableManager($_db, $_db.localProductVariants)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lotId => $composableBuilder(
      column: $table.lotId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<MovementType, MovementType, String>
      get movementType => $composableBuilder(
          column: $table.movementType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceType => $composableBuilder(
      column: $table.referenceType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalCost => $composableBuilder(
      column: $table.totalCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get movementDate => $composableBuilder(
      column: $table.movementDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variantId,
        referencedTable: $db.localProductVariants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductVariantsTableFilterComposer(
              $db: $db,
              $table: $db.localProductVariants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lotId => $composableBuilder(
      column: $table.lotId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movementType => $composableBuilder(
      column: $table.movementType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceType => $composableBuilder(
      column: $table.referenceType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitCost => $composableBuilder(
      column: $table.unitCost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalCost => $composableBuilder(
      column: $table.totalCost, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get movementDate => $composableBuilder(
      column: $table.movementDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableOrderingComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
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

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MovementType, String> get movementType =>
      $composableBuilder(
          column: $table.movementType, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get referenceType => $composableBuilder(
      column: $table.referenceType, builder: (column) => column);

  GeneratedColumn<String> get referenceId => $composableBuilder(
      column: $table.referenceId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<double> get unitCost =>
      $composableBuilder(column: $table.unitCost, builder: (column) => column);

  GeneratedColumn<double> get totalCost =>
      $composableBuilder(column: $table.totalCost, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

  GeneratedColumn<DateTime> get movementDate => $composableBuilder(
      column: $table.movementDate, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalInventoryMovementsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool variantId})> {
  $$LocalInventoryMovementsTableTableManager(
      _$AppDatabase db, $LocalInventoryMovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalInventoryMovementsTableFilterComposer(
                  $db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalInventoryMovementsTableOrderingComposer(
                  $db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalInventoryMovementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String?> lotId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> variantId = const Value.absent(),
            Value<MovementType> movementType = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<String?> referenceType = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> unitCost = const Value.absent(),
            Value<double?> totalCost = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<DateTime> movementDate = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryMovementsCompanion(
            id: id,
            tenantId: tenantId,
            lotId: lotId,
            branchId: branchId,
            variantId: variantId,
            movementType: movementType,
            quantity: quantity,
            referenceType: referenceType,
            referenceId: referenceId,
            notes: notes,
            unitCost: unitCost,
            totalCost: totalCost,
            createdBy: createdBy,
            movementDate: movementDate,
            localId: localId,
            synced: synced,
            syncedAt: syncedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            Value<String?> lotId = const Value.absent(),
            required String branchId,
            required String variantId,
            required MovementType movementType,
            required int quantity,
            Value<String?> referenceType = const Value.absent(),
            Value<String?> referenceId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<double?> unitCost = const Value.absent(),
            Value<double?> totalCost = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<DateTime> movementDate = const Value.absent(),
            required String localId,
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalInventoryMovementsCompanion.insert(
            id: id,
            tenantId: tenantId,
            lotId: lotId,
            branchId: branchId,
            variantId: variantId,
            movementType: movementType,
            quantity: quantity,
            referenceType: referenceType,
            referenceId: referenceId,
            notes: notes,
            unitCost: unitCost,
            totalCost: totalCost,
            createdBy: createdBy,
            movementDate: movementDate,
            localId: localId,
            synced: synced,
            syncedAt: syncedAt,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalInventoryMovementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (variantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.variantId,
                    referencedTable: $$LocalInventoryMovementsTableReferences
                        ._variantIdTable(db),
                    referencedColumn: $$LocalInventoryMovementsTableReferences
                        ._variantIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalInventoryMovementsTableProcessedTableManager
    = ProcessedTableManager<
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
        PrefetchHooks Function({bool variantId})>;
typedef $$LocalCustomersTableCreateCompanionBuilder = LocalCustomersCompanion
    Function({
  required String id,
  required String tenantId,
  required String code,
  required CustomerType customerType,
  required String fullName,
  Value<String?> tradeName,
  Value<String?> taxId,
  Value<String?> documentType,
  Value<String?> documentNumber,
  Value<String?> email,
  Value<String?> phoneNumber,
  Value<String?> whatsapp,
  Value<String?> address,
  Value<String?> city,
  Value<String?> deliveryZone,
  Value<double> creditLimit,
  Value<int> creditDays,
  Value<double> currentCredit,
  Value<String?> priceListId,
  Value<CustomerStatus> status,
  Value<double> totalPurchases,
  Value<int> totalOrders,
  Value<DateTime?> lastPurchaseDate,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalCustomersTableUpdateCompanionBuilder = LocalCustomersCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> code,
  Value<CustomerType> customerType,
  Value<String> fullName,
  Value<String?> tradeName,
  Value<String?> taxId,
  Value<String?> documentType,
  Value<String?> documentNumber,
  Value<String?> email,
  Value<String?> phoneNumber,
  Value<String?> whatsapp,
  Value<String?> address,
  Value<String?> city,
  Value<String?> deliveryZone,
  Value<double> creditLimit,
  Value<int> creditDays,
  Value<double> currentCredit,
  Value<String?> priceListId,
  Value<CustomerStatus> status,
  Value<double> totalPurchases,
  Value<int> totalOrders,
  Value<DateTime?> lastPurchaseDate,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalCustomersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalCustomersTable, LocalCustomer> {
  $$LocalCustomersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalPriceListsTable _priceListIdTable(_$AppDatabase db) =>
      db.localPriceLists.createAlias($_aliasNameGenerator(
          db.localCustomers.priceListId, db.localPriceLists.id));

  $$LocalPriceListsTableProcessedTableManager? get priceListId {
    final $_column = $_itemColumn<String>('price_list_id');
    if ($_column == null) return null;
    final manager =
        $$LocalPriceListsTableTableManager($_db, $_db.localPriceLists)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_priceListIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LocalSalesTable, List<LocalSale>>
      _localSalesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localSales,
              aliasName: $_aliasNameGenerator(
                  db.localCustomers.id, db.localSales.customerId));

  $$LocalSalesTableProcessedTableManager get localSalesRefs {
    final manager = $$LocalSalesTableTableManager($_db, $_db.localSales)
        .filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSalesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalOrdersTable, List<LocalOrder>>
      _localOrdersRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localOrders,
              aliasName: $_aliasNameGenerator(
                  db.localCustomers.id, db.localOrders.customerId));

  $$LocalOrdersTableProcessedTableManager get localOrdersRefs {
    final manager = $$LocalOrdersTableTableManager($_db, $_db.localOrders)
        .filter((f) => f.customerId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localOrdersRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CustomerType, CustomerType, String>
      get customerType => $composableBuilder(
          column: $table.customerType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tradeName => $composableBuilder(
      column: $table.tradeName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get taxId => $composableBuilder(
      column: $table.taxId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documentType => $composableBuilder(
      column: $table.documentType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get documentNumber => $composableBuilder(
      column: $table.documentNumber,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get creditDays => $composableBuilder(
      column: $table.creditDays, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentCredit => $composableBuilder(
      column: $table.currentCredit, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CustomerStatus, CustomerStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get totalPurchases => $composableBuilder(
      column: $table.totalPurchases,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastPurchaseDate => $composableBuilder(
      column: $table.lastPurchaseDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalPriceListsTableFilterComposer get priceListId {
    final $$LocalPriceListsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.priceListId,
        referencedTable: $db.localPriceLists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableFilterComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> localSalesRefs(
      Expression<bool> Function($$LocalSalesTableFilterComposer f) f) {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableFilterComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> localOrdersRefs(
      Expression<bool> Function($$LocalOrdersTableFilterComposer f) f) {
    final $$LocalOrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localOrders,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrdersTableFilterComposer(
              $db: $db,
              $table: $db.localOrders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customerType => $composableBuilder(
      column: $table.customerType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fullName => $composableBuilder(
      column: $table.fullName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tradeName => $composableBuilder(
      column: $table.tradeName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get taxId => $composableBuilder(
      column: $table.taxId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documentType => $composableBuilder(
      column: $table.documentType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get documentNumber => $composableBuilder(
      column: $table.documentNumber,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get whatsapp => $composableBuilder(
      column: $table.whatsapp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get address => $composableBuilder(
      column: $table.address, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get city => $composableBuilder(
      column: $table.city, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get creditDays => $composableBuilder(
      column: $table.creditDays, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentCredit => $composableBuilder(
      column: $table.currentCredit,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalPurchases => $composableBuilder(
      column: $table.totalPurchases,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastPurchaseDate => $composableBuilder(
      column: $table.lastPurchaseDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalPriceListsTableOrderingComposer get priceListId {
    final $$LocalPriceListsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.priceListId,
        referencedTable: $db.localPriceLists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableOrderingComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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

  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CustomerType, String> get customerType =>
      $composableBuilder(
          column: $table.customerType, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get tradeName =>
      $composableBuilder(column: $table.tradeName, builder: (column) => column);

  GeneratedColumn<String> get taxId =>
      $composableBuilder(column: $table.taxId, builder: (column) => column);

  GeneratedColumn<String> get documentType => $composableBuilder(
      column: $table.documentType, builder: (column) => column);

  GeneratedColumn<String> get documentNumber => $composableBuilder(
      column: $table.documentNumber, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
      column: $table.phoneNumber, builder: (column) => column);

  GeneratedColumn<String> get whatsapp =>
      $composableBuilder(column: $table.whatsapp, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone, builder: (column) => column);

  GeneratedColumn<double> get creditLimit => $composableBuilder(
      column: $table.creditLimit, builder: (column) => column);

  GeneratedColumn<int> get creditDays => $composableBuilder(
      column: $table.creditDays, builder: (column) => column);

  GeneratedColumn<double> get currentCredit => $composableBuilder(
      column: $table.currentCredit, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CustomerStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get totalPurchases => $composableBuilder(
      column: $table.totalPurchases, builder: (column) => column);

  GeneratedColumn<int> get totalOrders => $composableBuilder(
      column: $table.totalOrders, builder: (column) => column);

  GeneratedColumn<DateTime> get lastPurchaseDate => $composableBuilder(
      column: $table.lastPurchaseDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalPriceListsTableAnnotationComposer(
              $db: $db,
              $table: $db.localPriceLists,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> localSalesRefs<T extends Object>(
      Expression<T> Function($$LocalSalesTableAnnotationComposer a) f) {
    final $$LocalSalesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableAnnotationComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> localOrdersRefs<T extends Object>(
      Expression<T> Function($$LocalOrdersTableAnnotationComposer a) f) {
    final $$LocalOrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localOrders,
        getReferencedColumn: (t) => t.customerId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.localOrders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocalCustomersTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool priceListId, bool localSalesRefs, bool localOrdersRefs})> {
  $$LocalCustomersTableTableManager(
      _$AppDatabase db, $LocalCustomersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCustomersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCustomersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCustomersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<CustomerType> customerType = const Value.absent(),
            Value<String> fullName = const Value.absent(),
            Value<String?> tradeName = const Value.absent(),
            Value<String?> taxId = const Value.absent(),
            Value<String?> documentType = const Value.absent(),
            Value<String?> documentNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> whatsapp = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> deliveryZone = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            Value<int> creditDays = const Value.absent(),
            Value<double> currentCredit = const Value.absent(),
            Value<String?> priceListId = const Value.absent(),
            Value<CustomerStatus> status = const Value.absent(),
            Value<double> totalPurchases = const Value.absent(),
            Value<int> totalOrders = const Value.absent(),
            Value<DateTime?> lastPurchaseDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCustomersCompanion(
            id: id,
            tenantId: tenantId,
            code: code,
            customerType: customerType,
            fullName: fullName,
            tradeName: tradeName,
            taxId: taxId,
            documentType: documentType,
            documentNumber: documentNumber,
            email: email,
            phoneNumber: phoneNumber,
            whatsapp: whatsapp,
            address: address,
            city: city,
            deliveryZone: deliveryZone,
            creditLimit: creditLimit,
            creditDays: creditDays,
            currentCredit: currentCredit,
            priceListId: priceListId,
            status: status,
            totalPurchases: totalPurchases,
            totalOrders: totalOrders,
            lastPurchaseDate: lastPurchaseDate,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String code,
            required CustomerType customerType,
            required String fullName,
            Value<String?> tradeName = const Value.absent(),
            Value<String?> taxId = const Value.absent(),
            Value<String?> documentType = const Value.absent(),
            Value<String?> documentNumber = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phoneNumber = const Value.absent(),
            Value<String?> whatsapp = const Value.absent(),
            Value<String?> address = const Value.absent(),
            Value<String?> city = const Value.absent(),
            Value<String?> deliveryZone = const Value.absent(),
            Value<double> creditLimit = const Value.absent(),
            Value<int> creditDays = const Value.absent(),
            Value<double> currentCredit = const Value.absent(),
            Value<String?> priceListId = const Value.absent(),
            Value<CustomerStatus> status = const Value.absent(),
            Value<double> totalPurchases = const Value.absent(),
            Value<int> totalOrders = const Value.absent(),
            Value<DateTime?> lastPurchaseDate = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCustomersCompanion.insert(
            id: id,
            tenantId: tenantId,
            code: code,
            customerType: customerType,
            fullName: fullName,
            tradeName: tradeName,
            taxId: taxId,
            documentType: documentType,
            documentNumber: documentNumber,
            email: email,
            phoneNumber: phoneNumber,
            whatsapp: whatsapp,
            address: address,
            city: city,
            deliveryZone: deliveryZone,
            creditLimit: creditLimit,
            creditDays: creditDays,
            currentCredit: currentCredit,
            priceListId: priceListId,
            status: status,
            totalPurchases: totalPurchases,
            totalOrders: totalOrders,
            lastPurchaseDate: lastPurchaseDate,
            notes: notes,
            synced: synced,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalCustomersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {priceListId = false,
              localSalesRefs = false,
              localOrdersRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localSalesRefs) db.localSales,
                if (localOrdersRefs) db.localOrders
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (priceListId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.priceListId,
                    referencedTable:
                        $$LocalCustomersTableReferences._priceListIdTable(db),
                    referencedColumn: $$LocalCustomersTableReferences
                        ._priceListIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localSalesRefs)
                    await $_getPrefetchedData<LocalCustomer,
                            $LocalCustomersTable, LocalSale>(
                        currentTable: table,
                        referencedTable: $$LocalCustomersTableReferences
                            ._localSalesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalCustomersTableReferences(db, table, p0)
                                .localSalesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items),
                  if (localOrdersRefs)
                    await $_getPrefetchedData<LocalCustomer,
                            $LocalCustomersTable, LocalOrder>(
                        currentTable: table,
                        referencedTable: $$LocalCustomersTableReferences
                            ._localOrdersRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalCustomersTableReferences(db, table, p0)
                                .localOrdersRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.customerId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalCustomersTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function(
        {bool priceListId, bool localSalesRefs, bool localOrdersRefs})>;
typedef $$LocalSalesTableCreateCompanionBuilder = LocalSalesCompanion Function({
  required String id,
  required String tenantId,
  required String branchId,
  Value<String?> saleNumber,
  Value<String?> customerId,
  Value<DateTime> saleDate,
  Value<SaleType> saleType,
  Value<SaleStatus> status,
  Value<double> subtotal,
  Value<double> discountPercent,
  Value<double> discountAmount,
  Value<double> taxAmount,
  Value<double> totalAmount,
  required String cashierId,
  Value<String?> notes,
  Value<String?> internalNotes,
  required String localId,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalSalesTableUpdateCompanionBuilder = LocalSalesCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String?> saleNumber,
  Value<String?> customerId,
  Value<DateTime> saleDate,
  Value<SaleType> saleType,
  Value<SaleStatus> status,
  Value<double> subtotal,
  Value<double> discountPercent,
  Value<double> discountAmount,
  Value<double> taxAmount,
  Value<double> totalAmount,
  Value<String> cashierId,
  Value<String?> notes,
  Value<String?> internalNotes,
  Value<String> localId,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalSalesTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSalesTable, LocalSale> {
  $$LocalSalesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalCustomersTable _customerIdTable(_$AppDatabase db) =>
      db.localCustomers.createAlias(
          $_aliasNameGenerator(db.localSales.customerId, db.localCustomers.id));

  $$LocalCustomersTableProcessedTableManager? get customerId {
    final $_column = $_itemColumn<String>('customer_id');
    if ($_column == null) return null;
    final manager = $$LocalCustomersTableTableManager($_db, $_db.localCustomers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LocalSaleItemsTable, List<LocalSaleItem>>
      _localSaleItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localSaleItems,
              aliasName: $_aliasNameGenerator(
                  db.localSales.id, db.localSaleItems.saleId));

  $$LocalSaleItemsTableProcessedTableManager get localSaleItemsRefs {
    final manager = $$LocalSaleItemsTableTableManager($_db, $_db.localSaleItems)
        .filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_localSaleItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$LocalSalePaymentsTable, List<LocalSalePayment>>
      _localSalePaymentsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localSalePayments,
              aliasName: $_aliasNameGenerator(
                  db.localSales.id, db.localSalePayments.saleId));

  $$LocalSalePaymentsTableProcessedTableManager get localSalePaymentsRefs {
    final manager =
        $$LocalSalePaymentsTableTableManager($_db, $_db.localSalePayments)
            .filter((f) => f.saleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localSalePaymentsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get saleNumber => $composableBuilder(
      column: $table.saleNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get saleDate => $composableBuilder(
      column: $table.saleDate, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SaleType, SaleType, String> get saleType =>
      $composableBuilder(
          column: $table.saleType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<SaleStatus, SaleStatus, String> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cashierId => $composableBuilder(
      column: $table.cashierId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalCustomersTableFilterComposer get customerId {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableFilterComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> localSaleItemsRefs(
      Expression<bool> Function($$LocalSaleItemsTableFilterComposer f) f) {
    final $$LocalSaleItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSaleItems,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSaleItemsTableFilterComposer(
              $db: $db,
              $table: $db.localSaleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> localSalePaymentsRefs(
      Expression<bool> Function($$LocalSalePaymentsTableFilterComposer f) f) {
    final $$LocalSalePaymentsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSalePayments,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalePaymentsTableFilterComposer(
              $db: $db,
              $table: $db.localSalePayments,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saleNumber => $composableBuilder(
      column: $table.saleNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get saleDate => $composableBuilder(
      column: $table.saleDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get saleType => $composableBuilder(
      column: $table.saleType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cashierId => $composableBuilder(
      column: $table.cashierId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalCustomersTableOrderingComposer get customerId {
    final $$LocalCustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableOrderingComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
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
      column: $table.saleNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get saleDate =>
      $composableBuilder(column: $table.saleDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SaleType, String> get saleType =>
      $composableBuilder(column: $table.saleType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SaleStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent, builder: (column) => column);

  GeneratedColumn<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumn<String> get cashierId =>
      $composableBuilder(column: $table.cashierId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get internalNotes => $composableBuilder(
      column: $table.internalNotes, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$LocalCustomersTableAnnotationComposer get customerId {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> localSaleItemsRefs<T extends Object>(
      Expression<T> Function($$LocalSaleItemsTableAnnotationComposer a) f) {
    final $$LocalSaleItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localSaleItems,
        getReferencedColumn: (t) => t.saleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSaleItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.localSaleItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> localSalePaymentsRefs<T extends Object>(
      Expression<T> Function($$LocalSalePaymentsTableAnnotationComposer a) f) {
    final $$LocalSalePaymentsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localSalePayments,
            getReferencedColumn: (t) => t.saleId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalSalePaymentsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localSalePayments,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LocalSalesTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool customerId,
        bool localSaleItemsRefs,
        bool localSalePaymentsRefs})> {
  $$LocalSalesTableTableManager(_$AppDatabase db, $LocalSalesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String?> saleNumber = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<DateTime> saleDate = const Value.absent(),
            Value<SaleType> saleType = const Value.absent(),
            Value<SaleStatus> status = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            Value<double> taxAmount = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<String> cashierId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<String?> internalNotes = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSalesCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            saleNumber: saleNumber,
            customerId: customerId,
            saleDate: saleDate,
            saleType: saleType,
            status: status,
            subtotal: subtotal,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            taxAmount: taxAmount,
            totalAmount: totalAmount,
            cashierId: cashierId,
            notes: notes,
            internalNotes: internalNotes,
            localId: localId,
            synced: synced,
            syncedAt: syncedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            Value<String?> saleNumber = const Value.absent(),
            Value<String?> customerId = const Value.absent(),
            Value<DateTime> saleDate = const Value.absent(),
            Value<SaleType> saleType = const Value.absent(),
            Value<SaleStatus> status = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            Value<double> taxAmount = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            required String cashierId,
            Value<String?> notes = const Value.absent(),
            Value<String?> internalNotes = const Value.absent(),
            required String localId,
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSalesCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            saleNumber: saleNumber,
            customerId: customerId,
            saleDate: saleDate,
            saleType: saleType,
            status: status,
            subtotal: subtotal,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            taxAmount: taxAmount,
            totalAmount: totalAmount,
            cashierId: cashierId,
            notes: notes,
            internalNotes: internalNotes,
            localId: localId,
            synced: synced,
            syncedAt: syncedAt,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalSalesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {customerId = false,
              localSaleItemsRefs = false,
              localSalePaymentsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localSaleItemsRefs) db.localSaleItems,
                if (localSalePaymentsRefs) db.localSalePayments
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$LocalSalesTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$LocalSalesTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localSaleItemsRefs)
                    await $_getPrefetchedData<LocalSale, $LocalSalesTable,
                            LocalSaleItem>(
                        currentTable: table,
                        referencedTable: $$LocalSalesTableReferences
                            ._localSaleItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalSalesTableReferences(db, table, p0)
                                .localSaleItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.saleId == item.id),
                        typedResults: items),
                  if (localSalePaymentsRefs)
                    await $_getPrefetchedData<LocalSale, $LocalSalesTable,
                            LocalSalePayment>(
                        currentTable: table,
                        referencedTable: $$LocalSalesTableReferences
                            ._localSalePaymentsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalSalesTableReferences(db, table, p0)
                                .localSalePaymentsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.saleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalSalesTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function(
        {bool customerId,
        bool localSaleItemsRefs,
        bool localSalePaymentsRefs})>;
typedef $$LocalSaleItemsTableCreateCompanionBuilder = LocalSaleItemsCompanion
    Function({
  required String id,
  Value<String?> tenantId,
  required String saleId,
  Value<String?> lotId,
  required String variantId,
  required int quantity,
  required double unitPrice,
  Value<double?> costPrice,
  Value<double> discountPercent,
  Value<double> discountAmount,
  required double subtotal,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LocalSaleItemsTableUpdateCompanionBuilder = LocalSaleItemsCompanion
    Function({
  Value<String> id,
  Value<String?> tenantId,
  Value<String> saleId,
  Value<String?> lotId,
  Value<String> variantId,
  Value<int> quantity,
  Value<double> unitPrice,
  Value<double?> costPrice,
  Value<double> discountPercent,
  Value<double> discountAmount,
  Value<double> subtotal,
  Value<bool> synced,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LocalSaleItemsTableReferences
    extends BaseReferences<_$AppDatabase, $LocalSaleItemsTable, LocalSaleItem> {
  $$LocalSaleItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalSalesTable _saleIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
          $_aliasNameGenerator(db.localSaleItems.saleId, db.localSales.id));

  $$LocalSalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$LocalSalesTableTableManager($_db, $_db.localSales)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $LocalProductVariantsTable _variantIdTable(_$AppDatabase db) =>
      db.localProductVariants.createAlias($_aliasNameGenerator(
          db.localSaleItems.variantId, db.localProductVariants.id));

  $$LocalProductVariantsTableProcessedTableManager get variantId {
    final $_column = $_itemColumn<String>('variant_id')!;

    final manager =
        $$LocalProductVariantsTableTableManager($_db, $_db.localProductVariants)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_variantIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lotId => $composableBuilder(
      column: $table.lotId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LocalSalesTableFilterComposer get saleId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableFilterComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableFilterComposer get variantId {
    final $$LocalProductVariantsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.variantId,
        referencedTable: $db.localProductVariants,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalProductVariantsTableFilterComposer(
              $db: $db,
              $table: $db.localProductVariants,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lotId => $composableBuilder(
      column: $table.lotId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get costPrice => $composableBuilder(
      column: $table.costPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LocalSalesTableOrderingComposer get saleId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableOrderingComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableOrderingComposer get variantId {
    final $$LocalProductVariantsTableOrderingComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableOrderingComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumn<String> get lotId =>
      $composableBuilder(column: $table.lotId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get costPrice =>
      $composableBuilder(column: $table.costPrice, builder: (column) => column);

  GeneratedColumn<double> get discountPercent => $composableBuilder(
      column: $table.discountPercent, builder: (column) => column);

  GeneratedColumn<double> get discountAmount => $composableBuilder(
      column: $table.discountAmount, builder: (column) => column);

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
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableAnnotationComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$LocalProductVariantsTableAnnotationComposer get variantId {
    final $$LocalProductVariantsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.variantId,
            referencedTable: $db.localProductVariants,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalProductVariantsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localProductVariants,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalSaleItemsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool saleId, bool variantId})> {
  $$LocalSaleItemsTableTableManager(
      _$AppDatabase db, $LocalSaleItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSaleItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSaleItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSaleItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> tenantId = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<String?> lotId = const Value.absent(),
            Value<String> variantId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<double?> costPrice = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSaleItemsCompanion(
            id: id,
            tenantId: tenantId,
            saleId: saleId,
            lotId: lotId,
            variantId: variantId,
            quantity: quantity,
            unitPrice: unitPrice,
            costPrice: costPrice,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            subtotal: subtotal,
            synced: synced,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> tenantId = const Value.absent(),
            required String saleId,
            Value<String?> lotId = const Value.absent(),
            required String variantId,
            required int quantity,
            required double unitPrice,
            Value<double?> costPrice = const Value.absent(),
            Value<double> discountPercent = const Value.absent(),
            Value<double> discountAmount = const Value.absent(),
            required double subtotal,
            Value<bool> synced = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSaleItemsCompanion.insert(
            id: id,
            tenantId: tenantId,
            saleId: saleId,
            lotId: lotId,
            variantId: variantId,
            quantity: quantity,
            unitPrice: unitPrice,
            costPrice: costPrice,
            discountPercent: discountPercent,
            discountAmount: discountAmount,
            subtotal: subtotal,
            synced: synced,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalSaleItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({saleId = false, variantId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (saleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.saleId,
                    referencedTable:
                        $$LocalSaleItemsTableReferences._saleIdTable(db),
                    referencedColumn:
                        $$LocalSaleItemsTableReferences._saleIdTable(db).id,
                  ) as T;
                }
                if (variantId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.variantId,
                    referencedTable:
                        $$LocalSaleItemsTableReferences._variantIdTable(db),
                    referencedColumn:
                        $$LocalSaleItemsTableReferences._variantIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalSaleItemsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool saleId, bool variantId})>;
typedef $$LocalSalePaymentsTableCreateCompanionBuilder
    = LocalSalePaymentsCompanion Function({
  required String id,
  Value<String?> tenantId,
  required String saleId,
  required PaymentMethod paymentMethod,
  required double amount,
  Value<String?> reference,
  Value<String?> cardLastFour,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  required String localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LocalSalePaymentsTableUpdateCompanionBuilder
    = LocalSalePaymentsCompanion Function({
  Value<String> id,
  Value<String?> tenantId,
  Value<String> saleId,
  Value<PaymentMethod> paymentMethod,
  Value<double> amount,
  Value<String?> reference,
  Value<String?> cardLastFour,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<String> localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LocalSalePaymentsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalSalePaymentsTable, LocalSalePayment> {
  $$LocalSalePaymentsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalSalesTable _saleIdTable(_$AppDatabase db) =>
      db.localSales.createAlias(
          $_aliasNameGenerator(db.localSalePayments.saleId, db.localSales.id));

  $$LocalSalesTableProcessedTableManager get saleId {
    final $_column = $_itemColumn<String>('sale_id')!;

    final manager = $$LocalSalesTableTableManager($_db, $_db.localSales)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_saleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentMethod, PaymentMethod, String>
      get paymentMethod => $composableBuilder(
          column: $table.paymentMethod,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get cardLastFour => $composableBuilder(
      column: $table.cardLastFour, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LocalSalesTableFilterComposer get saleId {
    final $$LocalSalesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableFilterComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
      column: $table.paymentMethod,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get cardLastFour => $composableBuilder(
      column: $table.cardLastFour,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LocalSalesTableOrderingComposer get saleId {
    final $$LocalSalesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.saleId,
        referencedTable: $db.localSales,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableOrderingComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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

  GeneratedColumn<String> get tenantId =>
      $composableBuilder(column: $table.tenantId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentMethod, String> get paymentMethod =>
      $composableBuilder(
          column: $table.paymentMethod, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get cardLastFour => $composableBuilder(
      column: $table.cardLastFour, builder: (column) => column);

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
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalSalesTableAnnotationComposer(
              $db: $db,
              $table: $db.localSales,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalSalePaymentsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool saleId})> {
  $$LocalSalePaymentsTableTableManager(
      _$AppDatabase db, $LocalSalePaymentsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalSalePaymentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalSalePaymentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalSalePaymentsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String?> tenantId = const Value.absent(),
            Value<String> saleId = const Value.absent(),
            Value<PaymentMethod> paymentMethod = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> cardLastFour = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSalePaymentsCompanion(
            id: id,
            tenantId: tenantId,
            saleId: saleId,
            paymentMethod: paymentMethod,
            amount: amount,
            reference: reference,
            cardLastFour: cardLastFour,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            Value<String?> tenantId = const Value.absent(),
            required String saleId,
            required PaymentMethod paymentMethod,
            required double amount,
            Value<String?> reference = const Value.absent(),
            Value<String?> cardLastFour = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            required String localId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalSalePaymentsCompanion.insert(
            id: id,
            tenantId: tenantId,
            saleId: saleId,
            paymentMethod: paymentMethod,
            amount: amount,
            reference: reference,
            cardLastFour: cardLastFour,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalSalePaymentsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({saleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (saleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.saleId,
                    referencedTable:
                        $$LocalSalePaymentsTableReferences._saleIdTable(db),
                    referencedColumn:
                        $$LocalSalePaymentsTableReferences._saleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalSalePaymentsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool saleId})>;
typedef $$LocalOrdersTableCreateCompanionBuilder = LocalOrdersCompanion
    Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String orderNumber,
  required String customerId,
  Value<DateTime> orderDate,
  Value<DateTime?> requestedDeliveryDate,
  Value<DateTime?> actualDeliveryDate,
  Value<OrderStatus> status,
  Value<String?> deliveryAddress,
  Value<String?> deliveryNotes,
  Value<String?> deliveryZone,
  Value<double> subtotal,
  Value<double> shippingCost,
  Value<double> taxAmount,
  Value<double> totalAmount,
  Value<PaymentStatus> paymentStatus,
  Value<double> amountPaid,
  Value<String?> salesRepId,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  required String localId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});
typedef $$LocalOrdersTableUpdateCompanionBuilder = LocalOrdersCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> orderNumber,
  Value<String> customerId,
  Value<DateTime> orderDate,
  Value<DateTime?> requestedDeliveryDate,
  Value<DateTime?> actualDeliveryDate,
  Value<OrderStatus> status,
  Value<String?> deliveryAddress,
  Value<String?> deliveryNotes,
  Value<String?> deliveryZone,
  Value<double> subtotal,
  Value<double> shippingCost,
  Value<double> taxAmount,
  Value<double> totalAmount,
  Value<PaymentStatus> paymentStatus,
  Value<double> amountPaid,
  Value<String?> salesRepId,
  Value<String?> notes,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<String> localId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> deletedAt,
  Value<int> rowid,
});

final class $$LocalOrdersTableReferences
    extends BaseReferences<_$AppDatabase, $LocalOrdersTable, LocalOrder> {
  $$LocalOrdersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $LocalCustomersTable _customerIdTable(_$AppDatabase db) =>
      db.localCustomers.createAlias($_aliasNameGenerator(
          db.localOrders.customerId, db.localCustomers.id));

  $$LocalCustomersTableProcessedTableManager get customerId {
    final $_column = $_itemColumn<String>('customer_id')!;

    final manager = $$LocalCustomersTableTableManager($_db, $_db.localCustomers)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_customerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LocalOrderItemsTable, List<LocalOrderItem>>
      _localOrderItemsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localOrderItems,
              aliasName: $_aliasNameGenerator(
                  db.localOrders.id, db.localOrderItems.orderId));

  $$LocalOrderItemsTableProcessedTableManager get localOrderItemsRefs {
    final manager =
        $$LocalOrderItemsTableTableManager($_db, $_db.localOrderItems)
            .filter((f) => f.orderId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localOrderItemsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$LocalOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $LocalOrdersTable> {
  $$LocalOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get requestedDeliveryDate => $composableBuilder(
      column: $table.requestedDeliveryDate,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<OrderStatus, OrderStatus, String> get status =>
      $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get deliveryAddress => $composableBuilder(
      column: $table.deliveryAddress,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryNotes => $composableBuilder(
      column: $table.deliveryNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<PaymentStatus, PaymentStatus, String>
      get paymentStatus => $composableBuilder(
          column: $table.paymentStatus,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get salesRepId => $composableBuilder(
      column: $table.salesRepId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnFilters(column));

  $$LocalCustomersTableFilterComposer get customerId {
    final $$LocalCustomersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableFilterComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> localOrderItemsRefs(
      Expression<bool> Function($$LocalOrderItemsTableFilterComposer f) f) {
    final $$LocalOrderItemsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localOrderItems,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrderItemsTableFilterComposer(
              $db: $db,
              $table: $db.localOrderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocalOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalOrdersTable> {
  $$LocalOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get orderDate => $composableBuilder(
      column: $table.orderDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get requestedDeliveryDate => $composableBuilder(
      column: $table.requestedDeliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryAddress => $composableBuilder(
      column: $table.deliveryAddress,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryNotes => $composableBuilder(
      column: $table.deliveryNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get taxAmount => $composableBuilder(
      column: $table.taxAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get paymentStatus => $composableBuilder(
      column: $table.paymentStatus,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get salesRepId => $composableBuilder(
      column: $table.salesRepId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get deletedAt => $composableBuilder(
      column: $table.deletedAt, builder: (column) => ColumnOrderings(column));

  $$LocalCustomersTableOrderingComposer get customerId {
    final $$LocalCustomersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableOrderingComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalOrdersTable> {
  $$LocalOrdersTableAnnotationComposer({
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

  GeneratedColumn<String> get orderNumber => $composableBuilder(
      column: $table.orderNumber, builder: (column) => column);

  GeneratedColumn<DateTime> get orderDate =>
      $composableBuilder(column: $table.orderDate, builder: (column) => column);

  GeneratedColumn<DateTime> get requestedDeliveryDate => $composableBuilder(
      column: $table.requestedDeliveryDate, builder: (column) => column);

  GeneratedColumn<DateTime> get actualDeliveryDate => $composableBuilder(
      column: $table.actualDeliveryDate, builder: (column) => column);

  GeneratedColumnWithTypeConverter<OrderStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get deliveryAddress => $composableBuilder(
      column: $table.deliveryAddress, builder: (column) => column);

  GeneratedColumn<String> get deliveryNotes => $composableBuilder(
      column: $table.deliveryNotes, builder: (column) => column);

  GeneratedColumn<String> get deliveryZone => $composableBuilder(
      column: $table.deliveryZone, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<double> get shippingCost => $composableBuilder(
      column: $table.shippingCost, builder: (column) => column);

  GeneratedColumn<double> get taxAmount =>
      $composableBuilder(column: $table.taxAmount, builder: (column) => column);

  GeneratedColumn<double> get totalAmount => $composableBuilder(
      column: $table.totalAmount, builder: (column) => column);

  GeneratedColumnWithTypeConverter<PaymentStatus, String> get paymentStatus =>
      $composableBuilder(
          column: $table.paymentStatus, builder: (column) => column);

  GeneratedColumn<double> get amountPaid => $composableBuilder(
      column: $table.amountPaid, builder: (column) => column);

  GeneratedColumn<String> get salesRepId => $composableBuilder(
      column: $table.salesRepId, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

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

  GeneratedColumn<DateTime> get deletedAt =>
      $composableBuilder(column: $table.deletedAt, builder: (column) => column);

  $$LocalCustomersTableAnnotationComposer get customerId {
    final $$LocalCustomersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.customerId,
        referencedTable: $db.localCustomers,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCustomersTableAnnotationComposer(
              $db: $db,
              $table: $db.localCustomers,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> localOrderItemsRefs<T extends Object>(
      Expression<T> Function($$LocalOrderItemsTableAnnotationComposer a) f) {
    final $$LocalOrderItemsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localOrderItems,
        getReferencedColumn: (t) => t.orderId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrderItemsTableAnnotationComposer(
              $db: $db,
              $table: $db.localOrderItems,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$LocalOrdersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalOrdersTable,
    LocalOrder,
    $$LocalOrdersTableFilterComposer,
    $$LocalOrdersTableOrderingComposer,
    $$LocalOrdersTableAnnotationComposer,
    $$LocalOrdersTableCreateCompanionBuilder,
    $$LocalOrdersTableUpdateCompanionBuilder,
    (LocalOrder, $$LocalOrdersTableReferences),
    LocalOrder,
    PrefetchHooks Function({bool customerId, bool localOrderItemsRefs})> {
  $$LocalOrdersTableTableManager(_$AppDatabase db, $LocalOrdersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> orderNumber = const Value.absent(),
            Value<String> customerId = const Value.absent(),
            Value<DateTime> orderDate = const Value.absent(),
            Value<DateTime?> requestedDeliveryDate = const Value.absent(),
            Value<DateTime?> actualDeliveryDate = const Value.absent(),
            Value<OrderStatus> status = const Value.absent(),
            Value<String?> deliveryAddress = const Value.absent(),
            Value<String?> deliveryNotes = const Value.absent(),
            Value<String?> deliveryZone = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> shippingCost = const Value.absent(),
            Value<double> taxAmount = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<PaymentStatus> paymentStatus = const Value.absent(),
            Value<double> amountPaid = const Value.absent(),
            Value<String?> salesRepId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalOrdersCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            orderNumber: orderNumber,
            customerId: customerId,
            orderDate: orderDate,
            requestedDeliveryDate: requestedDeliveryDate,
            actualDeliveryDate: actualDeliveryDate,
            status: status,
            deliveryAddress: deliveryAddress,
            deliveryNotes: deliveryNotes,
            deliveryZone: deliveryZone,
            subtotal: subtotal,
            shippingCost: shippingCost,
            taxAmount: taxAmount,
            totalAmount: totalAmount,
            paymentStatus: paymentStatus,
            amountPaid: amountPaid,
            salesRepId: salesRepId,
            notes: notes,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String orderNumber,
            required String customerId,
            Value<DateTime> orderDate = const Value.absent(),
            Value<DateTime?> requestedDeliveryDate = const Value.absent(),
            Value<DateTime?> actualDeliveryDate = const Value.absent(),
            Value<OrderStatus> status = const Value.absent(),
            Value<String?> deliveryAddress = const Value.absent(),
            Value<String?> deliveryNotes = const Value.absent(),
            Value<String?> deliveryZone = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<double> shippingCost = const Value.absent(),
            Value<double> taxAmount = const Value.absent(),
            Value<double> totalAmount = const Value.absent(),
            Value<PaymentStatus> paymentStatus = const Value.absent(),
            Value<double> amountPaid = const Value.absent(),
            Value<String?> salesRepId = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            required String localId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<DateTime?> deletedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalOrdersCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            orderNumber: orderNumber,
            customerId: customerId,
            orderDate: orderDate,
            requestedDeliveryDate: requestedDeliveryDate,
            actualDeliveryDate: actualDeliveryDate,
            status: status,
            deliveryAddress: deliveryAddress,
            deliveryNotes: deliveryNotes,
            deliveryZone: deliveryZone,
            subtotal: subtotal,
            shippingCost: shippingCost,
            taxAmount: taxAmount,
            totalAmount: totalAmount,
            paymentStatus: paymentStatus,
            amountPaid: amountPaid,
            salesRepId: salesRepId,
            notes: notes,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            deletedAt: deletedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalOrdersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {customerId = false, localOrderItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localOrderItemsRefs) db.localOrderItems
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (customerId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.customerId,
                    referencedTable:
                        $$LocalOrdersTableReferences._customerIdTable(db),
                    referencedColumn:
                        $$LocalOrdersTableReferences._customerIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localOrderItemsRefs)
                    await $_getPrefetchedData<LocalOrder, $LocalOrdersTable,
                            LocalOrderItem>(
                        currentTable: table,
                        referencedTable: $$LocalOrdersTableReferences
                            ._localOrderItemsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalOrdersTableReferences(db, table, p0)
                                .localOrderItemsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.orderId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalOrdersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalOrdersTable,
    LocalOrder,
    $$LocalOrdersTableFilterComposer,
    $$LocalOrdersTableOrderingComposer,
    $$LocalOrdersTableAnnotationComposer,
    $$LocalOrdersTableCreateCompanionBuilder,
    $$LocalOrdersTableUpdateCompanionBuilder,
    (LocalOrder, $$LocalOrdersTableReferences),
    LocalOrder,
    PrefetchHooks Function({bool customerId, bool localOrderItemsRefs})>;
typedef $$LocalOrderItemsTableCreateCompanionBuilder = LocalOrderItemsCompanion
    Function({
  required String id,
  required String tenantId,
  required String orderId,
  required String variantId,
  required int quantity,
  Value<int> quantityDelivered,
  required double unitPrice,
  required double subtotal,
  Value<String?> reservedLotId,
  Value<bool> synced,
  required String localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LocalOrderItemsTableUpdateCompanionBuilder = LocalOrderItemsCompanion
    Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> orderId,
  Value<String> variantId,
  Value<int> quantity,
  Value<int> quantityDelivered,
  Value<double> unitPrice,
  Value<double> subtotal,
  Value<String?> reservedLotId,
  Value<bool> synced,
  Value<String> localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LocalOrderItemsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalOrderItemsTable, LocalOrderItem> {
  $$LocalOrderItemsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalOrdersTable _orderIdTable(_$AppDatabase db) =>
      db.localOrders.createAlias(
          $_aliasNameGenerator(db.localOrderItems.orderId, db.localOrders.id));

  $$LocalOrdersTableProcessedTableManager get orderId {
    final $_column = $_itemColumn<String>('order_id')!;

    final manager = $$LocalOrdersTableTableManager($_db, $_db.localOrders)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_orderIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$LocalOrderItemsTableFilterComposer
    extends Composer<_$AppDatabase, $LocalOrderItemsTable> {
  $$LocalOrderItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get quantityDelivered => $composableBuilder(
      column: $table.quantityDelivered,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reservedLotId => $composableBuilder(
      column: $table.reservedLotId, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LocalOrdersTableFilterComposer get orderId {
    final $$LocalOrdersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.localOrders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrdersTableFilterComposer(
              $db: $db,
              $table: $db.localOrders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalOrderItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $LocalOrderItemsTable> {
  $$LocalOrderItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get variantId => $composableBuilder(
      column: $table.variantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get quantityDelivered => $composableBuilder(
      column: $table.quantityDelivered,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get unitPrice => $composableBuilder(
      column: $table.unitPrice, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get subtotal => $composableBuilder(
      column: $table.subtotal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reservedLotId => $composableBuilder(
      column: $table.reservedLotId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LocalOrdersTableOrderingComposer get orderId {
    final $$LocalOrdersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.localOrders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrdersTableOrderingComposer(
              $db: $db,
              $table: $db.localOrders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalOrderItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LocalOrderItemsTable> {
  $$LocalOrderItemsTableAnnotationComposer({
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

  GeneratedColumn<String> get variantId =>
      $composableBuilder(column: $table.variantId, builder: (column) => column);

  GeneratedColumn<int> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<int> get quantityDelivered => $composableBuilder(
      column: $table.quantityDelivered, builder: (column) => column);

  GeneratedColumn<double> get unitPrice =>
      $composableBuilder(column: $table.unitPrice, builder: (column) => column);

  GeneratedColumn<double> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<String> get reservedLotId => $composableBuilder(
      column: $table.reservedLotId, builder: (column) => column);

  GeneratedColumn<bool> get synced =>
      $composableBuilder(column: $table.synced, builder: (column) => column);

  GeneratedColumn<String> get localId =>
      $composableBuilder(column: $table.localId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$LocalOrdersTableAnnotationComposer get orderId {
    final $$LocalOrdersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.orderId,
        referencedTable: $db.localOrders,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalOrdersTableAnnotationComposer(
              $db: $db,
              $table: $db.localOrders,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$LocalOrderItemsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $LocalOrderItemsTable,
    LocalOrderItem,
    $$LocalOrderItemsTableFilterComposer,
    $$LocalOrderItemsTableOrderingComposer,
    $$LocalOrderItemsTableAnnotationComposer,
    $$LocalOrderItemsTableCreateCompanionBuilder,
    $$LocalOrderItemsTableUpdateCompanionBuilder,
    (LocalOrderItem, $$LocalOrderItemsTableReferences),
    LocalOrderItem,
    PrefetchHooks Function({bool orderId})> {
  $$LocalOrderItemsTableTableManager(
      _$AppDatabase db, $LocalOrderItemsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalOrderItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalOrderItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalOrderItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> orderId = const Value.absent(),
            Value<String> variantId = const Value.absent(),
            Value<int> quantity = const Value.absent(),
            Value<int> quantityDelivered = const Value.absent(),
            Value<double> unitPrice = const Value.absent(),
            Value<double> subtotal = const Value.absent(),
            Value<String?> reservedLotId = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalOrderItemsCompanion(
            id: id,
            tenantId: tenantId,
            orderId: orderId,
            variantId: variantId,
            quantity: quantity,
            quantityDelivered: quantityDelivered,
            unitPrice: unitPrice,
            subtotal: subtotal,
            reservedLotId: reservedLotId,
            synced: synced,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String orderId,
            required String variantId,
            required int quantity,
            Value<int> quantityDelivered = const Value.absent(),
            required double unitPrice,
            required double subtotal,
            Value<String?> reservedLotId = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            required String localId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalOrderItemsCompanion.insert(
            id: id,
            tenantId: tenantId,
            orderId: orderId,
            variantId: variantId,
            quantity: quantity,
            quantityDelivered: quantityDelivered,
            unitPrice: unitPrice,
            subtotal: subtotal,
            reservedLotId: reservedLotId,
            synced: synced,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalOrderItemsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({orderId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (orderId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.orderId,
                    referencedTable:
                        $$LocalOrderItemsTableReferences._orderIdTable(db),
                    referencedColumn:
                        $$LocalOrderItemsTableReferences._orderIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalOrderItemsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $LocalOrderItemsTable,
    LocalOrderItem,
    $$LocalOrderItemsTableFilterComposer,
    $$LocalOrderItemsTableOrderingComposer,
    $$LocalOrderItemsTableAnnotationComposer,
    $$LocalOrderItemsTableCreateCompanionBuilder,
    $$LocalOrderItemsTableUpdateCompanionBuilder,
    (LocalOrderItem, $$LocalOrderItemsTableReferences),
    LocalOrderItem,
    PrefetchHooks Function({bool orderId})>;
typedef $$LocalCashRegistersTableCreateCompanionBuilder
    = LocalCashRegistersCompanion Function({
  required String id,
  required String tenantId,
  required String branchId,
  required String code,
  required String name,
  Value<String?> printerConfig,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalCashRegistersTableUpdateCompanionBuilder
    = LocalCashRegistersCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> branchId,
  Value<String> code,
  Value<String> name,
  Value<String?> printerConfig,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalCashRegistersTableReferences extends BaseReferences<
    _$AppDatabase, $LocalCashRegistersTable, LocalCashRegister> {
  $$LocalCashRegistersTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$LocalCashSessionsTable, List<LocalCashSession>>
      _localCashSessionsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localCashSessions,
              aliasName: $_aliasNameGenerator(db.localCashRegisters.id,
                  db.localCashSessions.cashRegisterId));

  $$LocalCashSessionsTableProcessedTableManager get localCashSessionsRefs {
    final manager = $$LocalCashSessionsTableTableManager(
            $_db, $_db.localCashSessions)
        .filter(
            (f) => f.cashRegisterId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localCashSessionsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get printerConfig => $composableBuilder(
      column: $table.printerConfig, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  Expression<bool> localCashSessionsRefs(
      Expression<bool> Function($$LocalCashSessionsTableFilterComposer f) f) {
    final $$LocalCashSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localCashSessions,
        getReferencedColumn: (t) => t.cashRegisterId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashSessionsTableFilterComposer(
              $db: $db,
              $table: $db.localCashSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get code => $composableBuilder(
      column: $table.code, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get printerConfig => $composableBuilder(
      column: $table.printerConfig,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));
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

  GeneratedColumn<String> get printerConfig => $composableBuilder(
      column: $table.printerConfig, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> localCashSessionsRefs<T extends Object>(
      Expression<T> Function($$LocalCashSessionsTableAnnotationComposer a) f) {
    final $$LocalCashSessionsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localCashSessions,
            getReferencedColumn: (t) => t.cashRegisterId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalCashSessionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localCashSessions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LocalCashRegistersTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool localCashSessionsRefs})> {
  $$LocalCashRegistersTableTableManager(
      _$AppDatabase db, $LocalCashRegistersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashRegistersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashRegistersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashRegistersTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> branchId = const Value.absent(),
            Value<String> code = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> printerConfig = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashRegistersCompanion(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            code: code,
            name: name,
            printerConfig: printerConfig,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String branchId,
            required String code,
            required String name,
            Value<String?> printerConfig = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashRegistersCompanion.insert(
            id: id,
            tenantId: tenantId,
            branchId: branchId,
            code: code,
            name: name,
            printerConfig: printerConfig,
            isActive: isActive,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalCashRegistersTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({localCashSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localCashSessionsRefs) db.localCashSessions
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localCashSessionsRefs)
                    await $_getPrefetchedData<LocalCashRegister,
                            $LocalCashRegistersTable, LocalCashSession>(
                        currentTable: table,
                        referencedTable: $$LocalCashRegistersTableReferences
                            ._localCashSessionsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalCashRegistersTableReferences(db, table, p0)
                                .localCashSessionsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.cashRegisterId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalCashRegistersTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool localCashSessionsRefs})>;
typedef $$LocalCashSessionsTableCreateCompanionBuilder
    = LocalCashSessionsCompanion Function({
  required String id,
  required String tenantId,
  required String cashRegisterId,
  required String userId,
  Value<DateTime> openingDate,
  Value<DateTime?> closingDate,
  Value<double> initialAmount,
  Value<double> systemAmount,
  Value<double?> declaredAmount,
  Value<String?> differenceJustification,
  Value<SessionStatus> status,
  Value<String?> approvedBy,
  Value<DateTime?> approvedAt,
  Value<String?> approvalNotes,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  required String localId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$LocalCashSessionsTableUpdateCompanionBuilder
    = LocalCashSessionsCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String> cashRegisterId,
  Value<String> userId,
  Value<DateTime> openingDate,
  Value<DateTime?> closingDate,
  Value<double> initialAmount,
  Value<double> systemAmount,
  Value<double?> declaredAmount,
  Value<String?> differenceJustification,
  Value<SessionStatus> status,
  Value<String?> approvedBy,
  Value<DateTime?> approvedAt,
  Value<String?> approvalNotes,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<String> localId,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

final class $$LocalCashSessionsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalCashSessionsTable, LocalCashSession> {
  $$LocalCashSessionsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalCashRegistersTable _cashRegisterIdTable(_$AppDatabase db) =>
      db.localCashRegisters.createAlias($_aliasNameGenerator(
          db.localCashSessions.cashRegisterId, db.localCashRegisters.id));

  $$LocalCashRegistersTableProcessedTableManager get cashRegisterId {
    final $_column = $_itemColumn<String>('cash_register_id')!;

    final manager =
        $$LocalCashRegistersTableTableManager($_db, $_db.localCashRegisters)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashRegisterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$LocalCashMovementsTable, List<LocalCashMovement>>
      _localCashMovementsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.localCashMovements,
              aliasName: $_aliasNameGenerator(db.localCashSessions.id,
                  db.localCashMovements.cashSessionId));

  $$LocalCashMovementsTableProcessedTableManager get localCashMovementsRefs {
    final manager = $$LocalCashMovementsTableTableManager(
            $_db, $_db.localCashMovements)
        .filter(
            (f) => f.cashSessionId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_localCashMovementsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get initialAmount => $composableBuilder(
      column: $table.initialAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get systemAmount => $composableBuilder(
      column: $table.systemAmount, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get declaredAmount => $composableBuilder(
      column: $table.declaredAmount,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get differenceJustification => $composableBuilder(
      column: $table.differenceJustification,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<SessionStatus, SessionStatus, String>
      get status => $composableBuilder(
          column: $table.status,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get approvalNotes => $composableBuilder(
      column: $table.approvalNotes, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnFilters(column));

  $$LocalCashRegistersTableFilterComposer get cashRegisterId {
    final $$LocalCashRegistersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cashRegisterId,
        referencedTable: $db.localCashRegisters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashRegistersTableFilterComposer(
              $db: $db,
              $table: $db.localCashRegisters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> localCashMovementsRefs(
      Expression<bool> Function($$LocalCashMovementsTableFilterComposer f) f) {
    final $$LocalCashMovementsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.localCashMovements,
        getReferencedColumn: (t) => t.cashSessionId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashMovementsTableFilterComposer(
              $db: $db,
              $table: $db.localCashMovements,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get userId => $composableBuilder(
      column: $table.userId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get initialAmount => $composableBuilder(
      column: $table.initialAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get systemAmount => $composableBuilder(
      column: $table.systemAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get declaredAmount => $composableBuilder(
      column: $table.declaredAmount,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get differenceJustification => $composableBuilder(
      column: $table.differenceJustification,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get approvalNotes => $composableBuilder(
      column: $table.approvalNotes,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
      column: $table.updatedAt, builder: (column) => ColumnOrderings(column));

  $$LocalCashRegistersTableOrderingComposer get cashRegisterId {
    final $$LocalCashRegistersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cashRegisterId,
        referencedTable: $db.localCashRegisters,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashRegistersTableOrderingComposer(
              $db: $db,
              $table: $db.localCashRegisters,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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

  GeneratedColumn<DateTime> get openingDate => $composableBuilder(
      column: $table.openingDate, builder: (column) => column);

  GeneratedColumn<DateTime> get closingDate => $composableBuilder(
      column: $table.closingDate, builder: (column) => column);

  GeneratedColumn<double> get initialAmount => $composableBuilder(
      column: $table.initialAmount, builder: (column) => column);

  GeneratedColumn<double> get systemAmount => $composableBuilder(
      column: $table.systemAmount, builder: (column) => column);

  GeneratedColumn<double> get declaredAmount => $composableBuilder(
      column: $table.declaredAmount, builder: (column) => column);

  GeneratedColumn<String> get differenceJustification => $composableBuilder(
      column: $table.differenceJustification, builder: (column) => column);

  GeneratedColumnWithTypeConverter<SessionStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get approvedBy => $composableBuilder(
      column: $table.approvedBy, builder: (column) => column);

  GeneratedColumn<DateTime> get approvedAt => $composableBuilder(
      column: $table.approvedAt, builder: (column) => column);

  GeneratedColumn<String> get approvalNotes => $composableBuilder(
      column: $table.approvalNotes, builder: (column) => column);

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

  $$LocalCashRegistersTableAnnotationComposer get cashRegisterId {
    final $$LocalCashRegistersTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.cashRegisterId,
            referencedTable: $db.localCashRegisters,
            getReferencedColumn: (t) => t.id,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalCashRegistersTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localCashRegisters,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }

  Expression<T> localCashMovementsRefs<T extends Object>(
      Expression<T> Function($$LocalCashMovementsTableAnnotationComposer a) f) {
    final $$LocalCashMovementsTableAnnotationComposer composer =
        $composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $db.localCashMovements,
            getReferencedColumn: (t) => t.cashSessionId,
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalCashMovementsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localCashMovements,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return f(composer);
  }
}

class $$LocalCashSessionsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function(
        {bool cashRegisterId, bool localCashMovementsRefs})> {
  $$LocalCashSessionsTableTableManager(
      _$AppDatabase db, $LocalCashSessionsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashSessionsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String> cashRegisterId = const Value.absent(),
            Value<String> userId = const Value.absent(),
            Value<DateTime> openingDate = const Value.absent(),
            Value<DateTime?> closingDate = const Value.absent(),
            Value<double> initialAmount = const Value.absent(),
            Value<double> systemAmount = const Value.absent(),
            Value<double?> declaredAmount = const Value.absent(),
            Value<String?> differenceJustification = const Value.absent(),
            Value<SessionStatus> status = const Value.absent(),
            Value<String?> approvedBy = const Value.absent(),
            Value<DateTime?> approvedAt = const Value.absent(),
            Value<String?> approvalNotes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashSessionsCompanion(
            id: id,
            tenantId: tenantId,
            cashRegisterId: cashRegisterId,
            userId: userId,
            openingDate: openingDate,
            closingDate: closingDate,
            initialAmount: initialAmount,
            systemAmount: systemAmount,
            declaredAmount: declaredAmount,
            differenceJustification: differenceJustification,
            status: status,
            approvedBy: approvedBy,
            approvedAt: approvedAt,
            approvalNotes: approvalNotes,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            required String cashRegisterId,
            required String userId,
            Value<DateTime> openingDate = const Value.absent(),
            Value<DateTime?> closingDate = const Value.absent(),
            Value<double> initialAmount = const Value.absent(),
            Value<double> systemAmount = const Value.absent(),
            Value<double?> declaredAmount = const Value.absent(),
            Value<String?> differenceJustification = const Value.absent(),
            Value<SessionStatus> status = const Value.absent(),
            Value<String?> approvedBy = const Value.absent(),
            Value<DateTime?> approvedAt = const Value.absent(),
            Value<String?> approvalNotes = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            required String localId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime> updatedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashSessionsCompanion.insert(
            id: id,
            tenantId: tenantId,
            cashRegisterId: cashRegisterId,
            userId: userId,
            openingDate: openingDate,
            closingDate: closingDate,
            initialAmount: initialAmount,
            systemAmount: systemAmount,
            declaredAmount: declaredAmount,
            differenceJustification: differenceJustification,
            status: status,
            approvedBy: approvedBy,
            approvedAt: approvedAt,
            approvalNotes: approvalNotes,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            updatedAt: updatedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalCashSessionsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {cashRegisterId = false, localCashMovementsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (localCashMovementsRefs) db.localCashMovements
              ],
              addJoins: <
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
                      dynamic>>(state) {
                if (cashRegisterId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cashRegisterId,
                    referencedTable: $$LocalCashSessionsTableReferences
                        ._cashRegisterIdTable(db),
                    referencedColumn: $$LocalCashSessionsTableReferences
                        ._cashRegisterIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (localCashMovementsRefs)
                    await $_getPrefetchedData<LocalCashSession,
                            $LocalCashSessionsTable, LocalCashMovement>(
                        currentTable: table,
                        referencedTable: $$LocalCashSessionsTableReferences
                            ._localCashMovementsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$LocalCashSessionsTableReferences(db, table, p0)
                                .localCashMovementsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.cashSessionId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$LocalCashSessionsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool cashRegisterId, bool localCashMovementsRefs})>;
typedef $$LocalCashMovementsTableCreateCompanionBuilder
    = LocalCashMovementsCompanion Function({
  required String id,
  required String tenantId,
  Value<String?> cashSessionId,
  Value<String?> branchId,
  required CashMovementType movementType,
  Value<CashMovementCategory?> category,
  required double amount,
  required String concept,
  Value<String?> reference,
  Value<String?> evidenceUrl,
  Value<String?> createdBy,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  required String localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});
typedef $$LocalCashMovementsTableUpdateCompanionBuilder
    = LocalCashMovementsCompanion Function({
  Value<String> id,
  Value<String> tenantId,
  Value<String?> cashSessionId,
  Value<String?> branchId,
  Value<CashMovementType> movementType,
  Value<CashMovementCategory?> category,
  Value<double> amount,
  Value<String> concept,
  Value<String?> reference,
  Value<String?> evidenceUrl,
  Value<String?> createdBy,
  Value<bool> synced,
  Value<DateTime?> syncedAt,
  Value<String> localId,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$LocalCashMovementsTableReferences extends BaseReferences<
    _$AppDatabase, $LocalCashMovementsTable, LocalCashMovement> {
  $$LocalCashMovementsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $LocalCashSessionsTable _cashSessionIdTable(_$AppDatabase db) =>
      db.localCashSessions.createAlias($_aliasNameGenerator(
          db.localCashMovements.cashSessionId, db.localCashSessions.id));

  $$LocalCashSessionsTableProcessedTableManager? get cashSessionId {
    final $_column = $_itemColumn<String>('cash_session_id');
    if ($_column == null) return null;
    final manager =
        $$LocalCashSessionsTableTableManager($_db, $_db.localCashSessions)
            .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cashSessionIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<CashMovementType, CashMovementType, String>
      get movementType => $composableBuilder(
          column: $table.movementType,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnWithTypeConverterFilters<CashMovementCategory?, CashMovementCategory,
          String>
      get category => $composableBuilder(
          column: $table.category,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get concept => $composableBuilder(
      column: $table.concept, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get evidenceUrl => $composableBuilder(
      column: $table.evidenceUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$LocalCashSessionsTableFilterComposer get cashSessionId {
    final $$LocalCashSessionsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cashSessionId,
        referencedTable: $db.localCashSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashSessionsTableFilterComposer(
              $db: $db,
              $table: $db.localCashSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tenantId => $composableBuilder(
      column: $table.tenantId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get branchId => $composableBuilder(
      column: $table.branchId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get movementType => $composableBuilder(
      column: $table.movementType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get amount => $composableBuilder(
      column: $table.amount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get concept => $composableBuilder(
      column: $table.concept, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get reference => $composableBuilder(
      column: $table.reference, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get evidenceUrl => $composableBuilder(
      column: $table.evidenceUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get createdBy => $composableBuilder(
      column: $table.createdBy, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get synced => $composableBuilder(
      column: $table.synced, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
      column: $table.syncedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localId => $composableBuilder(
      column: $table.localId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$LocalCashSessionsTableOrderingComposer get cashSessionId {
    final $$LocalCashSessionsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.cashSessionId,
        referencedTable: $db.localCashSessions,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$LocalCashSessionsTableOrderingComposer(
              $db: $db,
              $table: $db.localCashSessions,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
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

  GeneratedColumn<String> get branchId =>
      $composableBuilder(column: $table.branchId, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CashMovementType, String> get movementType =>
      $composableBuilder(
          column: $table.movementType, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CashMovementCategory?, String>
      get category => $composableBuilder(
          column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get concept =>
      $composableBuilder(column: $table.concept, builder: (column) => column);

  GeneratedColumn<String> get reference =>
      $composableBuilder(column: $table.reference, builder: (column) => column);

  GeneratedColumn<String> get evidenceUrl => $composableBuilder(
      column: $table.evidenceUrl, builder: (column) => column);

  GeneratedColumn<String> get createdBy =>
      $composableBuilder(column: $table.createdBy, builder: (column) => column);

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
            builder: (joinBuilder,
                    {$addJoinBuilderToRootComposer,
                    $removeJoinBuilderFromRootComposer}) =>
                $$LocalCashSessionsTableAnnotationComposer(
                  $db: $db,
                  $table: $db.localCashSessions,
                  $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                  joinBuilder: joinBuilder,
                  $removeJoinBuilderFromRootComposer:
                      $removeJoinBuilderFromRootComposer,
                ));
    return composer;
  }
}

class $$LocalCashMovementsTableTableManager extends RootTableManager<
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
    PrefetchHooks Function({bool cashSessionId})> {
  $$LocalCashMovementsTableTableManager(
      _$AppDatabase db, $LocalCashMovementsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LocalCashMovementsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LocalCashMovementsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LocalCashMovementsTableAnnotationComposer(
                  $db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> tenantId = const Value.absent(),
            Value<String?> cashSessionId = const Value.absent(),
            Value<String?> branchId = const Value.absent(),
            Value<CashMovementType> movementType = const Value.absent(),
            Value<CashMovementCategory?> category = const Value.absent(),
            Value<double> amount = const Value.absent(),
            Value<String> concept = const Value.absent(),
            Value<String?> reference = const Value.absent(),
            Value<String?> evidenceUrl = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            Value<String> localId = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashMovementsCompanion(
            id: id,
            tenantId: tenantId,
            cashSessionId: cashSessionId,
            branchId: branchId,
            movementType: movementType,
            category: category,
            amount: amount,
            concept: concept,
            reference: reference,
            evidenceUrl: evidenceUrl,
            createdBy: createdBy,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String tenantId,
            Value<String?> cashSessionId = const Value.absent(),
            Value<String?> branchId = const Value.absent(),
            required CashMovementType movementType,
            Value<CashMovementCategory?> category = const Value.absent(),
            required double amount,
            required String concept,
            Value<String?> reference = const Value.absent(),
            Value<String?> evidenceUrl = const Value.absent(),
            Value<String?> createdBy = const Value.absent(),
            Value<bool> synced = const Value.absent(),
            Value<DateTime?> syncedAt = const Value.absent(),
            required String localId,
            Value<DateTime> createdAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              LocalCashMovementsCompanion.insert(
            id: id,
            tenantId: tenantId,
            cashSessionId: cashSessionId,
            branchId: branchId,
            movementType: movementType,
            category: category,
            amount: amount,
            concept: concept,
            reference: reference,
            evidenceUrl: evidenceUrl,
            createdBy: createdBy,
            synced: synced,
            syncedAt: syncedAt,
            localId: localId,
            createdAt: createdAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$LocalCashMovementsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({cashSessionId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
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
                      dynamic>>(state) {
                if (cashSessionId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.cashSessionId,
                    referencedTable: $$LocalCashMovementsTableReferences
                        ._cashSessionIdTable(db),
                    referencedColumn: $$LocalCashMovementsTableReferences
                        ._cashSessionIdTable(db)
                        .id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$LocalCashMovementsTableProcessedTableManager = ProcessedTableManager<
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
    PrefetchHooks Function({bool cashSessionId})>;
typedef $$SyncQueueTableCreateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  required String entityType,
  required String entityId,
  required String operation,
  required String payload,
  Value<int> retryCount,
  Value<int> priority,
  Value<DateTime> createdAt,
  Value<DateTime?> lastAttempt,
  Value<String?> lastError,
});
typedef $$SyncQueueTableUpdateCompanionBuilder = SyncQueueCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> payload,
  Value<int> retryCount,
  Value<int> priority,
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
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastAttempt => $composableBuilder(
      column: $table.lastAttempt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnFilters(column));
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
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get payload => $composableBuilder(
      column: $table.payload, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get priority => $composableBuilder(
      column: $table.priority, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastAttempt => $composableBuilder(
      column: $table.lastAttempt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastError => $composableBuilder(
      column: $table.lastError, builder: (column) => ColumnOrderings(column));
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
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get payload =>
      $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<int> get retryCount => $composableBuilder(
      column: $table.retryCount, builder: (column) => column);

  GeneratedColumn<int> get priority =>
      $composableBuilder(column: $table.priority, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastAttempt => $composableBuilder(
      column: $table.lastAttempt, builder: (column) => column);

  GeneratedColumn<String> get lastError =>
      $composableBuilder(column: $table.lastError, builder: (column) => column);
}

class $$SyncQueueTableTableManager extends RootTableManager<
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
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()> {
  $$SyncQueueTableTableManager(_$AppDatabase db, $SyncQueueTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncQueueTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncQueueTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncQueueTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> payload = const Value.absent(),
            Value<int> retryCount = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttempt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
          }) =>
              SyncQueueCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            retryCount: retryCount,
            priority: priority,
            createdAt: createdAt,
            lastAttempt: lastAttempt,
            lastError: lastError,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String entityId,
            required String operation,
            required String payload,
            Value<int> retryCount = const Value.absent(),
            Value<int> priority = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastAttempt = const Value.absent(),
            Value<String?> lastError = const Value.absent(),
          }) =>
              SyncQueueCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            payload: payload,
            retryCount: retryCount,
            priority: priority,
            createdAt: createdAt,
            lastAttempt: lastAttempt,
            lastError: lastError,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncQueueTableProcessedTableManager = ProcessedTableManager<
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
      BaseReferences<_$AppDatabase, $SyncQueueTable, SyncQueueData>
    ),
    SyncQueueData,
    PrefetchHooks Function()>;
typedef $$SyncConflictsTableCreateCompanionBuilder = SyncConflictsCompanion
    Function({
  Value<int> id,
  required String entityType,
  required String entityId,
  required String localPayload,
  required String remotePayload,
  required String conflictType,
  Value<DateTime> detectedAt,
  Value<DateTime?> resolvedAt,
  Value<String?> resolutionStrategy,
  Value<bool> resolved,
});
typedef $$SyncConflictsTableUpdateCompanionBuilder = SyncConflictsCompanion
    Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> localPayload,
  Value<String> remotePayload,
  Value<String> conflictType,
  Value<DateTime> detectedAt,
  Value<DateTime?> resolvedAt,
  Value<String?> resolutionStrategy,
  Value<bool> resolved,
});

class $$SyncConflictsTableFilterComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get localPayload => $composableBuilder(
      column: $table.localPayload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get remotePayload => $composableBuilder(
      column: $table.remotePayload, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get conflictType => $composableBuilder(
      column: $table.conflictType, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get resolutionStrategy => $composableBuilder(
      column: $table.resolutionStrategy,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnFilters(column));
}

class $$SyncConflictsTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get localPayload => $composableBuilder(
      column: $table.localPayload,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get remotePayload => $composableBuilder(
      column: $table.remotePayload,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get conflictType => $composableBuilder(
      column: $table.conflictType,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get resolutionStrategy => $composableBuilder(
      column: $table.resolutionStrategy,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get resolved => $composableBuilder(
      column: $table.resolved, builder: (column) => ColumnOrderings(column));
}

class $$SyncConflictsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncConflictsTable> {
  $$SyncConflictsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get localPayload => $composableBuilder(
      column: $table.localPayload, builder: (column) => column);

  GeneratedColumn<String> get remotePayload => $composableBuilder(
      column: $table.remotePayload, builder: (column) => column);

  GeneratedColumn<String> get conflictType => $composableBuilder(
      column: $table.conflictType, builder: (column) => column);

  GeneratedColumn<DateTime> get detectedAt => $composableBuilder(
      column: $table.detectedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get resolvedAt => $composableBuilder(
      column: $table.resolvedAt, builder: (column) => column);

  GeneratedColumn<String> get resolutionStrategy => $composableBuilder(
      column: $table.resolutionStrategy, builder: (column) => column);

  GeneratedColumn<bool> get resolved =>
      $composableBuilder(column: $table.resolved, builder: (column) => column);
}

class $$SyncConflictsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncConflictsTable,
    SyncConflict,
    $$SyncConflictsTableFilterComposer,
    $$SyncConflictsTableOrderingComposer,
    $$SyncConflictsTableAnnotationComposer,
    $$SyncConflictsTableCreateCompanionBuilder,
    $$SyncConflictsTableUpdateCompanionBuilder,
    (
      SyncConflict,
      BaseReferences<_$AppDatabase, $SyncConflictsTable, SyncConflict>
    ),
    SyncConflict,
    PrefetchHooks Function()> {
  $$SyncConflictsTableTableManager(_$AppDatabase db, $SyncConflictsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncConflictsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncConflictsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncConflictsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> localPayload = const Value.absent(),
            Value<String> remotePayload = const Value.absent(),
            Value<String> conflictType = const Value.absent(),
            Value<DateTime> detectedAt = const Value.absent(),
            Value<DateTime?> resolvedAt = const Value.absent(),
            Value<String?> resolutionStrategy = const Value.absent(),
            Value<bool> resolved = const Value.absent(),
          }) =>
              SyncConflictsCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            localPayload: localPayload,
            remotePayload: remotePayload,
            conflictType: conflictType,
            detectedAt: detectedAt,
            resolvedAt: resolvedAt,
            resolutionStrategy: resolutionStrategy,
            resolved: resolved,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String entityId,
            required String localPayload,
            required String remotePayload,
            required String conflictType,
            Value<DateTime> detectedAt = const Value.absent(),
            Value<DateTime?> resolvedAt = const Value.absent(),
            Value<String?> resolutionStrategy = const Value.absent(),
            Value<bool> resolved = const Value.absent(),
          }) =>
              SyncConflictsCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            localPayload: localPayload,
            remotePayload: remotePayload,
            conflictType: conflictType,
            detectedAt: detectedAt,
            resolvedAt: resolvedAt,
            resolutionStrategy: resolutionStrategy,
            resolved: resolved,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncConflictsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncConflictsTable,
    SyncConflict,
    $$SyncConflictsTableFilterComposer,
    $$SyncConflictsTableOrderingComposer,
    $$SyncConflictsTableAnnotationComposer,
    $$SyncConflictsTableCreateCompanionBuilder,
    $$SyncConflictsTableUpdateCompanionBuilder,
    (
      SyncConflict,
      BaseReferences<_$AppDatabase, $SyncConflictsTable, SyncConflict>
    ),
    SyncConflict,
    PrefetchHooks Function()>;
typedef $$SyncAuditTableCreateCompanionBuilder = SyncAuditCompanion Function({
  Value<int> id,
  required String entityType,
  required String entityId,
  required String operation,
  required String status,
  Value<DateTime> timestamp,
  Value<String?> details,
});
typedef $$SyncAuditTableUpdateCompanionBuilder = SyncAuditCompanion Function({
  Value<int> id,
  Value<String> entityType,
  Value<String> entityId,
  Value<String> operation,
  Value<String> status,
  Value<DateTime> timestamp,
  Value<String?> details,
});

class $$SyncAuditTableFilterComposer
    extends Composer<_$AppDatabase, $SyncAuditTable> {
  $$SyncAuditTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnFilters(column));
}

class $$SyncAuditTableOrderingComposer
    extends Composer<_$AppDatabase, $SyncAuditTable> {
  $$SyncAuditTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get entityId => $composableBuilder(
      column: $table.entityId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get operation => $composableBuilder(
      column: $table.operation, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get status => $composableBuilder(
      column: $table.status, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
      column: $table.timestamp, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get details => $composableBuilder(
      column: $table.details, builder: (column) => ColumnOrderings(column));
}

class $$SyncAuditTableAnnotationComposer
    extends Composer<_$AppDatabase, $SyncAuditTable> {
  $$SyncAuditTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get entityType => $composableBuilder(
      column: $table.entityType, builder: (column) => column);

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get operation =>
      $composableBuilder(column: $table.operation, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);
}

class $$SyncAuditTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SyncAuditTable,
    SyncAuditLog,
    $$SyncAuditTableFilterComposer,
    $$SyncAuditTableOrderingComposer,
    $$SyncAuditTableAnnotationComposer,
    $$SyncAuditTableCreateCompanionBuilder,
    $$SyncAuditTableUpdateCompanionBuilder,
    (
      SyncAuditLog,
      BaseReferences<_$AppDatabase, $SyncAuditTable, SyncAuditLog>
    ),
    SyncAuditLog,
    PrefetchHooks Function()> {
  $$SyncAuditTableTableManager(_$AppDatabase db, $SyncAuditTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SyncAuditTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SyncAuditTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SyncAuditTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> entityType = const Value.absent(),
            Value<String> entityId = const Value.absent(),
            Value<String> operation = const Value.absent(),
            Value<String> status = const Value.absent(),
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> details = const Value.absent(),
          }) =>
              SyncAuditCompanion(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            status: status,
            timestamp: timestamp,
            details: details,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String entityType,
            required String entityId,
            required String operation,
            required String status,
            Value<DateTime> timestamp = const Value.absent(),
            Value<String?> details = const Value.absent(),
          }) =>
              SyncAuditCompanion.insert(
            id: id,
            entityType: entityType,
            entityId: entityId,
            operation: operation,
            status: status,
            timestamp: timestamp,
            details: details,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SyncAuditTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SyncAuditTable,
    SyncAuditLog,
    $$SyncAuditTableFilterComposer,
    $$SyncAuditTableOrderingComposer,
    $$SyncAuditTableAnnotationComposer,
    $$SyncAuditTableCreateCompanionBuilder,
    $$SyncAuditTableUpdateCompanionBuilder,
    (
      SyncAuditLog,
      BaseReferences<_$AppDatabase, $SyncAuditTable, SyncAuditLog>
    ),
    SyncAuditLog,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$LocalProductCategoriesTableTableManager get localProductCategories =>
      $$LocalProductCategoriesTableTableManager(
          _db, _db.localProductCategories);
  $$LocalBrandsTableTableManager get localBrands =>
      $$LocalBrandsTableTableManager(_db, _db.localBrands);
  $$LocalUnitsOfMeasureTableTableManager get localUnitsOfMeasure =>
      $$LocalUnitsOfMeasureTableTableManager(_db, _db.localUnitsOfMeasure);
  $$LocalProductsTableTableManager get localProducts =>
      $$LocalProductsTableTableManager(_db, _db.localProducts);
  $$LocalProductVariantsTableTableManager get localProductVariants =>
      $$LocalProductVariantsTableTableManager(_db, _db.localProductVariants);
  $$LocalPriceListsTableTableManager get localPriceLists =>
      $$LocalPriceListsTableTableManager(_db, _db.localPriceLists);
  $$LocalPriceListItemsTableTableManager get localPriceListItems =>
      $$LocalPriceListItemsTableTableManager(_db, _db.localPriceListItems);
  $$LocalInventoryLotsTableTableManager get localInventoryLots =>
      $$LocalInventoryLotsTableTableManager(_db, _db.localInventoryLots);
  $$LocalInventoryMovementsTableTableManager get localInventoryMovements =>
      $$LocalInventoryMovementsTableTableManager(
          _db, _db.localInventoryMovements);
  $$LocalCustomersTableTableManager get localCustomers =>
      $$LocalCustomersTableTableManager(_db, _db.localCustomers);
  $$LocalSalesTableTableManager get localSales =>
      $$LocalSalesTableTableManager(_db, _db.localSales);
  $$LocalSaleItemsTableTableManager get localSaleItems =>
      $$LocalSaleItemsTableTableManager(_db, _db.localSaleItems);
  $$LocalSalePaymentsTableTableManager get localSalePayments =>
      $$LocalSalePaymentsTableTableManager(_db, _db.localSalePayments);
  $$LocalOrdersTableTableManager get localOrders =>
      $$LocalOrdersTableTableManager(_db, _db.localOrders);
  $$LocalOrderItemsTableTableManager get localOrderItems =>
      $$LocalOrderItemsTableTableManager(_db, _db.localOrderItems);
  $$LocalCashRegistersTableTableManager get localCashRegisters =>
      $$LocalCashRegistersTableTableManager(_db, _db.localCashRegisters);
  $$LocalCashSessionsTableTableManager get localCashSessions =>
      $$LocalCashSessionsTableTableManager(_db, _db.localCashSessions);
  $$LocalCashMovementsTableTableManager get localCashMovements =>
      $$LocalCashMovementsTableTableManager(_db, _db.localCashMovements);
  $$SyncQueueTableTableManager get syncQueue =>
      $$SyncQueueTableTableManager(_db, _db.syncQueue);
  $$SyncConflictsTableTableManager get syncConflicts =>
      $$SyncConflictsTableTableManager(_db, _db.syncConflicts);
  $$SyncAuditTableTableManager get syncAudit =>
      $$SyncAuditTableTableManager(_db, _db.syncAudit);
}
