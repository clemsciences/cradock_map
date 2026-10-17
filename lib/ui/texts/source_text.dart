import "package:cradock_map/models/text.dart";
import "package:flutter/material.dart";

/// A passage of Mme Cradock's journal: heading, text and editor's notes.
class SourceText extends StatelessWidget {
  final JournalPassage passage;

  const SourceText({super.key, required this.passage});

  /// Turns the *italic* markers of the data into styled spans.
  static List<TextSpan> spansOf(String text) => [
        for (var (index, part) in text.split("*").indexed)
          TextSpan(
              text: part,
              style: index.isOdd
                  ? const TextStyle(fontStyle: FontStyle.italic)
                  : null),
      ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SelectionArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(passage.title, style: textTheme.titleMedium),
          Text("${passage.date} · ${passage.pages}",
              style: textTheme.bodySmall),
          for (var paragraph in passage.paragraphs)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text.rich(TextSpan(children: spansOf(paragraph))),
            ),
          for (var (index, note) in passage.notes.indexed)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "${index + 1}. "),
                    ...spansOf(note),
                  ]),
                  style: textTheme.bodySmall),
            ),
        ],
      ),
    );
  }
}
