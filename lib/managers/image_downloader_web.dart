import "package:web/web.dart" as web;

Future<String?> downloadAsset(String assetPath) async {
  final anchor = web.document.createElement("a") as web.HTMLAnchorElement;
  // Flutter web serves the declared assets under an extra "assets/" folder.
  anchor.href = "assets/$assetPath";
  anchor.download = assetPath.split("/").last;
  anchor.click();
  return null;
}
