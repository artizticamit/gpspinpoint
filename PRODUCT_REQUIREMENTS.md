Product requirements — PinPoint (MVP)

Overview

PinPoint is an offline-first GPS bookmark app for saving and organizing places.

Sprint 1 — App shell (MVP vertical slice)

Must have:
- Flutter project scaffolding
- Theme with light/dark modes
- Navigation between screens
- Home screen showing quick actions and recent pins
- Map screen placeholder using MapLibre (map view + search + quick-pin button)
- Pins list screen (search, sort, list, open details)
- Settings screen (permissions, import/export placeholders)
- CI workflow: analyze → test → build

Non-functional:
- Private by default, no analytics
- Local database (Drift) for offline storage (existing)

Success criteria

- App builds and runs on device/emulator
- All screens navigable and accessible from bottom nav
- Tests pass
