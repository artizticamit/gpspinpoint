import 'package:flutter/widgets.dart';
import 'package:maplibre_gl/mapbox_gl.dart' as ml;
import '../config/app_config.dart';
import 'map_provider.dart';

class MapTilerProvider implements MapProviderInterface {
  final String apiKey;
  final String styleUrl;

  MapTilerProvider({String? apiKey, String? styleUrl})
      : apiKey = apiKey ?? AppConfig.mapTilerApiKey,
        styleUrl = styleUrl ?? AppConfig.mapStyleUrl;

  @override
  Widget buildMap({required Widget child}) {
    // Map scaffold is implemented in MapScreen. This provider supplies configuration.
    return child;
  }

  ml.MapboxMapOptions mapOptions() => ml.MapboxMapOptions(
        styleString: styleUrl,
        accessToken: apiKey,
      );
}
