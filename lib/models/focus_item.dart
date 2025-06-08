import "package:cradock_map/models/author.dart";

enum PartType {
  normalParagprah,
  paragraphWithLeftImage,
  paragraphWithRightImage,
  onlyImage,
  citation,
  gallery,
  navigation
}

class FocusItemPart {
  final String text;
  final String? subtitle;
  final String? imagePath;
  final String? legend;
  final String? videoUrl;
  final List<String>? gallery;
  final PartType type;

  FocusItemPart(
      {required this.text,
      required this.type,
      this.subtitle,
      this.imagePath,
      this.legend,
      this.videoUrl,
      this.gallery});

  factory FocusItemPart.normalParagraph(String text) {
    return FocusItemPart(
        text: text, type: PartType.normalParagprah);
  }

  factory FocusItemPart.navigation() {
    return FocusItemPart(
        text: "", type: PartType.navigation);
  }

  factory FocusItemPart.image({required String imagePath, String? legend, String? subtitle}) {
    return FocusItemPart(
        text: "",
        legend: legend,
        subtitle: subtitle,
        type: PartType.onlyImage,
        imagePath: imagePath);
  }

  factory FocusItemPart.citation(String citation) {
    return FocusItemPart(
        text: citation, type: PartType.citation);
  }

  factory FocusItemPart.gallery(List<String> gallery, String legend) {
    return FocusItemPart(
        text: "", type: PartType.gallery, gallery: gallery, legend: legend);
  }

  factory FocusItemPart.paragraphWithLeftImage(
      {required String text,
      required String imagePath,
      required String legend,
      required String subtitle}) {
    return FocusItemPart(
        text: text,
        subtitle: subtitle,
        type: PartType.paragraphWithLeftImage,
        imagePath: imagePath,
        legend: legend);
  }

  factory FocusItemPart.paragraphWithRightImage(
      {required String text,
        required String imagePath,
        required String legend,
        required String subtitle}) {
    return FocusItemPart(
        text: text,
        subtitle: subtitle,
        type: PartType.paragraphWithLeftImage,
        imagePath: imagePath,
        legend: legend);
  }
}


class FocusItem {
  final int rank;
  final String title;
  final String routeId;
  final List<FocusItemPart> parts;
  final List<Author>? author;

  FocusItem(
      {required this.title,
      required this.routeId,
      required this.parts,
      required this.rank,
      required this.author});
}
