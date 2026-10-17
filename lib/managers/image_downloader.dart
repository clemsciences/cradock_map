import "image_downloader_stub.dart"
    if (dart.library.js_interop) "image_downloader_web.dart" as impl;

class ImageDownloader {
  /// Downloads/saves the asset and returns a message for the user, or null
  /// when the platform gives its own feedback (browser download, share sheet).
  static Future<String?> downloadAsset(String assetPath) {
    return impl.downloadAsset(assetPath);
  }
}
