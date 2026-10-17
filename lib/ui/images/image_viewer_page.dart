import "package:cradock_map/data/image_previews.dart";
import "package:cradock_map/managers/image_downloader.dart";
import "package:flutter/material.dart";
import "package:photo_view/photo_view.dart";

/// Full-screen image with pinch / wheel zoom and a download button.
class ImageViewerPage extends StatelessWidget {
  const ImageViewerPage({super.key, required this.assetName});

  final String assetName;

  static void open(BuildContext context, String assetName) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => ImageViewerPage(assetName: assetName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.download),
            tooltip: "Télécharger l'image",
            onPressed: () async {
              final message = await ImageDownloader.downloadAsset(assetName);
              if (message != null && context.mounted) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(message)));
              }
            },
          ),
        ],
      ),
      body: PhotoView(
        imageProvider: AssetImage(assetName),
        minScale: PhotoViewComputedScale.contained,
        // The full-resolution original can take a while: the light preview
        // is shown meanwhile.
        loadingBuilder: (context, event) => Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: Image.asset(ImagePreviews.pathOf(assetName),
                  fit: BoxFit.contain),
            ),
            const CircularProgressIndicator(),
          ],
        ),
        backgroundDecoration:
            BoxDecoration(color: Theme.of(context).colorScheme.surface),
      ),
    );
  }
}
