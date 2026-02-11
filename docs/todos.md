Based on comprehensive code audit, the following improvements are identified:

## Critical Issues

### Architecture & Code Organization

- **Refactor oversized widgets**:
  - `kanban_board.dart` (925 → 416 lines) - extracted dialogs, cards, and utilities
  - `project_sidebar.dart` (697 → 331 lines) - extracted dialog components
  - `rituals_sidebar.dart` (411 → 320 lines) - extracted dialog components
- **DRY Violations**: Extracted duplicated color parsing (`_parseColor`) to `common/utils.dart`
- **UI Component Library**: Created reusable dialog components in `widgets/dialogs/`

### Model Issues
- **Mutability**: All model fields are mutable (no `final` keyword) - violates immutability
  - Files: `task.dart`, `ritual.dart`, `project.dart`, `board.dart`
- **Missing validation**: No validation for hex color strings, empty keys, or malformed data
- **Unsafe null handling**: Line 68 in `ritual.dart` - `taskKey` can be null but used without check

### Service Layer Issues

**TaskService (`task_service.dart`)**:
- Line 119: Direct field mutation `task.status = newStatus` - violates encapsulation
- Lines 203, 222: Direct model mutations instead of using copyWith
- Error handling added for all database operations with try-catch blocks and logging
- Line 11: Boxes changed to `late final`
- Potential race condition: Multiple async operations without proper locking

**SyncService (`sync_service.dart`)**:
- Replaced `debugPrint()` with proper `developer.log()` logging
- Added retry logic with exponential backoff and configurable max retries
- Added timeout handling for all Supabase operations with `_executeWithRetry` helper
- Lines 46-69, 152-167, 249-269: **Duplicated parsing logic** - extract to factory methods
- Memory leak risk: Real-time subscriptions not properly disposed
- Added `SyncException` class for structured error handling
- Added error recovery mechanism for partial sync failures
- All sync methods now return `bool` for success/failure indication

**ThemeService (`theme_service.dart`)**:
- Added error handling for SharedPreferences operations with try-catch and logging
- All toggle methods now return `bool` for success/failure and revert state on error

### Main.dart Issues
- Lines 23-30: Missing `const` keyword for adapter registrations
- Lines 33-36: No error handling for Hive box opening
- Line 44: Class name is `LuminaFlowApp` should be `PhotisNadiApp`
- No app initialization error recovery

### UI/UX Issues
- **theme_toggle.dart**: Dark mode toggle doesn't actually switch themes (UI only)
- **app_theme.dart**:
  - Lines 235-261: `glassCard()` method is defined but never used
  - Unused import: `glassmorphism` package imported but minimally used
- **home_screen.dart**: Missing error boundaries and loading states
- **rituals_sidebar.dart**: Line 122 - Bug in completion counter displays `$completedCount/$completedCount` instead of `$completedCount/$totalCount`

### Error Handling & Robustness
- **Missing try-catch blocks** in:
  - All database write operations in TaskService
  - JSON parsing in SyncService with error recovery
  - Color parsing across widgets
  - Date parsing operations
- Added proper error handling throughout services with structured logging
- No fallback UI for error states
- No loading indicators for async operations
- Potential null pointer exceptions throughout

### Performance Issues
- **kanban_board.dart**:
  - Line 39-59: ListView rebuilds entire board on every task change
  - No pagination for large task lists
  - Images (if added) not cached
- **Memory leaks**:
  - ScrollController disposed in kanban_board.dart
  - TextEditingControllers not disposed in dialogs
  - Stream subscriptions not cancelled

### Testing Gaps
- Only 26 unit tests covering basic CRUD
- Missing widget tests for UI components
- Missing integration tests for sync
- No error scenario tests
- Tests don't cover edge cases (null values, empty strings, long text)

### Code Style Issues
- Inconsistent spacing (some files use trailing commas, others don't)
- Some long methods violate single responsibility principle
- Magic numbers throughout (e.g., line length limits, padding values)

### Dependencies
- **Unused packages to audit**:
  - `riverpod` imported but only Provider used
  - `glassmorphism` - verify actual usage
  - `flutter_staggered_animations` - verify actual usage

## Refactoring Priority

### High Priority
1. Split oversized widget files
2. Add error handling to all service methods
   - TaskService: Added try-catch blocks, logging, and bool return values
   - SyncService: Added retry logic with exponential backoff, timeout handling, SyncException class
   - ThemeService: Added error handling with state rollback on failure
3. Extract duplicated parsing logic in SyncService
4. Fix mutability issues in models (use copyWith exclusively)
5. Fix the rituals sidebar completion counter bug

### Medium Priority
6. Extract reusable UI components
7. Add proper logging throughout
8. Dispose controllers and cancel subscriptions
9. Add const constructors where missing
10. Add validation to models

### Low Priority
11. Remove unused imports and dependencies
12. Add more comprehensive tests
13. Optimize performance for large lists
14. Rename LuminaFlowApp to PhotisNadiApp
