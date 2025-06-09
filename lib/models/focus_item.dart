import "package:cradock_map/models/author.dart";
import "package:flutter/material.dart";

enum PartType {
  normalParagprah,
  paragraphWithLeftImage,
  paragraphWithRightImage,
  onlyImage,
  citation,
  gallery,
  navigation,
  summary,
  subtitle
}

class FocusItemPart {
  final String text;
  final String subtitle;
  final String? imagePath;
  final String? legend;
  final String? videoUrl;
  final List<String>? gallery;
  final PartType type;
  final List<GlobalKey>? partKeys;
  final GlobalKey key;

  FocusItemPart(
      {required this.text,
      required this.type,
      this.subtitle = "",
      this.imagePath,
      this.legend,
      this.videoUrl,
      this.gallery,
      this.partKeys,
      required this.key});

  factory FocusItemPart.normalParagraph({String? text}) {
    return FocusItemPart(
        text: text ?? "", type: PartType.normalParagprah, key: GlobalKey());
  }

  factory FocusItemPart.navigation() {
    return FocusItemPart(text: "", type: PartType.navigation, key: GlobalKey());
  }

  factory FocusItemPart.summary(List<GlobalKey> partKeys) {
    return FocusItemPart(
        text: "", partKeys: partKeys, type: PartType.summary, key: GlobalKey());
  }

  factory FocusItemPart.subtitle(String subtitle) {
    return FocusItemPart(
        text: "",
        subtitle: subtitle,
        type: PartType.subtitle,
        key: GlobalKey());
  }

  factory FocusItemPart.image({required String imagePath, String? legend}) {
    return FocusItemPart(
        text: "",
        legend: legend,
        type: PartType.onlyImage,
        imagePath: imagePath,
        key: GlobalKey());
  }

  factory FocusItemPart.citation(String citation) {
    return FocusItemPart(
        text: citation, type: PartType.citation, key: GlobalKey());
  }

  factory FocusItemPart.gallery(List<String> gallery, String legend) {
    return FocusItemPart(
        text: "",
        type: PartType.gallery,
        gallery: gallery,
        legend: legend,
        key: GlobalKey());
  }

  factory FocusItemPart.paragraphWithLeftImage(
      {required String text,
      required String imagePath,
      required String legend}) {
    return FocusItemPart(
        text: text,
        type: PartType.paragraphWithLeftImage,
        imagePath: imagePath,
        legend: legend,
        key: GlobalKey());
  }

  factory FocusItemPart.paragraphWithRightImage(
      {required String text,
      required String imagePath,
      required String legend}) {
    return FocusItemPart(
        text: text,
        type: PartType.paragraphWithLeftImage,
        imagePath: imagePath,
        legend: legend,
        key: GlobalKey());
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
