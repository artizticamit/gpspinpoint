import 'dart:convert';
import 'dart:io';
import '../database/app_db.dart';

class ExportImportService {
  final AppDatabase db;
  ExportImportService(this.db);

  Future<String> exportJson() async {
    final pins = await db.getRecentPins(limit: 10000);
    final list = pins.map((p) => {
          'id': p.id,
          'latitude': p.latitude,
          'longitude': p.longitude,
          'accuracy': p.accuracy,
          'altitude': p.altitude,
          'title': p.title,
          'description': p.description,
          'categoryId': p.categoryId,
          'createdAt': p.createdAt.toIso8601String(),
          'updatedAt': p.updatedAt.toIso8601String(),
        }).toList();
    return jsonEncode(list);
  }

  Future<void> importJson(String jsonContent) async {
    // TODO: implement import with validation and conflict handling
    final data = jsonDecode(jsonContent) as List;
    for (final item in data) {
      // minimal insert
    }
  }
}
