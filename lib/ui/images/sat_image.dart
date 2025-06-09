import "dart:async";
import "dart:math";
import "dart:ui" as ui;

import "package:cradock_map/style/style.dart";
import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";

class SatImage extends StatelessWidget {
  const SatImage(
      {super.key,
      required this.assetName,
      this.maxWidth,
      this.maxHeight,
      this.widthRatio,
      this.heightRatio,
      this.legend,
      this.padding = const EdgeInsets.all(16)});

  final String assetName;
  final double? maxWidth;
  final double? maxHeight;
  final double? widthRatio;
  final double? heightRatio;
  final String? legend;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
          // height: 600,
          // width: 600,
          padding: padding,
          child: assetName.isNotEmpty ? PhotoView(
            onTapUp: (context, _1, _2) => _open(context),
            // disableGestures: true,
            imageProvider: AssetImage(assetName),
          ) : Container(
            // height: 600,
            // width: 600,
            padding: padding,
            child: Text("Impossible de charger l'image"),
          ),),
    );
  }

  void _open(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(),
            body: PhotoView(
              imageProvider: AssetImage(assetName),
            ),
          );
        },
      ),
    );
  }
}

//
// class SatImage extends StatefulWidget {
//   const SatImage(
//       {super.key,
//       required this.assetName,
//       this.maxWidth,
//       this.maxHeight,
//       this.widthRatio,
//       this.heightRatio,
//       this.legend});
//
//   final String assetName;
//   final double? maxWidth;
//   final double? maxHeight;
//   final double? widthRatio;
//   final double? heightRatio;
//   final String? legend;
//
//   @override
//   State<SatImage> createState() => _SatImageState();
// }
//
// class _SatImageState extends State<SatImage> {
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//
//         var maximumWidth = constraints.maxWidth;
//         var maximumHeight = constraints.maxHeight;
//         if (widget.widthRatio != null) {
//           maximumWidth *= widget.widthRatio!;
//         }
//         if (widget.heightRatio != null) {
//           maximumHeight *= widget.heightRatio!;
//         }
//         // Taille ajustée en gardant le ratio de l'image
//         double width = maximumWidth;
//         double height = width / _imageRatio!;
//
//         if (height > maximumHeight) {
//           height = maximumHeight;
//           width = height * _imageRatio!;
//         }
//         return PhotoView(
//           imageProvider: AssetImage(widget.assetName),
//
//         );
//       }
//     );
//   }
// }

//
class MySatImage extends StatefulWidget {
  const MySatImage(
      {super.key,
      required this.assetName,
      this.maxWidth,
      this.maxHeight,
      this.widthRatio,
      this.heightRatio,
      required this.legend,
      this.padding = const EdgeInsets.all(16)});

  final String assetName;
  final double? maxWidth;
  final double? maxHeight;
  final double? widthRatio;
  final double? heightRatio;
  final String legend;
  final EdgeInsets padding;

  @override
  State<MySatImage> createState() => _MySatImageState();
}

class _MySatImageState extends State<MySatImage> {
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
              child: Container(
                width: min(width, 600),
                height: min(height, 600),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black, // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                  child: widget.assetName.isNotEmpty ? Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
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
                    if(widget.legend.isNotEmpty)
                    Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  color: SatStyle.lightBlueColor.withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: SelectableText(widget.legend,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelMedium
                                        ?.copyWith(color: Colors.white))))
                      // Align(
                      //   alignment: Alignment.bottomCenter,
                      //   child: SelectableText(
                      //       widget.legend,
                      //       style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Colors.white)
                      //   ),
                      // )
                    ],
                  ): Text("Impossible de charger l'image"),
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
