import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/ui/buttons/sequence_animation_controls.dart';
import 'package:cradock_map/notifiers/multi_notifier.dart';

void main() {
  testWidgets('Le spinner et le changement de focus sont synchronisés après pause', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiNotifier(
        child: MaterialApp(
          home: Scaffold(
            body: SequenceAnimationControls(),
          ),
        ),
      ),
    );

    final AppStateNotifier notifier = Provider.of<AppStateNotifier>(
      tester.element(find.byType(SequenceAnimationControls)),
      listen: false,
    );

    // 1. Démarrer l'animation
    await tester.tap(find.byIcon(Icons.play_arrow_outlined));
    await tester.pump();
    
    // On attend un peu pour que le spinner avance (ex: 5 secondes)
    await tester.pump(const Duration(seconds: 5));
    
    final int stepIdBeforePause = notifier.selectedStepId;
    
    // 2. Pause
    await tester.tap(find.byIcon(Icons.pause_outlined));
    await tester.pump();
    
    expect(notifier.isAnimating, isFalse);
    expect(notifier.isPaused, isTrue);
    
    // On vérifie la valeur du spinner (approximativement 0.5)
    CircularProgressIndicator spinner = tester.widget(find.byType(CircularProgressIndicator));
    expect(spinner.value, closeTo(0.5, 0.05));
    
    // 3. Play (Reprise)
    await tester.tap(find.byIcon(Icons.play_arrow_outlined));
    await tester.pump();
    
    // On vérifie si l'étape a changé immédiatement.
    // Si elle a changé, le spinner est à 0.5 mais l'étape est la nouvelle -> DESYNC.
    // L'idéal serait qu'elle ne change PAS tout de suite, mais après le temps restant (5s).
    expect(notifier.selectedStepId, equals(stepIdBeforePause), reason: "L'étape NE devrait PAS changer immédiatement à la reprise pour rester synchro avec le spinner");
    
    // On attend les 5 secondes restantes
    await tester.pump(const Duration(seconds: 5));
    
    // Maintenant l'étape devrait avoir changé
    expect(notifier.selectedStepId, isNot(stepIdBeforePause), reason: "L'étape devrait changer après que le spinner ait fini son cycle");
    
    spinner = tester.widget(find.byType(CircularProgressIndicator));
    // Le spinner devrait avoir redémarré (proche de 0)
    expect(spinner.value, closeTo(0.0, 0.1));
  });
}
