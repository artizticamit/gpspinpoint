import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(children: [
        ListTile(title: const Text('Location permissions'), subtitle: const Text('Manage location permission settings')), 
        ListTile(title: const Text('Offline maps (placeholder)'), subtitle: const Text('Download maps for offline use - TODO')),
        ListTile(title: const Text('Export (JSON)'), subtitle: const Text('Export pins to JSON - TODO')),
        ListTile(title: const Text('Import'), subtitle: const Text('Import pins - TODO')),
        ListTile(title: const Text('Privacy'), subtitle: const Text('Private by default. No analytics.')),
        ListTile(title: const Text('About'), subtitle: const Text('PinPoint - Offline GPS bookmarks')),
      ]),
    );
  }
}
