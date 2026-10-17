import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/views/authors_view.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:cradock_map/views/focus_view.dart";
import "package:cradock_map/views/map_view.dart";
import "package:cradock_map/views/references_view.dart";
import "package:cradock_map/views/settings_view.dart";
import "package:cradock_map/views/welcome_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

void main() {
  final pages = <String, Widget Function()>{
    "Accueil": () => const WelcomeView(),
    "Séquence": () => const MapView(),
    "Focus": () => const FocusView(),
    "Article": () =>
        FocusItemView(focusItem: focusData.first, focus: focusData),
    "Référence": () => const ReferencesView(),
    "Auteurs": () => AuthorsView(authors: authors),
    "Paramètres": () => const GeneralView(),
  };

  for (var size in const [Size(1400, 900), Size(360, 740)]) {
    for (var entry in pages.entries) {
      testWidgets("NavBar is at the top center on ${entry.key} at $size",
          (WidgetTester tester) async {
        tester.view.physicalSize = size;
        tester.view.devicePixelRatio = 1.0;
        addTearDown(tester.view.reset);
        final router = GoRouter(routes: [
          GoRoute(path: "/", builder: (context, state) => entry.value()),
        ]);
        await tester.pumpWidget(
            MultiNotifier(child: MaterialApp.router(routerConfig: router)));
        await tester.pump(const Duration(milliseconds: 100));

        // The visible content of the NavBar: from the first to the last
        // button, or the menu on phones.
        Finder inNavBar(String text) => find.ancestor(
            of: find.descendant(
                of: find.byType(NavBar), matching: find.text(text)),
            matching: find.byWidgetPredicate((w) => w is ButtonStyleButton));
        final rect = size.width > NavBar.compactBreakpoint
            ? tester
                .getRect(inNavBar("Accueil"))
                .expandToInclude(tester.getRect(inNavBar("Paramètres")))
            : tester.getRect(find.byType(PopupMenuButton<String>));
        expect(rect.center.dx, moreOrLessEquals(size.width / 2, epsilon: 1));
        expect(tester.getRect(find.byType(NavBar)).top, lessThan(80));
      });
    }
  }
}
