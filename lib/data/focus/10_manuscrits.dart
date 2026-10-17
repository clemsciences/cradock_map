import "package:cradock_map/data/authors.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/10-manuscrits";

// TODO commentaire de Florence Cailleau sur le Pentateuque et l'Évangéliaire.
var manuscrits = FocusItem(
    title: "Le Pentateuque et l’Évangéliaire",
    routeId: "pentateuque-evangeliaire",
    rank: 9,
    author: [
      florenceCailleau
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.quote(
          "Dans la bibliothèque [de l’archevêché], il existe deux manuscrits fort curieux : l’un, le Pentateuque, écrit entièrement en petites lettres majuscules ; l’autre, les Quatre Évangiles, transcrits en lettres saxonnes.",
          source: "Journal de Mme Cradock, jeudi 15 septembre 1785, p. 284"),
      FocusItemPart.subtitle("Le Pentateuque de Tours"),
      FocusItemPart.gallery([
        "$_folder/pentateuque-1.jpeg",
        "$_folder/pentateuque-2.jpeg",
        "$_folder/pentateuque-3.jpeg",
      ], "Le Pentateuque de Tours"),
      FocusItemPart.subtitle("L’Évangéliaire dit de Charlemagne"),
      FocusItemPart.gallery([
        "$_folder/evangeliaire-1.png",
        "$_folder/evangeliaire-2.png",
      ], "Évangéliaire dit de Charlemagne. Bibliothèque municipale de Tours"),
      FocusItemPart.navigation(),
    ]);
