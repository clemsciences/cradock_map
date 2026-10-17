import "package:cradock_map/data/commune_boundary_data.dart";
import "package:cradock_map/data/path_data.dart";
import "package:cradock_map/data/post_house_data.dart";
import "package:cradock_map/data/step_data.dart";
import "package:cradock_map/models/commune_boundary.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/commune_boundaries_switch.dart";
import "package:cradock_map/views/map_view.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";
import "package:latlong2/latlong.dart";
import "package:provider/provider.dart";

/// Ray casting on an outer ring, minus its holes.
bool contains(CommuneBoundary commune, LatLng point) {
  bool inRing(List<LatLng> ring) {
    var inside = false;
    for (var i = 0, j = ring.length - 1; i < ring.length; j = i++) {
      final a = ring[i], b = ring[j];
      if ((a.latitude > point.latitude) != (b.latitude > point.latitude) &&
          point.longitude <
              (b.longitude - a.longitude) *
                      (point.latitude - a.latitude) /
                      (b.latitude - a.latitude) +
                  a.longitude) {
        inside = !inside;
      }
    }
    return inside;
  }

  return commune.parts
      .any((part) => inRing(part.outer) && !part.holes.any(inRing));
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test("The bundled communes cover the itinerary", () async {
    final communes = await CommuneBoundaryData.load();

    // Every point of the itinerary lies in exactly one commune: the bundled
    // area is large enough and communes do not overlap.
    for (var point in [
      ...PathData.points,
      ...StepData.steps.map((step) => step.position),
      ...PostHouseData.points,
    ]) {
      expect(
          communes.where((commune) => contains(commune, point)), hasLength(1),
          reason: "$point");
    }

    CommuneBoundary communeOf(LatLng point) =>
        communes.singleWhere((commune) => contains(commune, point));
    String stepCommune(int id) =>
        communeOf(StepData.steps.firstWhere((s) => s.id == id).position).name;

    expect(stepCommune(1), "Langeais");
    expect(stepCommune(2), "Cinq-Mars-la-Pile");
    for (var id in [3, 4, 5, 6, 7, 8]) {
      expect(stepCommune(id), "Tours");
    }
    expect(stepCommune(9), "Amboise");
  });

  Future<AppStateNotifier> pumpMap(WidgetTester tester,
      {required bool preload}) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final notifier = AppStateNotifier();
    if (preload) {
      // What the map does once displayed; asset loading is real I/O, so it
      // has to run outside the fake clock of widget tests.
      await tester.runAsync(() => notifier.preloadCommuneBoundaries());
    }
    final router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => const MapView()),
    ]);
    await tester.pumpWidget(ChangeNotifierProvider<AppStateNotifier>.value(
        value: notifier, child: MaterialApp.router(routerConfig: router)));
    return notifier;
  }

  Finder switchTile() => find.descendant(
      of: find.byType(CommuneBoundariesSwitch),
      matching: find.byType(SwitchListTile));

  testWidgets("Once preloaded, the switch shows the boundaries at once",
      (WidgetTester tester) async {
    final appState = await pumpMap(tester, preload: true);
    expect(find.byType(PolygonLayer), findsNothing);

    await tester.tap(find.byType(CommuneBoundariesSwitch));
    await tester.pump(); // a single frame
    final layer = tester.widget<PolygonLayer>(find.byType(PolygonLayer));
    expect(layer.polygons.where((p) => p.label == "Langeais"), hasLength(1));
    expect(
        find.descendant(
            of: find.byType(CommuneBoundariesSwitch),
            matching: find.byType(CircularProgressIndicator)),
        findsNothing);

    await tester.tap(find.byType(CommuneBoundariesSwitch));
    await tester.pump(const Duration(seconds: 1));
    expect(appState.showCommuneBoundaries, isFalse);
    expect(find.byType(PolygonLayer), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets("The switch shows a spinner while the data is not loaded yet",
      (WidgetTester tester) async {
    await pumpMap(tester, preload: false);

    await tester.tap(find.byType(CommuneBoundariesSwitch));
    await tester.pump();
    expect(tester.widget<SwitchListTile>(switchTile()).value, isTrue);
    expect(
        find.descendant(
            of: find.byType(CommuneBoundariesSwitch),
            matching: find.byType(CircularProgressIndicator)),
        findsOneWidget);
    await tester.pump(const Duration(seconds: 1));
  });
}
