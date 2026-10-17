import "dart:io";

import "package:flutter/foundation.dart";
import "package:gal/gal.dart";
import "package:path_provider/path_provider.dart";
import "package:share_plus/share_plus.dart";

/// Saves image bytes on non-web platforms: in the photo gallery on mobile,
/// in the Downloads folder on desktop.
class ImageSaver {
  /// Returns a message for the user, or null when the share sheet was shown.
  static Future<String?> save(Uint8List bytes, String fileName) async {
    if (Platform.isAndroid || Platform.isIOS) {
      try {
        if (!await Gal.hasAccess()) {
          await Gal.requestAccess();
        }
        await Gal.putImageBytes(bytes, name: _withoutExtension(fileName));
        return "Image enregistrée dans la galerie.";
      } catch (e) {
        debugPrint("Erreur lors de l'enregistrement dans la galerie : $e");
        // Si l'enregistrement échoue (ex: permission refusée), on propose de partager.
        final file = File("${(await getTemporaryDirectory()).path}/$fileName");
        await file.writeAsBytes(bytes);
        await SharePlus.instance.share(ShareParams(files: [XFile(file.path)]));
        return null;
      }
    }
    final directory = await getDownloadsDirectory() ??
        await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/$fileName");
    await file.writeAsBytes(bytes);
    return "Image enregistrée : ${file.path}";
  }

  static String _withoutExtension(String fileName) {
    final dot = fileName.lastIndexOf(".");
    return dot > 0 ? fileName.substring(0, dot) : fileName;
  }
}
