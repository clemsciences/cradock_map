// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/views/welcome_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

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
