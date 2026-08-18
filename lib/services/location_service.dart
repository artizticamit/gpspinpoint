import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum AccuracyLabel { excellent, good, moderate, poor, veryPoor }

class LocationService {
  Future<bool> checkPermission() async {
    final status = await Permission.location.status;
    if (status.isGranted) return true;
    final result = await Permission.location.request();
    return result.isGranted;
  }

  AccuracyLabel labelFromAccuracy(double meters) {
    if (meters <= 5) return AccuracyLabel.excellent;
    if (meters <= 15) return AccuracyLabel.good;
    if (meters <= 50) return AccuracyLabel.moderate;
    if (meters <= 100) return AccuracyLabel.poor;
    return AccuracyLabel.veryPoor;
  }

  Future<Position?> getCurrentBest({Duration maxWait = const Duration(seconds: 10)}) async {
    final hasPermission = await checkPermission();
    if (!hasPermission) return null;

    // Request a single high-accuracy position first
    try {
      final controller = StreamController<Position>();
      final sub = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.best, distanceFilter: 0),
      ).listen((pos) {
        controller.add(pos);
      });

      Position? best;
      final end = DateTime.now().add(maxWait);
      while (DateTime.now().isBefore(end)) {
        // wait for next position or timeout 1s
        try {
          final pos = await controller.stream.first.timeout(const Duration(seconds: 1));
          if (best == null || pos.accuracy < best.accuracy) best = pos;
          // if excellent, break early
          if (pos.accuracy <= 10) break;
        } catch (_) {
          // ignore timeout waiting for the stream
        }
      }

      await sub.cancel();
      await controller.close();
      if (best != null) return best;
      // fallback to one-shot
      return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, timeLimit: const Duration(seconds: 5));
    } catch (e) {
      return null;
    }
  }
}
