import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:maplibre_gl/mapbox_gl.dart';
import '../../providers.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  MaplibreMapController? mapController;

  @override
  Widget build(BuildContext context) {
    final mapProvider = ref.read(mapProviderProvider);
    final style = mapProvider.mapOptions().styleString;

    return Scaffold(
      appBar: AppBar(title: const Text('Map')),
      body: Stack(children: [
        MaplibreMap(
          styleString: style,
          onMapCreated: (c) => mapController = c,
          initialCameraPosition: const CameraPosition(target: LatLng(0, 0), zoom: 2),
          myLocationEnabled: true,
          myLocationTrackingMode: MyLocationTrackingMode.Tracking,
        ),
        Positioned(
          top: 8,
          left: 8,
          right: 8,
          child: Card(
            child: TextField(decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Search pins locally')),
          ),
        ),
        Positioned(
          bottom: 16,
          right: 16,
          child: FloatingActionButton(
            onPressed: () async {
              // Quick pin
              final success = await ref.read(locationServiceProvider).getCurrentBest();
              if (success != null) {
                // TODO: create pin from location
              }
            },
            child: const Icon(Icons.add_location_alt),
          ),
        )
      ]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.of(context).pushNamed('/');
              break;
            case 1:
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
