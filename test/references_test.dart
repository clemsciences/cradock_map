import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/data/reference_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/views/references_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

void main() {
  final references = [
    for (var section in ReferenceData.sections) ...section.references
  ];

  test("The online sources of the quoted texts are listed", () {
    final urls = references.map((reference) => reference.url);
    expect(urls, contains(CradockTextData.book.url));
    expect(urls, contains("https://gallica.bnf.fr/ark:/12148/bpt6k57743479"));
  });

  test("Every article quoting a source is linked from its reference", () {
    final soreau =
        references.firstWhere((reference) => reference.text.contains("Soreau"));
    final journal = references.first;
    for (var item in focusData) {
      final sources = [
        for (var part in item.parts)
          if (part.type == PartType.quote) part.legend ?? ""
      ];
      if (sources.any((source) => source.contains(SoreauTextData.source))) {
        expect(soreau.articles, contains(item), reason: item.title);
      }
      if (sources.any((source) => source.contains("Journal de Mme Cradock"))) {
        expect(journal.articles, contains(item), reason: item.title);
      }
    }
  });

  test("Every article is cited by a reference other than its origin", () {
    final cited = {
      for (var section in ReferenceData.sections
          .where((section) => section.title != "Origine des articles"))
        for (var reference in section.references) ...reference.citedIn
    };
    for (var item in focusData) {
      expect(cited, contains(item), reason: item.title);
    }
  });

  testWidgets("The page shows every section", (WidgetTester tester) async {
    // Tall enough for the whole page to be built.
    tester.view.physicalSize = const Size(1400, 12000);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final router = GoRouter(routes: [
      GoRoute(path: "/", builder: (context, state) => const ReferencesView()),
    ]);
    await tester.pumpWidget(
        MultiNotifier(child: MaterialApp.router(routerConfig: router)));
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text(ReferenceData.title), findsWidgets);
    for (var section in ReferenceData.sections) {
      expect(find.text(section.title), findsOneWidget);
    }
    expect(find.text(focusData.last.title), findsWidgets);
  });
}
