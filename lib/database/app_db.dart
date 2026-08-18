import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_db.g.dart';

class Pins extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  RealColumn get accuracy => real()();
  RealColumn get altitude => real().nullable()();
  TextColumn get title => text().nullable()();
  TextColumn get description => text().nullable()();
  IntColumn get categoryId => integer().nullable().customConstraint('NULLABLE REFERENCES categories(id)')();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
  BoolColumn get isArchived => boolean().withDefault(const Constant(false))();
}

class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text().nullable()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}

@DriftDatabase(tables: [Pins, Categories])
class AppDatabase extends _$AppDatabase {
  /// Default constructor uses a file-backed DB suitable for production.
  AppDatabase() : super(_openConnection());

  /// Allows injecting a QueryExecutor (e.g., an in-memory DB for tests).
  AppDatabase.connect(QueryExecutor executor) : super(executor);

  @override
  int get schemaVersion => 1;

  Future<int> insertPin(Insertable<Pin> pin) => into(pins).insert(pin);

  Future<List<Pin>> getRecentPins({int limit = 20}) {
    return (select(pins)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])..limit(limit)).get();
  }

  Future<Pin?> getPinById(int id) async {
    return (select(pins)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> updatePinData(Insertable<Pin> pin) => update(pins).replace(pin);

  Future<int> deletePinById(int id) => (delete(pins)..where((t) => t.id.equals(id))).go();

  Future<void> seedCategories() async {
    final existing = await select(categories).get();
    if (existing.isNotEmpty) return;
    final seed = [
      'Favorite',
      'Parking',
      'Food',
      'Personal',
      'Work',
      'Travel',
      'Important',
      'Other'
    ];
    for (final name in seed) {
      await into(categories).insert(CategoriesCompanion.insert(name: name, icon: Value(null), isDefault: Value(false)));
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'pinpoint.sqlite'));
    return NativeDatabase(file);
  });
}
