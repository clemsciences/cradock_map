import "package:cradock_map/data/authors.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/9-archeveche";

// TODO commentaire de Martine Bonnin sur l'archevêché.
var archeveche = FocusItem(
    title: "Le palais des archevêques",
    routeId: "archeveche",
    rank: 8,
    author: [
      martineBonnin
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("Le palais en 1785"),
      FocusItemPart.quote(
          "L’archevêché, magnifique construction moderne, est près de la cathédrale ; l’arcade en pierre sculptée surmontant la grille d’entrée, est remarquable, et ce bâtiment, vu du bout de la rue qu’il termine, est très beau.",
          source: "Journal de Mme Cradock, jeudi 15 septembre 1785, p. 284"),
      FocusItemPart.subtitle("Vues du palais"),
      FocusItemPart.image(
          imagePath: "$_folder/palais-des-archeveques.jpeg",
          legend: "Palais des archevêques"),
      FocusItemPart.image(
          imagePath: "$_folder/turner-cathedrale-archeveche.jpeg",
          legend:
              "Tours, la cathédrale vue de la place de l’Archevêché. William Turner, vers 1826-1828. Lavis rehaussé de gouache. © RMN"),
      FocusItemPart.gallery([
        "$_folder/portail-archeveche.jpg",
        "$_folder/moise.png",
      ], "Palais des archevêques : le portail ; Moïse et les tables de la loi ?"),
      FocusItemPart.image(
          imagePath: "$_folder/lithographie-gusman.JPG",
          legend: "Palais des archevêques. Lithographie, Gusman"),
      FocusItemPart.navigation(),
    ]);
