import "dart:js_interop";
import "dart:typed_data";

import "package:cradock_map/managers/opener.dart";
import "package:web/web.dart" as web;

class MyOpener implements Opener {
  /// Downloads the PNG: `window.open` after an `await` is usually blocked by
  /// pop-up blockers.
  @override
  Future<String?> openImage(Uint8List imageBytes) async {
    final blob = web.Blob(<web.BlobPart>[imageBytes.toJS].toJS,
        web.BlobPropertyBag(type: "image/png"));
    final url = web.URL.createObjectURL(blob);
    final anchor = web.document.createElement("a") as web.HTMLAnchorElement;
    anchor.href = url;
    anchor.download = Opener.mapFileName;
    anchor.click();
    web.URL.revokeObjectURL(url);
    return null;
  }
}
