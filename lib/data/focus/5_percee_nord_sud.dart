import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/5-pont-neuf";

// TODO commentaire d'Alain Pauquet : « Le pont, la rue Neuve et son
// prolongement » (texte en attente dans « Textes pour mise en ligne »).
var perceeNordSud = FocusItem(
    title: "Le pont et la rue Neuve",
    routeId: "pont-rue-neuve",
    rank: 4,
    author: [
      alainPauquet
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("L’entrée dans Tours"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-entree-de-tours.png",
          legend: "Entrée dans la ville de Tours : le pont"),
      FocusItemPart.journal(CradockTextData.passagesOf(3)),
      FocusItemPart.image(
          imagePath: "$_folder/pont-route-de-saumure.jpg",
          legend:
              "Vue du pont, prise de la grande route de Saumur, de l’aval. Lithographie, Dagnan, 1832 ? Collection SAT"),
      FocusItemPart.normalParagraph(
          text: "Un an plus tôt, un autre voyageur décrit le même ensemble :"),
      FocusItemPart.quote(SoreauTextData.bridgeAndStreet,
          source: SoreauTextData.sourceAt("p. 127-128")),
      FocusItemPart.subtitle("L’axe nord-sud"),
      FocusItemPart.image(
          imagePath: "$_folder/pont-nord-sud.jpg",
          legend:
              "Axe nord-sud. Gravure Deroy, début du XIXe s. Cliché Arsicaud"),
      FocusItemPart.image(
          imagePath: "$_folder/pont-neuf-amont.jpg",
          legend:
              "Traversée de la Loire. Vue du pont neuf, prise de l’amont. Dessin Thomas Pringot, 1781. Collection SAT"),
      FocusItemPart.image(
          imagePath: "$_folder/lithographie-pont.jpg",
          legend: "Le pont, vu d’aval. Lithographie, XIXe s. Collection SAT"),
      FocusItemPart.subtitle("Le plan de 1756"),
      FocusItemPart.paragraphWithRightImage(
          imagePath: "$_folder/projet-pont-neuf-route-d-espagne.jpg",
          legend:
              "Le pont neuf et la route d’Espagne traversant Tours. Plan de 1756, ingénieur Bayeux. Bibliothèque municipale de Tours, Ms. 1200/29",
          text:
              "Le plan dressé en 1756 par l’ingénieur Bayeux trace, du nord au sud, la route d’Espagne qui traverse Tours : la tranchée au nord de la Loire, le pont neuf avec ses places et ses plantations sur les quais, puis la rue Neuve (future rue Royale) jusqu’aux mails."),
      FocusItemPart.gallery([
        "$_folder/plan-1756-nord-loire.jpg",
        "$_folder/plan-1756-quais.jpg",
        "$_folder/plan-1756-rue-neuve.jpg",
      ], "Plan de 1756 : la tranchée au nord de la Loire ; le pont neuf et le projet de places et plantations sur les quais ; la rue Neuve (Royale) jusqu’aux mails"),
      FocusItemPart.image(
          imagePath: "$_folder/projet-rue-neuve-facade.jpg",
          legend: "Rue Neuve : projet de façades (non réalisé)"),
      FocusItemPart.navigation(),
    ]);
