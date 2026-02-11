# Contributing to Photis Nadi

Thank you for your interest in contributing! This guide outlines the process for contributing to the project.

## Getting Started

### Prerequisites

- Flutter SDK 3.10.0 or higher
- Git
- For desktop builds: Platform-specific development tools

### Development Setup

1. **Fork the repository**
   - Click the "Fork" button on GitHub
   - Clone your fork locally:
     ```bash
     git clone https://github.com/YOURUSERNAME/photisnadi.git
     cd photisnadi
     ```

2. **Set up upstream remote**
   ```bash
   git remote add upstream https://github.com/originalowner/photisnadi.git
   ```

3. **Install dependencies**
   ```bash
   flutter pub get
   flutter packages pub run build_runner build --delete-conflicting-outputs
   ```

4. **Verify the build**
   ```bash
   flutter analyze
   flutter test
   ```

## Branch Strategy

- `main` - Stable production branch
- `develop` - Development branch with latest features
- Feature branches - Created from `develop` for new features

### Creating a Feature Branch

```bash
git checkout develop
git pull upstream develop
git checkout -b feature/your-feature-name
```

## Making Changes

### Code Standards

Before committing:

```bash
# Check code quality
flutter analyze

# Format code
dart format .

# Run tests
flutter test
```

### Commit Guidelines

- Use conventional commit messages
- Keep commits focused and atomic
- Write clear commit descriptions

Examples:
```
feat(kanban): add drag-and-drop reordering
fix(rituals): resolve completion counter display bug
docs(readme): update installation instructions
refactor(models): add copyWith methods
```

### Pull Request Process

1. **Push your changes**
   ```bash
   git push origin feature/your-feature-name
   ```

2. **Create Pull Request**
   - Go to your fork on GitHub
   - Click "New Pull Request"
   - Select `develop` as base branch
   - Fill in the PR template

3. **PR Requirements**
   - All CI checks must pass
   - At least one reviewer approval
   - No merge conflicts

4. **After Approval**
   - Squash commits if requested
   - Merge using the "Squash and merge" option

## Code Review Guidelines

### For Reviewers

- Check for code style consistency
- Verify tests pass
- Look for potential bugs
- Ensure documentation is updated

### For Contributors

- Respond to feedback promptly
- Make requested changes
- Keep PRs focused and small

## Reporting Issues

### Bug Reports

Include:
- Steps to reproduce
- Expected behavior
- Actual behavior
- Flutter version (`flutter --version`)
- Platform (macOS, Linux, etc.)

### Feature Requests

Describe:
- The use case
- Proposed solution
- Any alternatives considered

## Style Guide

See [docs/style.md](docs/style.md) for detailed coding conventions.

## Questions?

- Open an issue for discussion
- Check existing issues and PRs
