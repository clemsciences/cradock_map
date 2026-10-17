import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/11-mails";

// TODO commentaires d'Alain Pauquet (le mail) et de Martine Bonnin (le mail
// évoqué par Balzac).
var mails = FocusItem(title: "Les mails", routeId: "mails", rank: 10, author: [
  alainPauquet,
  martineBonnin
], parts: [
  FocusItemPart.navigation(),
  FocusItemPart.summary([]),
  FocusItemPart.subtitle("Les mails en 1785"),
  FocusItemPart.image(
      imagePath: "$_folder/carte-mails.png",
      legend: "Les mails sur la carte d’état-major"),
  FocusItemPart.normalParagraph(
      text:
          "Les mails sont les actuels boulevards Béranger et Heurteloup, au sud de la ville."),
  FocusItemPart.journal(CradockTextData.passagesOf(6)),
  FocusItemPart.subtitle("L’aménagement des mails"),
  FocusItemPart.image(
      imagePath: "$_folder/plan-de-tours-1739.jpg",
      legend:
          "Les mails : grand mail, petit mail, porte Saint-Étienne, porte Saint-Éloi. Plan de Tours, 1739. Bibliothèque municipale de Tours, CPb 164"),
  FocusItemPart.normalParagraph(
      text:
          "Entre 1755 et 1788 est créée la place des portes de fer, future place Jean-Jaurès, entre les futurs boulevards Béranger et Heurteloup, non loin de l’emplacement de la future gare."),
  FocusItemPart.gallery([
    "$_folder/plan-prolongement-mail.jpg",
    "$_folder/plan-prolongement-mail-detail.png",
  ], "Plan du prolongement du 3e mail (est de la ville) jusqu’à la Madeleine en bord de Loire, avec le bastion maçonné de l’angle sud-est de la muraille d’Henri IV et l’hospice de la Madeleine. AD 37, C 294"),
  FocusItemPart.image(
      imagePath: "$_folder/passage-rue-neuve-pringot.jpeg",
      legend:
          "Passage de la rue Neuve (Royale), entre les deux mails : tourniquets d’entrée du petit et du grand mail, angle de la manufacture Papion, Saint-Martin au loin. Dessin de Thomas Pringot, 1781. Collections SAT"),
  FocusItemPart.subtitle("Le mail décrit par Balzac"),
  FocusItemPart.image(
      imagePath: "$_folder/boulevard-heurteloup-parfait.jpeg",
      legend:
          "« Sur le boulevard Heurteloup », croquis d’après nature de Ch. Parfait, vers 1900. Collection particulière"),
  FocusItemPart.navigation(),
]);
