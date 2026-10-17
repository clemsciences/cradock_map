import "dart:io";

import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

void main() {
  test("Articles are ranked by their position and have distinct routes", () {
    final routes = <String>{};
    for (var (index, item) in focusData.indexed) {
      expect(item.rank, index, reason: item.title);
      expect(item.title, isNotEmpty);
      expect(item.routeId, isNotEmpty, reason: item.title);
      expect(routes.add(item.routeId), isTrue, reason: item.routeId);
      for (var author in item.author ?? []) {
        expect(authors, contains(author), reason: author.normalizedName);
      }
    }
  });

  test("Articles with several sections start with a summary", () {
    for (var item in focusData) {
      final sections =
          item.parts.where((part) => part.subtitle.isNotEmpty).length;
      if (sections >= 2) {
        expect(item.parts.take(3).map((part) => part.type),
            contains(PartType.summary),
            reason: item.title);
      }
    }
  });

  test("Every image of the articles exists", () {
    for (var item in focusData) {
      for (var part in item.parts) {
        for (var image in [
          if (part.imagePath != null) part.imagePath!,
          ...?part.gallery,
        ]) {
          expect(image, isNotEmpty, reason: item.title);
          expect(File(image).existsSync(), isTrue, reason: image);
        }
        if (part.type == PartType.quote) {
          expect(part.text, isNotEmpty, reason: item.title);
        }
      }
    }
  });

  for (var size in const [Size(390, 844), Size(1400, 900)]) {
    testWidgets("Every article lays out at ${size.width.toInt()} px",
        (WidgetTester tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.reset);
      for (var item in focusData) {
        final router = GoRouter(routes: [
          GoRoute(
              path: "/",
              builder: (context, state) =>
                  FocusItemView(focusItem: item, focus: focusData)),
        ]);
        await tester.pumpWidget(
            MultiNotifier(child: MaterialApp.router(routerConfig: router)));
        await tester.pump();
        expect(tester.takeException(), isNull, reason: item.title);
        await tester.pumpWidget(const SizedBox());
      }
    });
  }
}
