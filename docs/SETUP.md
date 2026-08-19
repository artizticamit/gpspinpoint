Setup

Prerequisites

- Flutter (stable channel)
- Android SDK / iOS toolchain as needed

Local run

1. flutter pub get
2. flutter run --dart-define=MAPTILER_API_KEY=YOUR_KEY

Running tests

- flutter test

Notes

- API keys must not be committed. Use --dart-define.
- To regenerate Drift database code: flutter pub run build_runner build --delete-conflicting-outputs
