class AppConfig {
  // Supply MAPTILER_API_KEY via --dart-define
  static const mapTilerApiKey = String.fromEnvironment('MAPTILER_API_KEY', defaultValue: '');
  static String get mapStyleUrl => 'https://api.maptiler.com/maps/streets/style.json?key=$mapTilerApiKey';
}
