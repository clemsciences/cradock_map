import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cradock_map/views/map_view.dart';
import 'package:cradock_map/notifiers/multi_notifier.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:provider/provider.dart';

import 'package:cradock_map/routes/routes.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('SatMarker displays tooltip with location name', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.WELCOME_ROUTE,
      routes: [
        GoRoute(
          path: AppRoutes.WELCOME_ROUTE,
          builder: (context, state) => const MapView(),
        ),
      ],
    );

    await tester.pumpWidget(
      MultiNotifier(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    final appState = tester.element(find.byType(MapView)).read<AppStateNotifier>();
    
    // On sélectionne une étape pour s'assurer qu'un marqueur est présent
    appState.selectStepId(appState.steps.first.id);
    await tester.pumpAndSettle();

    // On cherche le Tooltip. Dans Flutter, Tooltip enveloppe son enfant.
    // On peut chercher par le message du tooltip.
    final tooltipFinder = find.byType(Tooltip);
    expect(tooltipFinder, findsWidgets);

    final String expectedName = appState.steps.first.name;
    expect(find.byWidgetPredicate((widget) => widget is Tooltip && widget.message == expectedName), findsOneWidget);
  });

  testWidgets('PostHouse markers display generic tooltip', (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.WELCOME_ROUTE,
      routes: [
        GoRoute(
          path: AppRoutes.WELCOME_ROUTE,
          builder: (context, state) => const MapView(),
        ),
      ],
    );

    await tester.pumpWidget(
      MultiNotifier(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    final appState = tester.element(find.byType(MapView)).read<AppStateNotifier>();
    
    // Activer les relais de poste
    appState.switchPostHouses();
    await tester.pumpAndSettle();

    expect(find.byWidgetPredicate((widget) => widget is Tooltip && widget.message == "Relais de poste"), findsWidgets);
  });
}
