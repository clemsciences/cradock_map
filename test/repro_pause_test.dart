import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/ui/buttons/sequence_animation_controls.dart';
import 'package:cradock_map/notifiers/multi_notifier.dart';

void main() {
  testWidgets('Pause button should stop the timer and keep progress', (WidgetTester tester) async {
    final appState = AppStateNotifier();
    
    await tester.pumpWidget(
      ChangeNotifierProvider<AppStateNotifier>.value(
        value: appState,
        child: const MaterialApp(
          home: Scaffold(
            body: SequenceAnimationControls(),
          ),
        ),
      ),
    );

    // Initial state: not animating
    expect(appState.isAnimating, isFalse);

    // Click Play
    await tester.tap(find.byTooltip('Play'));
    await tester.pump();
    expect(appState.isAnimating, isTrue);

    // Wait for some animation progress (e.g., 2 seconds)
    await tester.pump(const Duration(seconds: 2));
    
    // Find the CircularProgressIndicator and check its value
    Finder indicatorFinder = find.byType(CircularProgressIndicator);
    CircularProgressIndicator indicator = tester.widget<CircularProgressIndicator>(indicatorFinder);
    double valueBeforePause = indicator.value!;
    expect(valueBeforePause, greaterThan(0));
    expect(valueBeforePause, lessThan(1));

    // Click Pause
    await tester.tap(find.byTooltip('Pause'));
    await tester.pump();
    expect(appState.isAnimating, isFalse);

    // Check value after pause
    indicator = tester.widget<CircularProgressIndicator>(indicatorFinder);
    expect(indicator.value, valueBeforePause, reason: 'Progress should be kept after pause');

    // Click Play again - should resume from SAME position
    await tester.tap(find.byTooltip('Play'));
    await tester.pump();
    expect(appState.isAnimating, isTrue);
    expect(appState.isPaused, isFalse);

    indicator = tester.widget<CircularProgressIndicator>(indicatorFinder);
    expect(indicator.value, closeTo(valueBeforePause, 0.01), reason: 'Should resume from same position');

    // Wait 1 more second
    await tester.pump(const Duration(seconds: 1));
    indicator = tester.widget<CircularProgressIndicator>(indicatorFinder);
    expect(indicator.value, greaterThan(valueBeforePause));

    // Click Stop
    await tester.tap(find.byTooltip('Stop'));
    await tester.pump();
    expect(appState.isAnimating, isFalse);
    expect(appState.isPaused, isFalse);
    
    indicator = tester.widget<CircularProgressIndicator>(indicatorFinder);
    expect(indicator.value, 0.0, reason: 'Progress should be reset after stop');
  });
}
