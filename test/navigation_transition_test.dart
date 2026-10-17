import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/style/themes.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

void main() {
  testWidgets("Changing page is instant", (WidgetTester tester) async {
    final router = GoRouter(routes: [
      GoRoute(
          path: "/",
          builder: (context, state) => Scaffold(
              body: TextButton(
                  onPressed: () => context.push("/b"),
                  child: const Text("page A")))),
      GoRoute(
          path: "/b",
          builder: (context, state) => const Scaffold(body: Text("page B"))),
    ]);
    await tester.pumpWidget(MultiNotifier(
        child: MaterialApp.router(
            theme: AppTheme.lightTheme, routerConfig: router)));

    await tester.tap(find.text("page A"));
    await tester.pump(); // a single frame, no animation time elapsed
    expect(find.text("page B"), findsOneWidget);
    expect(tester.hasRunningAnimations, isFalse);
  }, variant: TargetPlatformVariant.all());
}
