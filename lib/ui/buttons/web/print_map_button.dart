

import 'package:flutter/foundation.dart' show kIsWeb;


import 'dart:typed_data';
import 'dart:ui';


import 'package:web/web.dart' as web;
import "dart:js_interop" as js;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PrintMapButton extends StatelessWidget {
  final GlobalKey mapKey;

  const PrintMapButton({super.key, required this.mapKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          var i = await captureMapAsImage();
          if (i != null) {
            if(kIsWeb) {
              openImageInNewTab(i);
            } else {

            }
          }
        },
        child: const Text("Imprimer"));
  }

  Future<Uint8List?> captureMapAsImage() async {
    RenderRepaintBoundary? boundary =
        mapKey.currentContext?.findRenderObject() as RenderRepaintBoundary?;
    if (boundary == null) return null;

    final image = await boundary.toImage(pixelRatio: 3.0);
    final byteData = await image.toByteData(format: ImageByteFormat.png);
    return byteData?.buffer.asUint8List();
  }

  void openImageInNewTab(Uint8List imageBytes) {
    final blob = web.Blob([imageBytes] as js.JSArray<web.BlobPart>,
        web.BlobPropertyBag(type: "image/png"));
    final url = web.URL.createObjectURL(blob);
    web.window.open(url, '_blank');
  }

// void openImageWithAutoPrint(Uint8List imageBytes) {
//   final base64 = base64Encode(imageBytes);
//   final htmlContent = '''
//   <html>
//     <body onload="window.print()">
//       <img src="data:image/png;base64,$base64" style="width:100%;"/>
//     </body>
//   </html>
// ''';
//
//   final blob = html.Blob([htmlContent], 'text/html');
//   final url = html.Url.createObjectUrlFromBlob(blob);
//   html.window.open(url, '_blank');
// }
}
