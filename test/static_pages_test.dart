import "dart:io";

import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/routes/routes.dart";
import "package:flutter_test/flutter_test.dart";

import "../tool/static_pages.dart";

void main() {
  final site = StaticSite(
      template: File("web/index.html").readAsStringSync(),
      siteUrl: "https://example.org/cradock_map/");
  final files = site.files();

  test("Every article, author and the main pages have their HTML page", () {
    for (var item in focusData) {
      final page =
          files["${AppRoutes.getFocusItemRoute(item).substring(1)}.html"];
      expect(page, isNotNull, reason: item.title);
      expect(page, contains("<h1>${StaticSite.esc(item.title)}</h1>"));
      expect(
          page,
          contains(
              '<link rel="canonical" href="https://example.org/cradock_map/focus/${item.routeId}">'));
      expect(page, contains('property="og:image"'));
      expect(page, contains('type="application/ld+json"'));
    }
    for (var author in authors) {
      expect(
          files.keys,
          contains(
              "${AppRoutes.getAuthorItemRoute(author).substring(1)}.html"));
    }
    for (var name in [
      "index.html",
      "focus.html",
      "sequence.html",
      "auteurs.html",
      "references.html",
      "mentions-legales.html",
      "404.html",
      "sitemap.xml",
      "robots.txt"
    ]) {
      expect(files.keys, contains(name));
    }
  });

  test("Pages keep the app and replace only their own blocks", () {
    final page = files["focus/cathedrale.html"]!;
    expect(page, contains('<script src="flutter_bootstrap.js"'));
    expect(page, contains('<html lang="fr">'));
    expect("<title>".allMatches(page).length, 1);
    expect(page, contains("<main id=\"page-content\">"));
    // Running the generator on its own output gives the same page.
    final again = StaticSite(template: page, siteUrl: site.siteUrl)
        .files()["focus/cathedrale.html"];
    expect(again, page);
  });

  test("Every image has a text alternative and the text is escaped", () {
    for (var entry in files.entries.where((e) => e.key.endsWith(".html"))) {
      // The decorative splash logo (alt="") is outside <main>.
      final main =
          RegExp(r"<main[\s\S]*</main>").firstMatch(entry.value)?[0] ?? "";
      for (var image in RegExp(r"<img [^>]*>").allMatches(main)) {
        expect(image[0], matches(RegExp(r'alt="[^"]+"')), reason: entry.key);
      }
      expect(main, isNot(contains("<script")), reason: entry.key);
    }
  });

  test("The sitemap lists every page", () {
    final sitemap = files["sitemap.xml"]!;
    expect("<url>".allMatches(sitemap).length, site.pages.length);
    expect(
        sitemap, contains("https://example.org/cradock_map/focus/chanteloup"));
  });
}
