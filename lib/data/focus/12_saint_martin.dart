import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/12-saint-martin";

// TODO commentaire d'Isabelle Girault : basilique, grille d'argent, éléments
// du trésor, Vierge du peuple.
var saintMartin = FocusItem(
    title: "La basilique Saint-Martin",
    routeId: "basilique-saint-martin",
    rank: 11,
    author: [
      isabelleGiraut
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("La visite de Mme Cradock"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-saint-martin.png",
          legend: "La basilique Saint-Martin sur la carte d’état-major"),
      FocusItemPart.journal(CradockTextData.passagesOf(7)),
      FocusItemPart.normalParagraph(
          text:
              "Note de l’édition de 1896 : « Détruite à la Révolution, il n’en reste que deux tours qui sont assez pour attester de la grandeur et de la magnificence de cette antique basilique. »"),
      FocusItemPart.subtitle("La basilique disparue"),
      FocusItemPart.image(
          imagePath: "$_folder/basilique-fin-18e.jpg",
          legend:
              "Basilique Saint-Martin, fin du XVIIIe s., d’après un dessin de 1620"),
      FocusItemPart.quote(SoreauTextData.saintMartin,
          source: SoreauTextData.sourceAt("p. 133")),
      FocusItemPart.gallery([
        "$_folder/revismartin-exterieur.png",
        "$_folder/revismartin-interieur.png",
      ], "Saint-Martin, restitution 3D ReVISMartin © CESR"),
      FocusItemPart.subtitle("La grille d’argent"),
      FocusItemPart.normalParagraph(
          text:
              "La grille d’argent entourait les châsses des reliques de saint Martin, des évêques Brice, Perpet, Grégoire, Eustache, Euphrone, et de saint Épain. En 1785, Mme Cradock note que ces grilles, autrefois en argent massif, sont désormais en cuivre et fer forgé."),
      FocusItemPart.gallery([
        "$_folder/grille-ia-lithographie.png",
        "$_folder/grille-ia-3d.png",
        "$_folder/grille-ia-coupole.png",
      ], "Propositions de restitution par IA (ChatGPT) à partir de la description de 1475 des pièces de la grille, dont une insertion sous la coupole avec la statue de Louis XI en prière"),
      FocusItemPart.navigation(),
    ]);
