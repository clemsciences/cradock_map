import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/6-rue-royale";

// TODO commentaire de Martine Bonnin sur la rue Royale.
var rueRoyale =
    FocusItem(title: "La rue Royale", routeId: "rue-royale", rank: 5, author: [
  martineBonnin
], parts: [
  FocusItemPart.navigation(),
  FocusItemPart.summary([]),
  FocusItemPart.journal(CradockTextData.passagesOf(3)),
  FocusItemPart.subtitle("Le nord de la rue : la place Royale"),
  FocusItemPart.image(
      imagePath: "$_folder/plan.jpg",
      legend:
          "Nord de la rue Royale, 1786 : place Royale, future place Anatole France, avec le musée et l’école des Beaux-Arts, l’hôtel de ville, l’église Saint-Julien et la bibliothèque. Plan d’Étienne Fournier, architecte, février 1786"),
  FocusItemPart.image(
      imagePath: "$_folder/rue-royale.jpg",
      legend: "La place Royale, future place Anatole France"),
  FocusItemPart.subtitle("Les façades"),
  FocusItemPart.gallery([
    "$_folder/facades-est-1.jpg",
    "$_folder/facades-est-2.jpg",
  ], "Façades est de la rue Royale. Estimation des façades, De Limay, ingénieur. Début en 1766"),
  FocusItemPart.gallery([
    "$_folder/ancien-musee-des-beaux-arts.jpg",
    "$_folder/maison-d-enfance-de-balzac.jpg",
  ], "Porches d’entrée, rue Royale : musée des Beaux-Arts, maison d’enfance de Balzac"),
  FocusItemPart.subtitle("Le sud de la rue : la place des portes de fer"),
  FocusItemPart.image(
      imagePath: "$_folder/portes-de-fer-pringot.jpeg",
      legend: "Les portes de fer. Dessin Thomas Pringot, 1781. Collection SAT"),
  FocusItemPart.image(
      imagePath: "$_folder/plan-place-sud-1781.png",
      legend:
          "Place sud, future place Jean-Jaurès : « Plan de la place à l’entrée de la ville, par la route d’Espagne, présenté par Mr Chauveau de la Millière, intendant général des ponts et chaussées, approuvé en 1781 par le conseil d’État »"),
  FocusItemPart.gallery([
    "$_folder/portes-de-fer-detail.png",
    "$_folder/place-jean-jaures-2023.jpg",
  ], "Les portes de fer et les pavillons d’octroi ; la place Jean-Jaurès en 2023"),
  FocusItemPart.navigation(),
]);
