# Changelog

All notable changes to Photis Nadi will be documented in this file.

## [2026.2.22] - 2026-02-22

### Added
- Extracted reusable UI components:
  - `CollapsibleSidebar` - Container wrapper for collapsible sidebars
  - `CollapsedListItem` - Reusable collapsed sidebar item
  - `ActionMenuItem` - Reusable popup menu item
  - `EditDeleteMenu` - Reusable edit/delete popup menu
  - Enhanced `SidebarHeader` with custom leading support
  - `TaskCard` - Reusable task card component
  - `ColumnHeader` - Reusable Kanban column header
- New files:
  - `lib/widgets/common/task_card.dart` - Task card widget
  - `lib/widgets/common/column_widgets.dart` - Column header and dialogs

### Changed
- Improved code organization in `lib/widgets/common/common_widgets.dart`
- Refactored `kanban_board.dart`:
  - Reduced from 678 to 324 lines (52% reduction)
  - Extracted TaskCard to separate file
  - Extracted column dialogs to column_widgets.dart
- Updated `project_sidebar.dart` and `rituals_sidebar.dart` to use CollapsibleSidebar

### Fixed
- Fixed deprecated `value` parameter in DropdownButtonFormField

---

## [2026.2.16] - 2026-02-16

### Added
- Model validation for hex colors, UUIDs, project keys
- Error handling to TaskService with try-catch and logging
- Retry logic to SyncService with exponential backoff
- Timeout handling for Supabase operations
- Pagination support for Kanban board columns
- Loading indicators for async operations
- Comprehensive test coverage (55 tests)

### Changed
- Split oversized widget files into dialog components
- Added `final` keyword to immutable model fields
- Controller disposal for ScrollController and TextEditingControllers
- Replaced magic numbers with constants in `lib/common/constants.dart`
- UI performance optimized with Selector widgets

### Fixed
- Rituals sidebar completion counter bug
- Model mutability issues

### Removed
- Unused dependencies: riverpod, flutter_staggered_animations, glassmorphism
- Build artifacts from git

### Deprecated
- LuminaFlowApp renamed to PhotisNadiApp
