import "package:cradock_map/data/image_previews.dart";
import "package:flutter/material.dart";

/// Displays the light preview of [assetName] (see tool/make_previews.py): a
/// placeholder with a spinner is shown in its place until it is decoded. The
/// surrounding layout does not wait for it.
class ProgressiveAssetImage extends StatelessWidget {
  const ProgressiveAssetImage({
    super.key,
    required this.assetName,
    this.fit = BoxFit.contain,
    this.width,
    this.height,
  });

  final String assetName;
  final BoxFit fit;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final placeholderColor =
        Theme.of(context).colorScheme.surfaceContainerHighest;
    return Image.asset(
      ImagePreviews.pathOf(assetName),
      fit: fit,
      width: width,
      height: height,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null || wasSynchronouslyLoaded) return child;
        // Not decoded yet: the placeholder takes the image's place (the image
        // widget keeps the size, so nothing moves when it appears).
        return Stack(
          fit: StackFit.passthrough,
          children: [
            child,
            Positioned.fill(
              child: ColoredBox(
                color: placeholderColor,
                child: const Center(
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
      errorBuilder: (context, error, stackTrace) =>
          const Center(child: Text("Impossible de charger l'image")),
    );
  }
}
