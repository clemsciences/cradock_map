import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/8-cathedrale";

// TODO commentaires de Florence Cailleau (cathédrale) et de Philippe Rouillac
// (horloge).
var cathedrale = FocusItem(
    title: "La cathédrale et son horloge",
    routeId: "cathedrale",
    rank: 7,
    author: [
      florenceCailleau,
      philippeRouillac
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("La cathédrale Saint-Gatien"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-cathedrale.png",
          legend: "La cathédrale sur la carte d’état-major"),
      FocusItemPart.journal(CradockTextData.passagesOf(5).take(1).toList()),
      FocusItemPart.gallery([
        "$_folder/cathedrale.jpg",
        "$_folder/interieur.jpg",
      ], "Cathédrale Saint-Gatien"),
      FocusItemPart.quote(SoreauTextData.cathedral,
          source: SoreauTextData.sourceAt("p. 133")),
      FocusItemPart.subtitle("L’horloge"),
      FocusItemPart.quote(
          "Dans un des bas-côtés, se trouve une horloge dans le genre de celle de Lyon ; seulement, Dieu le Père n’y est pas représenté ; elle marche, mais ne sonne plus.",
          source: "Journal de Mme Cradock, p. 283"),
      FocusItemPart.normalParagraph(
          text:
              "Note de l’édition de 1896 : « Horloge à mécanique où des personnages sortaient à toutes les heures. »"),
      FocusItemPart.image(
          imagePath: "$_folder/horloge-astronomique-de-lyon.jpg",
          legend: "Horloge astronomique de Lyon"),
      FocusItemPart.gallery([
        "$_folder/lettre-reparation-horloge.jpg",
        "$_folder/lettre-signature.jpg",
      ], "Réparation, augmentation et réédification de l’horloge, janvier 1525. Jullian Couldray, horloger du roy. AD37, Viau, 3E1/53"),
      FocusItemPart.gallery([
        "$_folder/horloge-chartres.jpg",
        "$_folder/horloge-chartres-cadran-exterieur.jpg",
        "$_folder/horloge-chartres-cadran-interieur.jpg",
      ], "Horloge astronomique de Chartres : cadrans extérieur et intérieur"),
      FocusItemPart.gallery([
        "$_folder/roue-dentee-le-roy.jpeg",
        "$_folder/inscription-le-roy-tours-1698.jpg",
      ], "Réparation par Pierre Le Roy, horloger place du Grand Marché : « LE ROY », « A TOURS 1698 »"),
      FocusItemPart.gallery([
        "$_folder/horloge-bourges.jpg",
        "$_folder/horloge-bourges-mecanisme.JPG",
      ], "Horloge astronomique de Bourges"),
      FocusItemPart.subtitle(
          "L’horloge de Tours dans les collections de la SAT"),
      FocusItemPart.gallery([
        "$_folder/cavalier-horloge-tours.png",
        "$_folder/chevaux-horloge-tours.png",
        "$_folder/cheval-horloge-tours.jpg",
      ], "Chevaux et cavalier. Horloge astronomique de Tours. Collections SAT"),
      FocusItemPart.gallery([
        "$_folder/personnage-horloge-tours-1.jpeg",
        "$_folder/personnage-horloge-tours-2.jpeg",
      ], "Horloge astronomique : personnages. Collections SAT"),
      FocusItemPart.gallery([
        "$_folder/statue-horloge-portative.jpg",
        "$_folder/statue-horloge-portative-detail.jpg",
      ], "Statue Renaissance avec horloge portative, modèle des horloges astronomiques. Exposition « Renaissance d’une œuvre », MBA Tours, mai 2025"),
      FocusItemPart.navigation(),
    ]);
