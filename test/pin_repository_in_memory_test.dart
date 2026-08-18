import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:pinpoint/database/app_db.dart';
import 'package:pinpoint/repositories/pin_repository.dart';
import 'package:pinpoint/models/pin.dart' as package_pin;

void main() {
  test('pin repository add/get using in-memory DB', () async {
    final db = AppDatabase.connect(NativeDatabase.memory());
    final repo = PinRepository(db);

    // seed categories (should be empty)
    await db.seedCategories();

    final now = DateTime.now();
    final pin = package_pin.Pin(
      latitude: 12.34,
      longitude: 56.78,
      altitude: 100.0,
      accuracy: 5.0,
      createdAt: now,
      updatedAt: now,
    );

    final id = await repo.addPin(pin);
    expect(id, greaterThan(0));

    final fetched = await repo.getById(id);
    expect(fetched, isNotNull);
    expect(fetched!.latitude, closeTo(12.34, 0.0001));
  }, skip: false);
}
