import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/location_service.dart';
import '../../providers.dart';
import '../../models/pin.dart' as m;

class HomeState {
  final String statusText;
  final String accuracyLabel;
  final List<m.Pin> recent;

  HomeState({required this.statusText, required this.accuracyLabel, required this.recent});

  HomeState copyWith({String? statusText, String? accuracyLabel, List<m.Pin>? recent}) => HomeState(
        statusText: statusText ?? this.statusText,
        accuracyLabel: accuracyLabel ?? this.accuracyLabel,
        recent: recent ?? this.recent,
      );
}

final homeControllerProvider = StateNotifierProvider<HomeController, HomeState>((ref) => HomeController(ref));

class HomeController extends StateNotifier<HomeState> {
  final Ref ref;
  HomeController(this.ref)
      : super(HomeState(statusText: 'Ready', accuracyLabel: '-', recent: [])) {
    loadRecent();
  }

  Future<void> loadRecent() async {
    final repo = ref.read(pinRepositoryProvider);
    final pins = await repo.getRecent();
    state = state.copyWith(recent: pins);
  }

  Future<bool> quickPin() async {
    final locationSvc = ref.read(locationServiceProvider);
    final loc = await locationSvc.getCurrentBest();
    if (loc == null) return false;
    final repo = ref.read(pinRepositoryProvider);
    final now = DateTime.now();
    final pin = m.Pin(
      latitude: loc.latitude,
      longitude: loc.longitude,
      altitude: loc.altitude,
      accuracy: loc.accuracy,
      createdAt: now,
      updatedAt: now,
    );
    await repo.addPin(pin);
    await loadRecent();
    return true;
  }
}
