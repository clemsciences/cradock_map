import "dart:typed_data";

abstract class Opener {
  static const String mapFileName = "carte-cradock.png";

  /// Hands the PNG over to the user and returns a message to show, if any.
  Future<String?> openImage(Uint8List imageBytes);
}
