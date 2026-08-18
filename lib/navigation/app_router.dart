import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/map/map_screen.dart';
import '../features/pins/pins_list_screen.dart';
import '../features/settings/settings_screen.dart';
import '../features/pins/pin_details_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      ShellRoute(
        builder: (context, state, child) => Scaffold(body: child),
        routes: [
          GoRoute(path: '/', name: 'home', builder: (c, s) => const HomeScreen()),
          GoRoute(path: '/map', name: 'map', builder: (c, s) => const MapScreen()),
          GoRoute(path: '/pins', name: 'pins', builder: (c, s) => const PinsListScreen()),
          GoRoute(path: '/settings', name: 'settings', builder: (c, s) => const SettingsScreen()),
          GoRoute(path: '/pin/:id', name: 'pin_details', builder: (c, s) {
            final id = int.tryParse(c.params['id'] ?? '');
            return PinDetailsScreen(pinId: id);
          }),
        ],
      )
    ],
  );
}
