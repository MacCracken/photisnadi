## Import Style
- Use `flutter/material.dart` first
- Group imports: external, internal, relative
- Use relative imports for files within lib/
- Sort imports alphabetically

## Formatting
- Use 2-space indentation
- Maximum line length: 80 characters
- Use trailing commas for multi-line parameters
- Use single quotes for strings

## Naming Conventions
- Variables: `camelCase`
- Functions: `camelCase`
- Classes: `PascalCase`
- Constants: `UPPER_SNAKE_CASE`
- Files: `snake_case.dart`
- Directories: `snake_case`

## Architecture Patterns

### Error Handling
- Use try-catch blocks for async operations
- Log errors with appropriate context
- Provide user-friendly error messages in UI
- Use proper error propagation with `async`/`await`
- Handle Hive exceptions gracefully
- Network operations should include timeout and retry logic

### State Management
- Use Provider for simple state
- Follow single responsibility principle for services
- Keep widgets small and focused

### Database
- All models must extend `HiveObject` and include `part` directives
- Use `@HiveType` and `@HiveField` annotations with unique typeIds
- Handle box opening/closing properly
- Use transactions for multiple related operations
