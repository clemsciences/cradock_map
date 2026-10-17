import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/step_data.dart";
import "package:cradock_map/ui/texts/source_text.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";

void main() {
  const passages = CradockTextData.passages;

  test("Every passage refers to existing steps", () {
    final stepIds = {for (var step in StepData.steps) step.id};
    for (var passage in passages) {
      expect(stepIds.containsAll(passage.stepIds), isTrue,
          reason: passage.title);
    }
  });

  test("Every step has at least one passage of the journal", () {
    for (var step in StepData.steps) {
      expect(CradockTextData.passagesOf(step.id), isNotEmpty,
          reason: step.name);
    }
  });

  test("Passages follow the pages of the edition", () {
    var lastPage = 281;
    for (var passage in passages) {
      expect(passage.firstPage, greaterThanOrEqualTo(lastPage),
          reason: passage.title);
      expect(passage.lastPage, greaterThanOrEqualTo(passage.firstPage));
      expect(passage.lastPage, lessThanOrEqualTo(294));
      lastPage = passage.lastPage;
    }
  });

  test("Each footnote call has its note, and the text is clean", () {
    const calls = ["¹", "²", "³"];
    for (var passage in passages) {
      final text = passage.paragraphs.join("\n");
      final used = calls.where(text.contains).length;
      expect(used, passage.notes.length, reason: passage.title);
      for (var paragraph in [...passage.paragraphs, ...passage.notes]) {
        // No OCR leftovers nor words split at a line end.
        expect(paragraph, isNot(matches(RegExp(r"[~)]\w|\w- \w|\bn8"))),
            reason: paragraph);
        expect("*".allMatches(paragraph).length.isEven, isTrue,
            reason: paragraph);
      }
    }
  });

  testWidgets("A passage is displayed with its notes",
      (WidgetTester tester) async {
    final chanteloup = CradockTextData.passagesOf(9).single;
    await tester.pumpWidget(MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
                child: SourceText(passage: chanteloup)))));
    expect(find.text("Chanteloup"), findsOneWidget);
    expect(find.textContaining("Arthur Young", findRichText: true),
        findsOneWidget);
    expect(find.textContaining("*", findRichText: true), findsNothing);
  });
}
