# Project Guidelines

## Build/Configuration Instructions

This project is a Flutter web-enabled application.

### Prerequisites
- Flutter SDK (>=3.4.3)
- Chrome or any modern web browser

### Setup
1. Clone the repository.
2. Run `flutter pub get` to install dependencies.

### Running the Project
- **Web**: `flutter run -d chrome`
- **Mobile/Desktop**: `flutter run`

### Web Configuration
- The project uses `usePathUrlStrategy()` in `lib/main.dart` for clean URLs on the web.
- Routing is managed by `go_router` in `lib/routes/routes.dart`.

## Testing Information

### Running Tests
- Run all tests: `flutter test`
- Run a specific test: `flutter test test/path_to_test.dart`

### Adding New Tests
- Place all test files in the `test/` directory.
- Test files should end with `_test.dart`.
- For widget tests, ensure you wrap the widget with `MultiNotifier` if it depends on project providers.

### Test Example
Below is a verified simple widget test for the `WelcomeView`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cradock_map/views/welcome_view.dart';
import 'package:cradock_map/notifiers/multi_notifier.dart';

void main() {
  testWidgets('WelcomeView displays welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiNotifier(
        child: MaterialApp(
          home: WelcomeView(),
        ),
      ),
    );

    // Verify that our welcome text is present.
    expect(find.text('Bienvenue sur le site de Mme Cradock en Touraine'), findsOneWidget);
    
    // Verify that the SAT image is present.
    expect(find.byType(Image), findsOneWidget);
  });
}
```

## Additional Development Information

### Code Style & Patterns
- **Widget Definitions**: Each widget must be defined in its own file.
- **Constants**: All constants must be defined as `static const` attributes within a class (e.g., `AppRoutes` in `lib/routes/routes.dart` or `SatStyle` in `lib/style/style.dart`).
- **Routing**:
    - Uses `go_router`.
    - Defined in `lib/routes/routes.dart`.
    - Supports web strategy (clean paths).
    - Includes an error page (currently redirects to `WelcomeView`).
- **Theming**:
    - Centralized theme management in `lib/style/themes.dart` using the `AppTheme` class.
    - Used at the root in `lib/main.dart`.
- **Internationalization**:
    - The project is intended to support French and English.
- **State Management**:
    - Uses `provider` via `MultiNotifier` in `lib/notifiers/multi_notifier.dart`.
- **Tests**:
  - Keep all the tests that the AI might generate.

