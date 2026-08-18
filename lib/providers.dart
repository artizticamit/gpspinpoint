import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'database/app_db.dart';
import 'repositories/pin_repository.dart';
import 'services/location_service.dart';
import 'services/map_tiler_provider.dart';

final dbProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  db.seedCategories();
  return db;
});

final pinRepositoryProvider = Provider<PinRepository>((ref) => PinRepository(ref.watch(dbProvider)));
final locationServiceProvider = Provider<LocationService>((_) => LocationService());
final mapProviderProvider = Provider((_) => MapTilerProvider());
