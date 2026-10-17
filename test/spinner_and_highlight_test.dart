import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/ui/buttons/sequence_animation_controls.dart';
import 'package:cradock_map/ui/step/step_tile.dart';
import 'package:cradock_map/models/path_step.dart';
import 'package:latlong2/latlong.dart';

void main() {
  late AppStateNotifier notifier;

  setUp(() {
    notifier = AppStateNotifier();
  });

  Widget createWidgetUnderTest(Widget child) {
    return MaterialApp(
      home: ChangeNotifierProvider<AppStateNotifier>.value(
        value: notifier,
        child: Scaffold(body: child),
      ),
    );
  }

  testWidgets('SequenceAnimationControls shows spinner when animating', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(const SequenceAnimationControls()));

    // Initialement, pas de spinner visible (value 0 ou couleur transparente)
    final initialSpinner = tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
    expect(initialSpinner.value, 0.0);

    // Démarrer l'animation
    await tester.tap(find.byTooltip('Play'));
    await tester.pump();

    // Maintenant le spinner devrait avoir une valeur > 0 après un peu de temps
    await tester.pump(const Duration(milliseconds: 100));
    final activeSpinner = tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
    expect(activeSpinner.value, isNotNull);
    expect(activeSpinner.value, isPositive);
    
    // Stop l'animation
    await tester.tap(find.byTooltip('Stop'));
    await tester.pump();
    
    final stoppedSpinner = tester.widget<CircularProgressIndicator>(find.byType(CircularProgressIndicator));
    expect(stoppedSpinner.value, 0.0);
  });

  testWidgets('StepTile shows highlighted background when selected', (WidgetTester tester) async {
    final step = PathStep(
      id: 1,
      name: 'Test Step',
      description: '',
      references: [],
      position: const LatLng(0, 0),
      zoom: 10,
    );
    
    // Non sélectionné
    await tester.pumpWidget(createWidgetUnderTest(StepTile(step: step, selectedStepId: 2)));
    
    final materialNotSelected = tester.widget<Material>(find.byType(Material).last);
    expect(materialNotSelected.color, Colors.transparent);

    // Sélectionné
    await tester.pumpWidget(createWidgetUnderTest(StepTile(step: step, selectedStepId: 1)));
    
    final materialSelected = tester.widget<Material>(find.byType(Material).last);
    expect(materialSelected.color, isNot(Colors.transparent));
  });
}
