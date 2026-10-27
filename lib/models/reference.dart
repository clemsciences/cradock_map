import "package:cradock_map/models/focus_item.dart";

/// A work, document or data set used by the site, as listed on the
/// references page.
class Reference {
  /// Bibliographic description, e.g. "Auteur, Titre, lieu, année".
  final String text;

  /// Online version (Gallica, IGN…), if any.
  final String? url;

  /// Where the site uses it besides the articles, e.g. "la carte".
  final String? usedIn;

  /// Articles that quote it or show it.
  final List<FocusItem> citedIn;

  const Reference(this.text, {this.url, this.usedIn, this.citedIn = const []});

  /// [citedIn] without duplicates, in the order of the articles.
  List<FocusItem> get articles =>
      {...citedIn}.toList()..sort((a, b) => a.rank.compareTo(b.rank));
}

class ReferenceSection {
  final String title;
  final String? introduction;
  final List<Reference> references;

  const ReferenceSection(
      {required this.title, this.introduction, required this.references});
}
