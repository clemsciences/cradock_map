import "url_opener_stub.dart" if (dart.library.js_interop) "url_opener_web.dart"
    as impl;

class UrlOpener {
  /// Whether [open] works on this platform (otherwise the URL is only shown).
  static bool get canOpen => impl.canOpen;

  /// Opens [url] in a new tab.
  static void open(String url) => impl.open(url);
}
