Project scaffold for PinPoint created. Run:

flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

Then run with your MapTiler key:
flutter run --dart-define=MAPTILER_API_KEY=YOUR_KEY

Notes:
- Drift uses code generation; running build_runner will produce generated files used by the database.
- app_db.g.dart includes a minimal generated-like implementation to allow building without immediate codegen, but running build_runner is recommended.