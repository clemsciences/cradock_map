import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/13-marmoutier";

// TODO commentaire d'Émilie Trébuchet sur Marmoutier.
var marmoutier = FocusItem(
    title: "L’abbaye de Marmoutier",
    routeId: "marmoutier",
    rank: 12,
    author: [
      emilieTrebuchet
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("La visite de Mme Cradock"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-marmoutier.png",
          legend:
              "Marmoutier, sur la rive nord de la Loire, sur la carte d’état-major"),
      FocusItemPart.journal(CradockTextData.passagesOf(8)),
      FocusItemPart.subtitle("L’abbaye en images"),
      FocusItemPart.image(
          imagePath: "$_folder/rougeot.jpg",
          legend:
              "Abbaye de Marmoutier. Charles-Antoine Rougeot, fin du XVIIIe s. © MBA Tours"),
      FocusItemPart.quote(
          "${SoreauTextData.marmoutier} [...] ${SoreauTextData.marmoutierChurch}",
          source: SoreauTextData.sourceAt("p. 127 et 132")),
      FocusItemPart.image(
          imagePath: "$_folder/gaignieres-1699.png",
          legend: "Abbaye de Marmoutier. Dessin de Gaignières, 1699. © BnF"),
      FocusItemPart.image(
          imagePath: "$_folder/entree-pringot-1781.jpeg",
          legend:
              "« Vue de l’entrée de Marmoutier près Tours ». Dessin Thomas Pringot, 1781. Collections SAT"),
      FocusItemPart.image(
          imagePath: "$_folder/pernot-1852.jpg",
          legend: "Abbaye de Marmoutier. Pernot, 1852"),
      FocusItemPart.gallery([
        "$_folder/morillon-1802-1.JPG",
        "$_folder/morillon-1802-2.JPG",
      ], "Abbaye de Marmoutier. Esquisses de l’intérieur de l’église, 1802. Dessins aquarellés, A.D. Morillon. Collections SAT"),
      FocusItemPart.subtitle("Dom Quinquet"),
      FocusItemPart.image(
          imagePath: "$_folder/dom-quinquet.jpg",
          legend:
              "Portrait de Dom Quinquet, avant-dernier prieur de Marmoutier, 1783. Pastel, Valentin. Collections SAT"),
      FocusItemPart.navigation(),
    ]);
