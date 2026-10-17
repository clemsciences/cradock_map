class CradockOriginalBook {
  final String title;
  final String subtitle;
  final String publisher;
  final String publicationLocation;
  final int year;
  final String url;

  const CradockOriginalBook(
      {required this.title,
      required this.subtitle,
      required this.publisher,
      required this.publicationLocation,
      required this.year,
      required this.url});
}

/// An excerpt of Mme Cradock's journal about one place of the journey.
class JournalPassage {
  /// Short heading, e.g. "La cathédrale".
  final String title;

  /// Day of the journal entry, as printed, e.g. "jeudi 15 septembre 1785".
  final String date;

  /// Ids of the [PathStep]s the passage is about (empty for the road between
  /// two steps or a place without a step).
  final List<int> stepIds;

  /// Pages of the 1896 edition.
  final int firstPage;
  final int lastPage;

  /// The journal text, one string per paragraph. Footnote calls are written
  /// "¹", "²"… and refer to [notes] in order.
  final List<String> paragraphs;

  /// Footnotes of the 1896 editor (not by Mme Cradock).
  final List<String> notes;

  const JournalPassage(
      {required this.title,
      required this.date,
      required this.stepIds,
      required this.firstPage,
      required this.lastPage,
      required this.paragraphs,
      this.notes = const []});

  String get pages =>
      firstPage == lastPage ? "p. $firstPage" : "p. $firstPage-$lastPage";

  /// The text without the italic markers and footnote calls.
  String get plainText => paragraphs
      .map((paragraph) => paragraph.replaceAll(RegExp(r"[*¹²³]"), ""))
      .join("\n");

  /// The text of [passages], each day introduced by its date.
  static String quoteOf(List<JournalPassage> passages) {
    final lines = <String>[];
    String? date;
    for (var passage in passages) {
      if (passage.date != date) {
        date = passage.date;
        if (lines.isNotEmpty) lines.add("");
        lines.add("${date[0].toUpperCase()}${date.substring(1)}.");
      }
      lines.add(passage.plainText);
    }
    return lines.join("\n");
  }
}
