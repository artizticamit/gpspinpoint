import 'package:drift/drift.dart' as d;
import '../database/app_db.dart';
import '../models/pin.dart';

class PinRepository {
  final AppDatabase db;
  PinRepository(this.db);

  Future<int> addPin(Pin p) async {
    final companion = PinsCompanion(
      latitude: d.Value(p.latitude),
      longitude: d.Value(p.longitude),
      accuracy: d.Value(p.accuracy),
      altitude: d.Value(p.altitude),
      title: d.Value(p.title),
      description: d.Value(p.description),
      categoryId: d.Value(p.categoryId),
      createdAt: d.Value(p.createdAt),
      updatedAt: d.Value(p.updatedAt),
      isArchived: d.Value(p.isArchived),
    );
    return db.into(db.pins).insert(companion);
  }

  Future<List<Pin>> getRecent({int limit = 50}) async {
    final rows = await db.getRecentPins(limit: limit);
    return rows
        .map((r) => Pin(
              id: r.id,
              latitude: r.latitude,
              longitude: r.longitude,
              altitude: r.altitude,
              accuracy: r.accuracy,
              title: r.title,
              description: r.description,
              categoryId: r.categoryId,
              createdAt: r.createdAt,
              updatedAt: r.updatedAt,
              isArchived: r.isArchived,
            ))
        .toList();
  }

  Future<Pin?> getById(int id) async {
    final r = await db.getPinById(id);
    if (r == null) return null;
    return Pin(
      id: r.id,
      latitude: r.latitude,
      longitude: r.longitude,
      altitude: r.altitude,
      accuracy: r.accuracy,
      title: r.title,
      description: r.description,
      categoryId: r.categoryId,
      createdAt: r.createdAt,
      updatedAt: r.updatedAt,
      isArchived: r.isArchived,
    );
  }

  Future<int> delete(int id) => db.deletePinById(id);

  Future<int> update(Pin pin) async {
    if (pin.id == null) throw StateError('Pin id required for update');
    final companion = PinsCompanion(
      id: d.Value(pin.id!),
      latitude: d.Value(pin.latitude),
      longitude: d.Value(pin.longitude),
      accuracy: d.Value(pin.accuracy),
      altitude: d.Value(pin.altitude),
      title: d.Value(pin.title),
      description: d.Value(pin.description),
      categoryId: d.Value(pin.categoryId),
      createdAt: d.Value(pin.createdAt),
      updatedAt: d.Value(pin.updatedAt),
      isArchived: d.Value(pin.isArchived),
    );
    return db.update(db.pins).replace(companion);
  }

  Future<List<Pin>> search(String q) async {
    final like = '%${q.replaceAll('%', '')}%';
    final results = await (db.select(db.pins)
          ..where((t) => t.title.like(like) | t.description.like(like)))
        .get();
    return results
        .map((r) => Pin(
              id: r.id,
              latitude: r.latitude,
              longitude: r.longitude,
              altitude: r.altitude,
              accuracy: r.accuracy,
              title: r.title,
              description: r.description,
              categoryId: r.categoryId,
              createdAt: r.createdAt,
              updatedAt: r.updatedAt,
              isArchived: r.isArchived,
            ))
        .toList();
  }
}
