
import "dart:typed_data";
import "dart:ui";

import "package:cradock_map/managers/opener.dart";
import "package:flutter/material.dart";
import "package:flutter/rendering.dart";

class PrintMapButton extends StatelessWidget {
  final GlobalKey mapKey;
  final Opener opener;

  const PrintMapButton({super.key, required this.mapKey, required this.opener});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        icon: const Icon(Icons.image_outlined),
        onPressed: () async {
          final messenger = ScaffoldMessenger.of(context);
          var i = await captureMapAsImage();
          final message = i == null
              ? "Impossible de capturer la carte."
              : await opener.openImage(i);
          if (message != null) {
            messenger.showSnackBar(SnackBar(content: Text(message)));
          }
        },
        label: const Text("Enregistrer la carte (PNG)"));
  }

  Future<Uint8List?> captureMapAsImage() async {
    RenderRepaintBoundary? boundary =
        mapKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }
}

