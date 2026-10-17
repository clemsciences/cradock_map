import "dart:typed_data";

import "package:cradock_map/managers/image_saver.dart";
import "package:cradock_map/managers/opener.dart";

class MyOpener implements Opener {
  @override
  Future<String?> openImage(Uint8List imageBytes) {
    return ImageSaver.save(imageBytes, Opener.mapFileName);
  }
}
