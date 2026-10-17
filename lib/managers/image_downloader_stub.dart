import "package:cradock_map/managers/image_saver.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";

Future<String?> downloadAsset(String assetPath) async {
  try {
    // assetPath already starts with "assets/" (it is the key used by Image.asset).
    final ByteData data = await rootBundle.load(assetPath);
    return await ImageSaver.save(
        data.buffer.asUint8List(), assetPath.split("/").last);
  } catch (e) {
    debugPrint("Erreur lors du téléchargement de l'image : $e");
    return "Impossible de télécharger l'image.";
  }
}
