import "package:cradock_map/ui/images/image_viewer_page.dart";
import "package:cradock_map/ui/images/progressive_asset_image.dart";
import "package:flutter/material.dart";

/// Image shown in a gallery. Zooming happens in the full-screen viewer: a
/// PhotoView here would capture vertical drags and block the page scroll on
/// touch screens.
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
    return Container(
      padding: padding,
      child: assetName.isNotEmpty
          ? Semantics(
              button: true,
              hint: "Afficher en plein écran",
              child: InkWell(
                onTap: () => ImageViewerPage.open(context, assetName),
                child: ProgressiveAssetImage(
                    assetName: assetName,
                    semanticLabel:
                        legend?.isNotEmpty ?? false ? legend : "Illustration"),
              ),
            )
          : const Text("Impossible de charger l'image"),
    );
  }
}
