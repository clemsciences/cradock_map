import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:cradock_map/views/welcome_view.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";

import "package:cradock_map/routes/routes.dart";
import "package:go_router/go_router.dart";

void main() {
  testWidgets("WelcomeView displays welcome text", (WidgetTester tester) async {
    final router = GoRouter(
      initialLocation: AppRoutes.WELCOME_ROUTE,
      routes: [
        GoRoute(
          path: AppRoutes.WELCOME_ROUTE,
          builder: (context, state) => WelcomeView(),
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

    // Verify that our welcome text is present.
    expect(find.text("Bienvenue sur le site de Mme Cradock en Touraine"), findsOneWidget);

    // Verify that the SAT image is present.
    expect(find.byType(Image), findsOneWidget);
  });
}