import "dart:math";

import "package:cradock_map/data/focus.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/style/style.dart";
import "package:cradock_map/style/themes.dart";
import "package:cradock_map/ui/texts/text_link.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

/// WCAG contrast ratio between two opaque colours.
double contrast(Color a, Color b) {
  double luminance(Color c) {
    double channel(double v) =>
        v <= 0.03928 ? v / 12.92 : pow((v + 0.055) / 1.055, 2.4).toDouble();
    return 0.2126 * channel(c.r) +
        0.7152 * channel(c.g) +
        0.0722 * channel(c.b);
  }

  final (l1, l2) = (luminance(a), luminance(b));
  return (max(l1, l2) + 0.05) / (min(l1, l2) + 0.05);
}

void main() {
  test("Links and legends have a WCAG AA contrast (4.5:1)", () {
    final scheme = AppTheme.lightTheme.colorScheme;
    expect(contrast(scheme.primary, scheme.surface), greaterThanOrEqualTo(4.5));
    expect(contrast(Colors.white, SatStyle.darkBlueColor),
        greaterThanOrEqualTo(4.5));
  });

  testWidgets("An article is usable with a screen reader",
      (WidgetTester tester) async {
    final semantics = tester.ensureSemantics();
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final article =
        focusData.firstWhere((item) => item.routeId == "chanteloup");
    final router = GoRouter(routes: [
      GoRoute(
          path: "/",
          builder: (context, state) =>
              FocusItemView(focusItem: article, focus: focusData)),
    ]);
    await tester.pumpWidget(MultiNotifier(
        child: MaterialApp.router(
            theme: AppTheme.lightTheme, routerConfig: router)));
    await tester.pump();

    // Title and sections are headings.
    expect(
        find.byWidgetPredicate(
            (w) => w is Semantics && (w.properties.header ?? false)),
        findsAtLeastNWidgets(3));

    // Summary and authors are links reachable with the keyboard.
    expect(find.byType(TextLink), findsAtLeastNWidgets(6));
    final link = tester.getSemantics(find.byType(TextLink).first);
    expect(link.flagsCollection.isLink, isTrue);

    // Images are described by their legend.
    expect(
        find.bySemanticsLabel(
            RegExp("Château de Chanteloup. Bourgerie, lithographie")),
        findsOneWidget);
    semantics.dispose();
  });
}
