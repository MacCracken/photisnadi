# Architecture Decision Records

## ADR 001: Local-First Data Storage with Hive

**Status**: Accepted

**Context**: 
The application requires offline-first capability with optional cloud sync. Users need persistent data storage that works without network connectivity.

**Decision**:
Use Hive for local storage with the following approach:
- All data models extend `HiveObject` for persistence
- Type adapters generated via `hive_generator` 
- Boxes opened on app startup for tasks, rituals, projects, and settings
- Sync service handles optional Supabase cloud backup

**Consequences**:
- ✅ Full offline functionality
- ✅ Fast read/write operations
- ✅ Cross-platform support
- ⚠️ Manual migration needed for schema changes
- ⚠️ Client-side only (no server validation)

---

## ADR 002: Provider for State Management

**Status**: Accepted

**Context**:
The app needs a simple, lightweight state management solution that integrates well with Flutter's widget tree.

**Decision**:
Use Provider with ChangeNotifier pattern:
- `TaskService` manages tasks, rituals, projects
- `ThemeService` manages theme preferences
- `SyncService` manages cloud synchronization
- MultiProvider at app root provides services to all widgets

**Consequences**:
- ✅ Simple implementation
- ✅ Built-in Flutter support
- ✅ Sufficient for app complexity
- ⚠️ Not ideal for very complex apps with deep widget trees

---

## ADR 003: Supabase for Cloud Sync

**Status**: Accepted

**Context**:
Users want to sync their data across devices while maintaining local-first capability.

**Decision**:
Use Supabase as the backend:
- PostgreSQL database for persistent storage
- Real-time subscriptions for live updates
- Row Level Security (RLS) for user data isolation

**Consequences**:
- ✅ Free tier sufficient for personal use
- ✅ Real-time sync support
- ✅ Built-in authentication
- ⚠️ Requires network for sync
- ⚠️ Data conflicts resolved via last-write-wins

---

## ADR 004: Window Manager for Desktop Integration

**Status**: Accepted

**Context**:
The app targets macOS and Linux desktop with system tray and window management needs.

**Decision**:
Use `window_manager` package for:
- Custom window sizing and positioning
- Hidden title bar with custom controls
- Always-on-top functionality

**Consequences**:
- ✅ Cross-platform desktop support
- ✅ Consistent UI across platforms
- ⚠️ Limited platform-specific features (no native menu bar)

---

## ADR 005: Kanban Board UI Pattern

**Status**: Accepted

**Context**:
The app needs horizontal-scrolling task management similar to Trello.

**Decision**:
- Horizontal ListView for columns
- Vertical ListView for tasks within columns
- Project-scoped task keys (e.g., "WK-1", "WK-2")
- Board columns mapped to task statuses

**Consequences**:
- ✅ Familiar UX for Trello users
- ✅ Easy task status management
- ⚠️ May need optimization for large boards

---

## ADR 006: Dual-Mode UI (Standard + E-Reader)

**Status**: Accepted

**Context**:
Users requested an e-reader friendly mode for users with light sensitivity or those who prefer high-contrast displays.

**Decision**:
Implement two theme modes:
- **Standard**: Vibrant theme with color accents
- **E-Reader**: High-contrast light theme with no animations

ThemeService toggles between modes via `isEReaderMode` flag.

**Consequences**:
- ✅ Accessibility support
- ✅ Reduced eye strain option
- ⚠️ Additional testing required for each mode
