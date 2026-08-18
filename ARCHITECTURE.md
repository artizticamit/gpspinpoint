# Architecture

Feature-First Clean Architecture

Layers:
- UI (Screens, Widgets)
- Controllers/ViewModels (Riverpod StateNotifiers)
- Repositories
- Data sources (AppDatabase / Map Provider / Location Service)
- Platform (SQLite, MapLibre, native GPS)

Repository Pattern is used. Map abstraction is provided via MapProviderInterface and MapTilerProvider implementation. Future providers: SelfHostedProvider, OfflineProvider.

Privacy-first: no cloud, local-only storage.

Future cloud sync plan: add encrypted backup, opt-in user flow, conflict resolution by timestamp.
