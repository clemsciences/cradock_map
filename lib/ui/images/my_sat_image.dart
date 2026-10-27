import "dart:math";

import "package:cradock_map/data/image_previews.dart";
import "package:cradock_map/ui/images/image_viewer_page.dart";
import "package:cradock_map/ui/images/progressive_asset_image.dart";
import "package:cradock_map/style/style.dart";
import "package:flutter/material.dart";

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
  static const double maxDisplaySize = 600;

  double? imageRatio; // width/height

  bool hasError = false;

  @override
  void initState() {
    super.initState();
    if (widget.assetName.isEmpty) {
      hasError = true;
      return;
    }
    // Known in advance for the images that have a preview: the frame is laid
    // out immediately, without waiting for the image.
    imageRatio = ImagePreviews.aspectRatioOf(widget.assetName);
    if (imageRatio == null) {
      _loadImageRatio(widget.assetName);
    }
  }

  void _loadImageRatio(String assetPath) {
    AssetImage(assetPath).resolve(ImageConfiguration.empty).addListener(
          ImageStreamListener((ImageInfo info, bool _) {
            if (!mounted) return;
            setState(() {
              imageRatio = info.image.width / info.image.height;
            });
          }, onError: (exception, stackTrace) {
            debugPrint("Error loading image: $exception");
            if (!mounted) return;
            // Sans cela, le spinner tournerait indéfiniment.
            setState(() {
              hasError = true;
            });
          }),
        );
  }

  @override
  Widget build(BuildContext context) {
    if (hasError) {
      return const Text("Impossible de charger l'image");
    }
    return imageRatio == null
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
            // Bounded first: inside a Row the available width is infinite.
            maximumWidth = min(maximumWidth, maxDisplaySize);
            maximumHeight = min(maximumHeight, maxDisplaySize);
            // Taille ajustée en gardant le ratio de l'image
            double width = maximumWidth;
            double height = width / imageRatio!;

            if (height > maximumHeight) {
              height = maximumHeight;
              width = height * imageRatio!;
            }
            return MouseRegion(
              cursor: SystemMouseCursors.click,
              child: SizedBox(
                width: width,
                height: height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(
                      color: Colors.black, // Couleur de la bordure
                      width: 1.0, // Épaisseur de la bordure
                    ),
                  ),
                  child: widget.assetName.isNotEmpty
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Semantics(
                                button: true,
                                hint: "Afficher en plein écran",
                                child: InkWell(
                                  onTap: _open,
                                  child: ProgressiveAssetImage(
                                    assetName: widget.assetName,
                                    width: width,
                                    height: height,
                                    semanticLabel: widget.legend.isEmpty
                                        ? "Illustration"
                                        : widget.legend,
                                  ),
                                ),
                              ),
                            ),
                            if (widget.legend.isNotEmpty)
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                      margin: EdgeInsets.all(16),
                                      padding: EdgeInsets.all(8.0),
                                      // Dark enough for white text (WCAG AA).
                                      decoration: BoxDecoration(
                                        color: SatStyle.darkBlueColor
                                            .withValues(alpha: 0.92),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: ExcludeSemantics(
                                          child: SelectableText(widget.legend,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelLarge
                                                  ?.copyWith(
                                                      color: Colors.white)))))
                          ],
                        )
                      : Text("Impossible de charger l'image"),
                ),
              ),
            );
          });
  }

  void _open() => ImageViewerPage.open(context, widget.assetName);
}
