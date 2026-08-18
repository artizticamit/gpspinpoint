import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import 'home_controller.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/accuracy_chip.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(homeControllerProvider.notifier);
    final state = ref.watch(homeControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('PinPoint')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(state.statusText),
                AccuracyChip(accuracyLabel: state.accuracyLabel),
              ],
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              label: 'Save Location',
              onPressed: () async {
                final result = await controller.quickPin();
                final messenger = ScaffoldMessenger.of(context);
                if (result) {
                  messenger.showSnackBar(const SnackBar(content: Text('Pin Saved')));
                } else {
                  messenger.showSnackBar(const SnackBar(content: Text('Failed to save pin')));
                }
              },
            ),
            const SizedBox(height: 12),
            const Text('Recent'),
            Expanded(
              child: ListView.builder(
                itemCount: state.recent.length,
                itemBuilder: (c, i) {
                  final p = state.recent[i];
                  return ListTile(
                    title: Text(p.title ?? 'Pin ${p.id ?? ''}'),
                    subtitle: Text('${p.latitude.toStringAsFixed(4)}, ${p.longitude.toStringAsFixed(4)}'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/pin/${p.id}');
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          switch (i) {
            case 0:
              break;
            case 1:
              Navigator.of(context).pushNamed('/map');
              break;
            case 2:
              Navigator.of(context).pushNamed('/pins');
              break;
            case 3:
              Navigator.of(context).pushNamed('/settings');
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Map'),
          BottomNavigationBarItem(icon: Icon(Icons.place), label: 'Pins'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
    );
  }
}
