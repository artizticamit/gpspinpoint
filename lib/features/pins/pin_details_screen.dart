import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';

class PinDetailsScreen extends ConsumerWidget {
  final int? pinId;
  const PinDetailsScreen({super.key, required this.pinId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (pinId == null) return const Scaffold(body: Center(child: Text('Pin not found')));
    return Scaffold(
      appBar: AppBar(title: const Text('Pin Details')),
      body: FutureBuilder(
        future: ref.read(pinRepositoryProvider).getById(pinId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
          final pin = snapshot.data;
          if (pin == null) return const Center(child: Text('Not found'));
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(pin.title ?? 'Untitled', style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 8),
              Text(pin.description ?? ''),
              const SizedBox(height: 8),
              Text('Category: ${pin.categoryId ?? '-'}'),
              const SizedBox(height: 8),
              Text('Accuracy: ${pin.accuracy}m'),
              const SizedBox(height: 8),
              Text('Coordinates: ${pin.latitude}, ${pin.longitude}'),
              const Spacer(),
              Row(children: [
                ElevatedButton.icon(onPressed: () {} , icon: const Icon(Icons.edit), label: const Text('Edit')),
                const SizedBox(width: 12),
                ElevatedButton.icon(onPressed: () async { await ref.read(pinRepositoryProvider).delete(pin.id!); Navigator.of(context).pop(); }, icon: const Icon(Icons.delete), label: const Text('Delete')),
                const SizedBox(width: 12),
                ElevatedButton.icon(onPressed: () { /* Launch chooser to external maps */ }, icon: const Icon(Icons.navigation), label: const Text('Navigate')),
              ])
            ]),
          );
        },
      ),
    );
  }
}
