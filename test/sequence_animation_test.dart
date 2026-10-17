import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/sequence_animation_controls.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:provider/provider.dart";

void main() {
  testWidgets("Sequence animation controls test", (WidgetTester tester) async {
    final notifier = AppStateNotifier();
    
    await tester.pumpWidget(
      ChangeNotifierProvider<AppStateNotifier>.value(
        value: notifier,
        child: const MaterialApp(
          home: Scaffold(
            body: SequenceAnimationControls(),
          ),
        ),
      ),
    );

    // Verify initial state
    expect(find.byTooltip("Play"), findsOneWidget);
    expect(find.byTooltip("Pause"), findsOneWidget);
    expect(find.byTooltip("Stop"), findsOneWidget);
    
    final playButton = tester.widget<IconButton>(find.ancestor(
      of: find.byIcon(Icons.play_arrow_outlined),
      matching: find.byType(IconButton),
    ));
    final pauseButton = tester.widget<IconButton>(find.ancestor(
      of: find.byIcon(Icons.pause_outlined),
      matching: find.byType(IconButton),
    ));
    
    expect(playButton.onPressed, isNotNull);
    expect(pauseButton.onPressed, isNull);
    expect(notifier.isAnimating, isFalse);

    // Press Play
    await tester.tap(find.byTooltip("Play"));
    await tester.pump();
    
    expect(notifier.isAnimating, isTrue);
    expect(notifier.selectedStepId, isNot(-1));
    
    final playButtonAfter = tester.widget<IconButton>(find.ancestor(
      of: find.byIcon(Icons.play_arrow),
      matching: find.byType(IconButton),
    ));
    final pauseButtonAfter = tester.widget<IconButton>(find.ancestor(
      of: find.byIcon(Icons.pause_outlined),
      matching: find.byType(IconButton),
    ));
    expect(playButtonAfter.onPressed, isNull);
    expect(pauseButtonAfter.onPressed, isNotNull);

    // Press Pause
    await tester.tap(find.byTooltip("Pause"));
    await tester.pump();
    
    expect(notifier.isAnimating, isFalse);
    
    // Press Stop
    await tester.tap(find.byTooltip("Stop"));
    await tester.pump();
    
    expect(notifier.isAnimating, isFalse);
    expect(notifier.selectedStepId, equals(notifier.steps.first.id));
  });
}
