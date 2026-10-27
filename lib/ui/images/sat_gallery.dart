import "package:cradock_map/ui/images/sat_image.dart";
import "package:flutter/material.dart";

class SatGallery extends StatefulWidget {
  final List<String> assetNames;
  final int initialIndex;
  final String? legend;

  const SatGallery({
    super.key,
    required this.assetNames,
    this.legend,
    this.initialIndex = 0,
  });

  @override
  State<SatGallery> createState() => _SatGalleryState();
}

class _SatGalleryState extends State<SatGallery> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.assetNames.isEmpty) {
      return const Center(child: Text("Aucune image à afficher"));
    }

    // Utiliser LayoutBuilder pour obtenir les contraintes de taille du parent
    // et s'assurer que le PageView et les SatImage s'adaptent correctement.
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          // width: min(constraints.maxWidth, 500),
          // height: min(constraints.maxHeight, 500),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            // alignment: Alignment.center,
            children: <Widget>[
              if (_currentIndex > 0)
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    tooltip: "Image précédente",
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                )
              else
                const SizedBox(width: 40), // Garde l'image centrée
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.assetNames.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final count = widget.assetNames.length;
                    return SatImage(
                        assetName: widget.assetNames[index],
                        legend: [
                          if (widget.legend?.isNotEmpty ?? false) widget.legend,
                          if (count > 1) "image ${index + 1} sur $count",
                        ].join(", "));
                  },
                ),
              ),
              if (_currentIndex < widget.assetNames.length - 1)
                SizedBox(
                  width: 40,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    tooltip: "Image suivante",
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                )
              else
                const SizedBox(
                    width: 40), // Placeholder pour maintenir l'alignement
            ],
          ),
        );
      },
    );
  }
}
