import "dart:async";
import "dart:math";
import "dart:ui" as ui;

import "package:flutter/material.dart";

class SatImage extends StatefulWidget {
  const SatImage(
      {super.key,
      required this.assetName,
      this.maxWidth,
      this.maxHeight,
      this.widthRatio,
      this.heightRatio,
      this.legend});

  final String assetName;
  final double? maxWidth;
  final double? maxHeight;
  final double? widthRatio;
  final double? heightRatio;
  final String? legend;

  @override
  State<SatImage> createState() => _SatImageState();
}

class _SatImageState extends State<SatImage> {
  var _imageRatio; // width/height

  @override
  void initState() {
    super.initState();
    _loadImageRatio(widget.assetName);
  }

  Future<void> _loadImageRatio(String assetPath) async {
    final image = AssetImage(assetPath);
    final config = ImageConfiguration();
    final completer = Completer<ui.Image>();

    image.resolve(config).addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            final width = info.image.width.toDouble();
            final height = info.image.height.toDouble();
            completer.complete(info.image);
            setState(() {
              _imageRatio = width / height;
            });
          }, onError: (exception, stackTrace) {
            print('Error loading image: $exception');
            completer.completeError(exception);
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return _imageRatio == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : LayoutBuilder(builder: (context, constraints) {
            var maximumWidth = constraints.maxWidth;
            var maximumHeight = constraints.maxHeight;
            if (widget.widthRatio != null) {
              maximumWidth *= widget.widthRatio!;
            }
            if (widget.heightRatio != null) {
              maximumHeight *= widget.heightRatio!;
            }
            // Taille ajustée en gardant le ratio de l'image
            double width = maximumWidth;
            double height = width / _imageRatio!;

            if (height > maximumHeight) {
              height = maximumHeight;
              width = height * _imageRatio!;
            }
            // print("height: $height width: $width");
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, // Couleur de la bordure
                    width: 1.0, // Épaisseur de la bordure
                  ),
                ),
                child: InkWell(
                  onTap: _open,
                  child: Image.asset(
                    widget.assetName,
                    fit: BoxFit.contain,

                    width: min(width, 600),
                    height: min(height, 600),
                  ),
                ),
              ),
            );
          });
  }

  void _open() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: Image.asset(widget.assetName),
            ),
          );
        },
      ),
    );
  }
}
