// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// Minimal generated-like definitions to keep project buildable without running build_runner

class Pin extends DataClass implements Insertable<Pin> {
  final int id;
  final double latitude;
  final double longitude;
  final double accuracy;
  final double? altitude;
  final String? title;
  final String? description;
  final int? categoryId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool isArchived;
  Pin({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.altitude,
    this.title,
    this.description,
    this.categoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.isArchived,
  });

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    return {
      'id': Variable<int>(id),
      'latitude': Variable<double>(latitude),
      'longitude': Variable<double>(longitude),
      'accuracy': Variable<double>(accuracy),
      'altitude': Variable<double?>(altitude),
      'title': Variable<String?>(title),
      'description': Variable<String?>(description),
      'category_id': Variable<int?>(categoryId),
      'created_at': Variable<DateTime>(createdAt),
      'updated_at': Variable<DateTime>(updatedAt),
      'is_archived': Variable<bool>(isArchived),
    };
  }

  factory Pin.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Pin(
      id: data['\u007feffectivePrefixid'] ?? data['id'],
      latitude: data['${effectivePrefix}latitude'] as double,
      longitude: data['${effectivePrefix}longitude'] as double,
      accuracy: data['${effectivePrefix}accuracy'] as double,
      altitude: data['${effectivePrefix}altitude'] as double?,
      title: data['${effectivePrefix}title'] as String?,
      description: data['${effectivePrefix}description'] as String?,
      categoryId: data['${effectivePrefix}category_id'] as int?,
      createdAt: data['${effectivePrefix}created_at'] as DateTime,
      updatedAt: data['${effectivePrefix}updated_at'] as DateTime,
      isArchived: data['${effectivePrefix}is_archived'] as bool,
    );
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $PinsTable pins = $PinsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);

  @override
  List<TableInfo> get allTables => [pins, categories];
}

class $PinsTable extends Pins with TableInfo<$PinsTable, Pin> {
  final GeneratedDatabase _db;
  final String? _alias;
  $PinsTable(this._db, [this._alias]);

  @override
  late final VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedIntColumn id = _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', aliasedName, false, hasAutoIncrement: true);
  }

  @override
  late final GeneratedRealColumn latitude = _constructLatitude();
  GeneratedRealColumn _constructLatitude() {
    return GeneratedRealColumn('latitude', aliasedName, false);
  }

  @override
  late final GeneratedRealColumn longitude = _constructLongitude();
  GeneratedRealColumn _constructLongitude() {
    return GeneratedRealColumn('longitude', aliasedName, false);
  }

  @override
  late final GeneratedRealColumn accuracy = _constructAccuracy();
  GeneratedRealColumn _constructAccuracy() {
    return GeneratedRealColumn('accuracy', aliasedName, false);
  }

  @override
  late final GeneratedRealColumn altitude = _constructAltitude();
  GeneratedRealColumn _constructAltitude() {
    return GeneratedRealColumn('altitude', aliasedName, true);
  }

  @override
  late final GeneratedTextColumn title = _constructTitle();
  GeneratedTextColumn _constructTitle() {
    return GeneratedTextColumn('title', aliasedName, true);
  }

  @override
  late final GeneratedTextColumn description = _constructDescription();
  GeneratedTextColumn _constructDescription() {
    return GeneratedTextColumn('description', aliasedName, true);
  }

  @override
  late final GeneratedIntColumn categoryId = _constructCategoryId();
  GeneratedIntColumn _constructCategoryId() {
    return GeneratedIntColumn('category_id', aliasedName, true);
  }

  @override
  late final GeneratedDateTimeColumn createdAt = _constructCreatedAt();
  GeneratedDateTimeColumn _constructCreatedAt() {
    return GeneratedDateTimeColumn('created_at', aliasedName, false);
  }

  @override
  late final GeneratedDateTimeColumn updatedAt = _constructUpdatedAt();
  GeneratedDateTimeColumn _constructUpdatedAt() {
    return GeneratedDateTimeColumn('updated_at', aliasedName, false);
  }

  @override
  late final GeneratedBoolColumn isArchived = _constructIsArchived();
  GeneratedBoolColumn _constructIsArchived() {
    return GeneratedBoolColumn('is_archived', aliasedName, false, defaultValue: Constant(false));
  }

  @override
  List<GeneratedColumn> get $columns => [id, latitude, longitude, accuracy, altitude, title, description, categoryId, createdAt, updatedAt, isArchived];

  @override
  String get aliasedName => _alias ?? 'pins';

  @override
  String get actualTableName => 'pins';

  @override
  VerificationContext validateIntegrity(Insertable<Pin> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
}

class $CategoriesTable extends Categories with TableInfo<$CategoriesTable, dynamic> {
  final GeneratedDatabase _db;
  final String? _alias;
  $CategoriesTable(this._db, [this._alias]);

  @override
  late final GeneratedIntColumn id = GeneratedIntColumn('id', aliasedName, false, hasAutoIncrement: true);
  @override
  late final GeneratedTextColumn name = GeneratedTextColumn('name', aliasedName, false);
  @override
  late final GeneratedTextColumn icon = GeneratedTextColumn('icon', aliasedName, true);
  @override
  late final GeneratedBoolColumn isDefault = GeneratedBoolColumn('is_default', aliasedName, false, defaultValue: Constant(false));

  @override
  List<GeneratedColumn> get $columns => [id, name, icon, isDefault];

  @override
  String get aliasedName => _alias ?? 'categories';

  @override
  String get actualTableName => 'categories';

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
}
