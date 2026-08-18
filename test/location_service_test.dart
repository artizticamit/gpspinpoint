import 'package:flutter_test/flutter_test.dart';
import 'package:pinpoint/services/location_service.dart';

void main() {
  test('accuracy label mapping', () {
    final s = LocationService();
    expect(s.labelFromAccuracy(2), AccuracyLabel.excellent);
    expect(s.labelFromAccuracy(10), AccuracyLabel.good);
    expect(s.labelFromAccuracy(30), AccuracyLabel.moderate);
    expect(s.labelFromAccuracy(80), AccuracyLabel.poor);
    expect(s.labelFromAccuracy(500), AccuracyLabel.veryPoor);
  });
}
