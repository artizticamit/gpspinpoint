import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers.dart';
import '../../repositories/pin_repository.dart';

class PinsListScreen extends ConsumerStatefulWidget {
  const PinsListScreen({super.key});

  @override
  ConsumerState<PinsListScreen> createState() => _PinsListScreenState();
}

class _PinsListScreenState extends ConsumerState<PinsListScreen> {
  String query = '';
  String sort = 'recent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pins')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search title or description'),
              onChanged: (v) => setState(() => query = v),
            ),
          ),
          Row(children: [
            const SizedBox(width: 8),
            const Text('Sort:'),
            const SizedBox(width: 8),
            DropdownButton<String>(value: sort, items: const [
              DropdownMenuItem(value: 'recent', child: Text('Recent')),
              DropdownMenuItem(value: 'name', child: Text('Name')),
            ], onChanged: (v) => setState(() => sort = v ?? 'recent'))
          ]),
          Expanded(
            child: FutureBuilder(
              future: ref.read(pinRepositoryProvider).getRecent(limit: 200),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) return const Center(child: CircularProgressIndicator());
                var list = snapshot.data as List? ?? [];
                if (query.isNotEmpty) {
                  list = list.where((p) => (p.title ?? '').toLowerCase().contains(query.toLowerCase()) || (p.description ?? '').toLowerCase().contains(query.toLowerCase())).toList();
                }
                if (sort == 'name') {
                  list.sort((a, b) => (a.title ?? '').compareTo(b.title ?? ''));
                }
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (c, i) {
                    final p = list[i];
                    return ListTile(
                      title: Text(p.title ?? 'Pin ${p.id ?? ''}'),
                      subtitle: Text('${p.latitude.toStringAsFixed(4)}, ${p.longitude.toStringAsFixed(4)}'),
                      onTap: () => Navigator.of(context).pushNamed('/pin/${p.id}'),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
