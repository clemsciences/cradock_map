// Writes the static HTML pages into the web build (see static_pages.dart).
//
//   flutter build web --base-href "/cradock_map/"
//   flutter test tool/generate_static_pages.dart
//
// It runs through `flutter test` because the content of the site is Dart data
// that imports Flutter. OUT (default build/web) and SITE_URL can be set in the
// environment.

import "dart:io";

import "package:flutter_test/flutter_test.dart";

import "static_pages.dart";

void main() {
  test("Generate the static pages", () {
    final out = Directory(Platform.environment["OUT"] ?? "build/web");
    final template = File("${out.path}/index.html");
    if (!template.existsSync()) {
      fail("${template.path} not found: run flutter build web first");
    }
    final site = StaticSite(
        template: template.readAsStringSync(),
        siteUrl: Platform.environment["SITE_URL"] ??
            "https://clemsciences.github.io/cradock_map/");
    site.writeTo(out);
    // ignore: avoid_print
    print("${site.pages.length} pages written in ${out.path}");
  });
}
