## Platform Integration

### macOS Features
- Menu bar integration via window_manager
- Always-on-top floating window mode
- Native system tray support

### Linux Features
- AppImage build support
- Flatpak packaging ready
- System tray integration

## Build & Distribution

### macOS
```bash
flutter build macos --release
# Creates .app bundle in build/macos/Build/Products/Release/
```

### Linux
```bash
flutter build linux --release
# Creates executable in build/linux/x64/release/bundle/
```

### Android
```bash
flutter build apk
# Creates APK in build/app/outputs/flutter-apk/
```

### iOS
```bash
flutter build ios
# Creates IPA in build/ios/iphoneos/
```

## Running Tests
```bash
# Run all tests
flutter test

# Run single test file
flutter test test/unit_test.dart

# Run tests with coverage
flutter test --coverage
```
