## Data Models

### Task
- `id`, `title`, `description`, `status` (todo/inProgress/done)
- `priority` (low/medium/high), `dueDate`, `tags`
- `projectId` — links to a Project
- `taskKey` — project-scoped key (e.g., "WK-3")
- `createdAt`, `modifiedAt` — used for sync conflict resolution

### Project
- `id`, `name`, `key` — short uppercase key for task numbering
- `description`, `color`, `iconName`
- `taskCounter` — auto-incrementing counter for task keys
- `isArchived`, `createdAt`, `modifiedAt`

### Ritual
- `id`, `title`, `description`
- `frequency` (daily/weekly/monthly)
- `isCompleted`, `streakCount`, `lastCompleted`, `resetTime`
- Auto-resets based on frequency (daily at midnight, weekly on new ISO week, monthly on new month)

## Sync Architecture

The app uses a local-first approach:
1. All data stored locally in Hive database
2. Optional Supabase cloud sync for tasks, projects, and rituals
3. Conflict resolution via `modifiedAt` timestamps (last-write-wins)
4. Real-time subscriptions for live updates across devices
5. `syncAll()` syncs projects first, then tasks, then rituals
