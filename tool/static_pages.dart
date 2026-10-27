// Static HTML pages of the site, generated after `flutter build web`.
//
// The Flutter app draws everything in a canvas: search engines, link
// previews (Open Graph) and screen readers, until the app has started, see
// almost no text. Each route with editorial content therefore gets a real
// HTML page: the built index.html with the title, description, preview image
// and the full text of the page. The app then starts on top of it as usual.
//
// The pages are written as `<route>.html` (e.g. focus/cathedrale.html):
// GitHub Pages serves them for the URL without extension, so the app sees the
// same path as before. 404.html (a copy of index.html) covers the other
// routes. Run with `flutter test tool/generate_static_pages.dart`.

import "dart:convert";
import "dart:io";

import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/data/image_previews.dart";
import "package:cradock_map/data/legal_data.dart";
import "package:cradock_map/data/reference_data.dart";
import "package:cradock_map/data/step_data.dart";
import "package:cradock_map/models/author.dart";
import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/routes/routes.dart";

class StaticPage {
  StaticPage(
      {required this.route,
      required this.title,
      required this.description,
      required this.body,
      this.image,
      this.jsonLd});

  /// App route, e.g. "/focus/cathedrale" ("/" for the home page).
  final String route;
  final String title;
  final String description;

  /// HTML of the content (inside <main>).
  final String body;

  /// Asset shown in link previews (light preview), if any.
  final String? image;
  final Map<String, Object?>? jsonLd;

  /// File written in the build directory.
  String get fileName =>
      route == "/" ? "index.html" : "${route.substring(1)}.html";
}

class StaticSite {
  StaticSite({required this.template, required this.siteUrl});

  /// The built index.html.
  final String template;

  /// Public URL of the site, ending with "/".
  final String siteUrl;

  static const String siteName = "Le voyage de Mme Cradock en Touraine";
  static const String defaultImage = "icons/SAT-couleur-1000.png";
  static const String publisher = "Société archéologique de Touraine";

  // "/" and "'" left as they are: the attributes are quoted with ".
  static const HtmlEscape _escape = HtmlEscape(
      HtmlEscapeMode(name: "page", escapeLtGt: true, escapeQuot: true));
  static String esc(String text) => _escape.convert(text);

  String url(String route) =>
      Uri.encodeFull(siteUrl + (route == "/" ? "" : route.substring(1)));

  /// URL of an asset of the app (Flutter serves them under assets/).
  String assetUrl(String asset) => Uri.encodeFull("assets/$asset");

  List<StaticPage> get pages => [
        _home(),
        _focusList(),
        for (var item in focusData) _article(item),
        _sequence(),
        _authorList(),
        for (var author in authors) _author(author),
        _references(),
        _legal(),
      ];

  /// Relative file name -> content, ready to be written.
  Map<String, String> files() => {
        for (var page in pages) page.fileName: render(page),
        "404.html": template,
        "sitemap.xml": sitemap(),
        "robots.txt":
            "User-agent: *\nAllow: /\n\nSitemap: ${siteUrl}sitemap.xml\n",
      };

  void writeTo(Directory out) {
    files().forEach((name, content) {
      final file = File("${out.path}/$name");
      file.parent.createSync(recursive: true);
      file.writeAsStringSync(content);
    });
  }

  String sitemap() => [
        '<?xml version="1.0" encoding="UTF-8"?>',
        '<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">',
        for (var page in pages)
          "  <url><loc>${esc(url(page.route))}</loc></url>",
        "</urlset>",
        "",
      ].join("\n");

  String render(StaticPage page) {
    final title = page.route == "/" ? page.title : "${page.title} – $siteName";
    final image = page.image == null
        ? siteUrl + defaultImage
        : siteUrl + assetUrl(ImagePreviews.pathOf(page.image!));
    final meta = [
      "<title>${esc(title)}</title>",
      '<meta name="description" content="${esc(page.description)}">',
      '<link rel="canonical" href="${esc(url(page.route))}">',
      '<meta property="og:type" content="${page.jsonLd == null ? "website" : "article"}">',
      '<meta property="og:site_name" content="${esc(siteName)}">',
      '<meta property="og:locale" content="fr_FR">',
      '<meta property="og:url" content="${esc(url(page.route))}">',
      '<meta property="og:title" content="${esc(page.title)}">',
      '<meta property="og:description" content="${esc(page.description)}">',
      '<meta property="og:image" content="${esc(image)}">',
      '<meta name="twitter:card" content="summary_large_image">',
      if (page.jsonLd != null)
        '<script type="application/ld+json">${jsonEncode(page.jsonLd).replaceAll("</", "<\\/")}</script>',
    ].map((line) => "  $line").join("\n");
    final content = '  <main id="page-content">\n${page.body}\n  </main>';
    return _replaceBetween(
        _replaceBetween(
            template, "<!-- page-meta", "<!-- /page-meta -->", meta),
        "<!-- page-content",
        "<!-- /page-content -->",
        content);
  }

  /// Replaces what lies between the comment starting with [start] (kept)
  /// and [end] (kept): running the generator again gives the same pages.
  static String _replaceBetween(
      String text, String start, String end, String replacement) {
    final from = text.indexOf(start);
    final to = text.indexOf(end);
    if (from < 0 || to < from) {
      throw StateError("Marker $start not found in index.html");
    }
    final afterStart = text.indexOf("-->", from) + 3;
    return "${text.substring(0, afterStart)}\n$replacement\n  ${text.substring(to)}";
  }

  // Pages.

  String _nav() => """
    <nav aria-label="Navigation principale"><ul>
      <li><a href="">Accueil</a></li>
      <li><a href="sequence">Séquence (carte)</a></li>
      <li><a href="focus">Focus</a></li>
      <li><a href="references">Références</a></li>
      <li><a href="auteurs">Auteurs</a></li>
      <li><a href="mentions-legales">Mentions légales et crédits</a></li>
    </ul></nav>""";

  String _link(String route, String text) =>
      '<a href="${esc(Uri.encodeFull(route.substring(1)))}">${esc(text)}</a>';

  String _focusLinks() => [
        "<ul>",
        for (var item in focusData)
          "  <li>${_link(AppRoutes.getFocusItemRoute(item), item.title)}${item.author == null ? "" : ", par ${esc(_names(item.author!))}"}</li>",
        "</ul>",
      ].join("\n");

  static String _names(List<Author> authors) =>
      _join([for (var author in authors) author.normalizedName]);

  /// "A, B et C".
  static String _join(List<String> items) => items.length < 2
      ? items.join()
      : "${items.sublist(0, items.length - 1).join(", ")} et ${items.last}";

  StaticPage _home() => StaticPage(
      route: "/",
      title: "$siteName (1785)",
      description:
          "Carte interactive et articles de la Société archéologique de Touraine sur le voyage d'Anna Francisca Cradock de Langeais à Amboise en septembre 1785, d'après son journal.",
      body: """
${_nav()}
    <h1>${esc(siteName)}</h1>
    <p>Du 14 au 18 septembre 1785, l'Anglaise Anna Francisca Cradock traverse la Touraine, de Langeais à Amboise, et note chaque jour ce qu'elle voit. Ce site de la ${esc(publisher)} suit son itinéraire sur la carte de l'état-major et commente les lieux qu'elle décrit.</p>
    <h2>Les articles</h2>
${_focusLinks()}""");

  StaticPage _focusList() => StaticPage(
      route: AppRoutes.FOCUS_ROUTE,
      title: "Focus",
      description:
          "Les articles sur les lieux du voyage de Mme Cradock en Touraine : Langeais, Tours, Marmoutier, Chanteloup…",
      body: """
${_nav()}
    <h1>Focus</h1>
${_focusLinks()}""");

  StaticPage _article(FocusItem item) {
    final route = AppRoutes.getFocusItemRoute(item);
    final images = [
      for (var part in item.parts) ...[
        if (part.imagePath?.isNotEmpty ?? false) part.imagePath!,
        ...?part.gallery,
      ]
    ];
    final sections = [
      for (var part in item.parts)
        if (part.subtitle.isNotEmpty) part
    ];
    String anchor(FocusItemPart part) =>
        "section-${sections.indexOf(part) + 1}";
    final html = <String>[
      _nav(),
      "    <article>",
      "    <h1>${esc(item.title)}</h1>",
      if (item.author != null)
        "    <p>par ${_join([
              for (var author in item.author!)
                _link(
                    AppRoutes.getAuthorItemRoute(author), author.normalizedName)
            ])}</p>",
      for (var part in item.parts)
        ...switch (part.type) {
          PartType.subtitle => [
              '    <h2 id="${anchor(part)}">${esc(part.subtitle)}</h2>'
            ],
          PartType.summary => [
              '    <nav aria-label="Sommaire"><ol>',
              for (var section in sections)
                '      <li><a href="${esc(Uri.encodeFull(route.substring(1)))}#${anchor(section)}">${esc(section.subtitle)}</a></li>',
              "    </ol></nav>",
            ],
          PartType.normalParagprah ||
          PartType.paragraphWithLeftImage ||
          PartType.paragraphWithRightImage =>
            [
              ..._paragraphs(part.text),
              if (part.imagePath?.isNotEmpty ?? false)
                _figure(part.imagePath!, part.legend),
            ],
          PartType.onlyImage => [_figure(part.imagePath!, part.legend)],
          PartType.gallery => [
              for (var image in part.gallery!) _figure(image, part.legend)
            ],
          PartType.citation => [
              "    <blockquote>",
              ..._paragraphs(part.text),
              "    </blockquote>",
            ],
          PartType.quote => [
              "    <blockquote>",
              ..._paragraphs(part.text),
              if (part.legend?.isNotEmpty ?? false)
                "      <footer>${esc(part.legend!)}</footer>",
              "    </blockquote>",
            ],
          PartType.navigation || PartType.space => <String>[],
        },
      "    </article>",
      '    <nav aria-label="Articles">',
      if (item.rank > 0)
        "      <p>Article précédent : ${_link(AppRoutes.getFocusItemRouteByRank(item.rank - 1), focusData[item.rank - 1].title)}</p>",
      if (item.rank < focusData.length - 1)
        "      <p>Article suivant : ${_link(AppRoutes.getFocusItemRouteByRank(item.rank + 1), focusData[item.rank + 1].title)}</p>",
      "    </nav>",
    ];
    final description = _description(item);
    return StaticPage(
        route: route,
        title: item.title,
        description: description,
        image: images.isEmpty ? null : images.first,
        body: html.join("\n"),
        jsonLd: {
          "@context": "https://schema.org",
          "@type": "Article",
          "headline": item.title,
          "description": description,
          "inLanguage": "fr",
          "url": url(route),
          if (images.isNotEmpty)
            "image": siteUrl + assetUrl(ImagePreviews.pathOf(images.first)),
          if (item.author != null)
            "author": [
              for (var author in item.author!)
                {
                  "@type": "Person",
                  "name": "${author.firstName} ${author.familyName}"
                }
            ],
          "publisher": {"@type": "Organization", "name": publisher},
          "isPartOf": {"@type": "WebSite", "name": siteName, "url": siteUrl},
        });
  }

  StaticPage _sequence() => StaticPage(
      route: AppRoutes.SEQUENCE_ROUTE,
      title: "Les étapes du voyage",
      description:
          "Les étapes du voyage de Mme Cradock en Touraine en septembre 1785 sur la carte de l'état-major, avec les passages de son journal.",
      body: [
        _nav(),
        "    <h1>Les étapes du voyage</h1>",
        "    <p>La carte interactive suit l'itinéraire de Mme Cradock sur la carte de l'état-major. Voici, étape par étape, ce qu'elle en écrit dans son journal.</p>",
        for (var step in StepData.steps) ...[
          "    <h2>${esc(step.name)}</h2>",
          for (var passage in CradockTextData.passagesOf(step.id)) ...[
            "    <blockquote>",
            ..._paragraphs(
                "${passage.date[0].toUpperCase()}${passage.date.substring(1)}.\n${passage.plainText}"),
            "      <footer>Journal de Mme Cradock, ${esc(passage.pages)}</footer>",
            "    </blockquote>",
          ],
        ],
      ].join("\n"));

  StaticPage _authorList() => StaticPage(
      route: AppRoutes.AUTHORS_ROUTE,
      title: "Auteurs",
      description:
          "Les membres de la Société archéologique de Touraine qui ont présenté le voyage de Mme Cradock.",
      body: [
        _nav(),
        "    <h1>Auteurs</h1>",
        "    <ul>",
        for (var author in authors)
          "      <li>${_link(AppRoutes.getAuthorItemRoute(author), author.normalizedName)}</li>",
        "    </ul>",
      ].join("\n"));

  StaticPage _author(Author author) {
    final articles = [
      for (var item in focusData)
        if (item.author?.contains(author) ?? false) item
    ];
    return StaticPage(
        route: AppRoutes.getAuthorItemRoute(author),
        title: "${author.firstName} ${author.familyName}",
        description:
            "Articles de ${author.firstName} ${author.familyName} sur le voyage de Mme Cradock en Touraine.",
        body: [
          _nav(),
          "    <h1>${esc(author.normalizedName)}</h1>",
          if (author.biography?.isNotEmpty ?? false)
            ..._paragraphs(author.biography!),
          if (articles.isNotEmpty) ...[
            "    <h2>Articles</h2>",
            "    <ul>",
            for (var item in articles)
              "      <li>${_link(AppRoutes.getFocusItemRoute(item), item.title)}</li>",
            "    </ul>",
          ],
        ].join("\n"));
  }

  StaticPage _references() => StaticPage(
      route: AppRoutes.REFERENCES_ROUTE,
      title: ReferenceData.title,
      description:
          "Textes, archives, illustrations et données cités dans les articles et la carte du voyage de Mme Cradock en Touraine.",
      body: [
        _nav(),
        "    <h1>${esc(ReferenceData.title)}</h1>",
        "    <p>${esc(ReferenceData.introduction)}</p>",
        for (var section in ReferenceData.sections) ...[
          "    <h2>${esc(section.title)}</h2>",
          if (section.introduction != null)
            "    <p>${esc(section.introduction!)}</p>",
          "    <ul>",
          for (var reference in section.references)
            "      <li>${[
              esc(reference.text),
              if (reference.url != null)
                '<a href="${esc(reference.url!)}">${esc(reference.url!)}</a>',
              if (reference.usedIn != null)
                esc("Utilisé dans ${reference.usedIn}."),
              if (reference.articles.isNotEmpty)
                "Cité dans : ${_join([
                      for (var item in reference.articles)
                        _link(AppRoutes.getFocusItemRoute(item), item.title)
                    ])}.",
            ].join(" ")}</li>",
          "    </ul>",
        ],
      ].join("\n"));

  StaticPage _legal() => StaticPage(
      route: AppRoutes.LEGAL_ROUTE,
      title: LegalData.title,
      description:
          "Éditeur, hébergement, données personnelles et crédits du site.",
      body: [
        _nav(),
        "    <h1>${esc(LegalData.title)}</h1>",
        for (var (heading, paragraphs) in LegalData.sections) ...[
          "    <h2>${esc(heading)}</h2>",
          for (var paragraph in paragraphs) "    <p>${esc(paragraph)}</p>",
        ],
      ].join("\n"));

  // Helpers.

  static List<String> _paragraphs(String text) => [
        for (var line in text.split("\n"))
          if (line.trim().isNotEmpty) "      <p>${esc(line.trim())}</p>"
      ];

  String _figure(String asset, String? legend) {
    final preview = ImagePreviews.all[asset];
    final alt = legend?.isNotEmpty ?? false ? legend! : "Illustration";
    return [
      "    <figure>",
      '      <img src="${esc(assetUrl(preview?.path ?? asset))}" alt="${esc(alt)}"'
          '${preview == null ? "" : ' width="${preview.width}" height="${preview.height}"'} loading="lazy">',
      if (legend?.isNotEmpty ?? false)
        "      <figcaption>${esc(legend!)}</figcaption>",
      "    </figure>",
    ].join("\n");
  }

  /// First text of the article, cut to about 160 characters.
  static String _description(FocusItem item) {
    final text = item.parts
        .where((part) => part.text.trim().isNotEmpty)
        .map((part) => part.text.replaceAll(RegExp(r"\s+"), " ").trim())
        .firstWhere((_) => true, orElse: () => item.title);
    if (text.length <= 160) return text;
    final cut = text.lastIndexOf(" ", 157);
    final start = text.substring(0, cut > 80 ? cut : 157);
    return start.endsWith(".") ? start : "$start…";
  }
}
