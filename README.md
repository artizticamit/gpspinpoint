# PinPoint

PinPoint is a fast, private, offline-first GPS Bookmark App built with Flutter.

Setup

1. Install Flutter (stable channel).
2. Add MapTiler key when running or building:

   flutter run --dart-define=MAPTILER_API_KEY=YOUR_KEY

3. Run:

   flutter pub get
   flutter run

Architecture

See ARCHITECTURE.md

Roadmap

See ROADMAP.md

Notes

- API keys must NOT be committed. Use --dart-define.
- Drift is used for local storage. Run build_runner to generate code if needed:

  flutter pub run build_runner build --delete-conflicting-outputs
