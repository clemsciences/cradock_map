import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/ui/buttons/view_mode_switch.dart';
import 'package:cradock_map/models/view_mode.dart';

void main() {
  Widget createWidgetUnderTest(AppStateNotifier notifier) {
    return MaterialApp(
      home: ChangeNotifierProvider<AppStateNotifier>.value(
        value: notifier,
        child: const Scaffold(
          body: ViewModeRadioButton(),
        ),
      ),
    );
  }

  testWidgets('ViewModeRadioButton is hidden when NOT in expert mode', (WidgetTester tester) async {
    final notifier = AppStateNotifier();
    notifier.isExpertMode = false;

    await tester.pumpWidget(createWidgetUnderTest(notifier));

    // Le SegmentedButton ne devrait pas être présent
    expect(find.byType(SegmentedButton<ViewMode>), findsNothing);
  });

  testWidgets('ViewModeRadioButton is visible when in expert mode', (WidgetTester tester) async {
    final notifier = AppStateNotifier();
    notifier.isExpertMode = true;

    await tester.pumpWidget(createWidgetUnderTest(notifier));

    // Le SegmentedButton devrait être présent
    expect(find.byType(SegmentedButton<ViewMode>), findsOneWidget);
  });

  testWidgets('Switching off expert mode resets view mode to sequence', (WidgetTester tester) async {
    final notifier = AppStateNotifier();
    notifier.isExpertMode = true;
    notifier.updateViewMode(ViewMode.balade);
    
    expect(notifier.viewMode, equals(ViewMode.balade));

    notifier.switchExpertMode(); // Passe à false
    
    expect(notifier.isExpertMode, isFalse);
    expect(notifier.viewMode, equals(ViewMode.sequence));
  });
}
