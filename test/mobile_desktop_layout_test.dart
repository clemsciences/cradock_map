import "package:cradock_map/data/focus.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:cradock_map/views/focus_view.dart";
import "package:cradock_map/views/map_view.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:provider/provider.dart";

Widget buildApp(GoRouter router) {
  return MultiNotifier(child: MaterialApp.router(routerConfig: router));
}

void setScreenSize(WidgetTester tester, Size size) {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

void main() {
  testWidgets("Tapping the map only adds a track point in expert mode",
      (WidgetTester tester) async {
    final router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => const MapView()),
    ]);
    await tester.pumpWidget(buildApp(router));
    final appState =
        tester.element(find.byType(MapView)).read<AppStateNotifier>();
    final initialCount = appState.trackPoints.length;

    await tester.tap(find.byType(FlutterMap));
    await tester.pump(const Duration(seconds: 1));
    expect(appState.trackPoints.length, initialCount);

    appState.switchExpertMode();
    await tester.pump();
    await tester.tap(find.byType(FlutterMap));
    await tester.pump(const Duration(seconds: 1));
    expect(appState.trackPoints.length, initialCount + 1);
  });

  testWidgets("Tapping the title text of a focus tile opens the article",
      (WidgetTester tester) async {
    final router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => const FocusView()),
      GoRoute(
          path: AppRoutes.getFocusItemRoute(focusData.first),
          builder: (context, state) => const Text("article ouvert")),
    ]);
    await tester.pumpWidget(buildApp(router));

    await tester.tap(find.text(focusData.first.title));
    await tester.pumpAndSettle();
    expect(find.text("article ouvert"), findsOneWidget);
  });

  testWidgets("NavBar is a single menu on phones", (WidgetTester tester) async {
    setScreenSize(tester, const Size(360, 740));
    final router = GoRouter(routes: [
      GoRoute(
          path: "/",
          builder: (context, state) => const Scaffold(body: NavBar())),
    ]);
    await tester.pumpWidget(buildApp(router));

    expect(find.byType(PopupMenuButton<String>), findsOneWidget);
    expect(find.text("Paramètres"), findsNothing);
    expect(find.text("Accueil"), findsOneWidget);
  });

  testWidgets("The map takes most of the height on a laptop screen",
      (WidgetTester tester) async {
    setScreenSize(tester, const Size(1400, 900));
    final router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => const MapView()),
    ]);
    await tester.pumpWidget(buildApp(router));
    await tester.pump(const Duration(seconds: 1));
    // Nav bar and options take at most ~260 px: the map gets the rest.
    expect(tester.getSize(find.byType(FlutterMap)).height, greaterThan(600));
  });

  for (var size in const [Size(360, 740), Size(1366, 768), Size(740, 360)]) {
    testWidgets("Map page does not overflow at $size in expert mode",
        (WidgetTester tester) async {
      setScreenSize(tester, size);
      final router = GoRouter(routes: [
        GoRoute(path: "/", builder: (context, state) => const MapView()),
      ]);
      await tester.pumpWidget(buildApp(router));
      tester.element(find.byType(MapView)).read<AppStateNotifier>()
        ..switchExpertMode()
        ..switchShowAllMarkers();
      await tester.pump(const Duration(seconds: 1));
      expect(tester.takeException(), isNull);
    });
  }

  for (var item in focusData) {
    testWidgets("Focus article '${item.title}' does not overflow on a phone",
        (WidgetTester tester) async {
      setScreenSize(tester, const Size(360, 740));
      final router = GoRouter(routes: [
        GoRoute(
            path: "/",
            builder: (context, state) =>
                FocusItemView(focusItem: item, focus: focusData)),
      ]);
      await tester.pumpWidget(buildApp(router));
      await tester.pump(const Duration(seconds: 1));
      // A RenderFlex overflow would be reported as an exception.
      expect(tester.takeException(), isNull);
    });
  }
}
