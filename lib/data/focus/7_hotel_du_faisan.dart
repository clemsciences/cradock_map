import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/7-hotel-du-faisan";

// TODO commentaire de Florence Cailleau sur l'hôtel du Faisan.
var hotelDuFaisan = FocusItem(
    title: "L’hôtel du Faisan",
    routeId: "hotel-du-faisan",
    rank: 6,
    author: [
      florenceCailleau
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("Le séjour des Cradock"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-hotel-du-faisan.png",
          legend: "L’hôtel du Faisan sur la carte d’état-major"),
      FocusItemPart.normalParagraph(
          text:
              "L’hôtel du Faisan se trouvait en haut de l’actuelle rue Nationale, côté ouest, à l’emplacement de l’actuel café Feuillette ou de la Boîte à Livres. Les Cradock y logent du 15 au 17 septembre 1785."),
      FocusItemPart.journal(CradockTextData.passagesOf(4)),
      FocusItemPart.subtitle("L’hôtel au fil du temps"),
      FocusItemPart.image(
          imagePath: "$_folder/terrier-saint-julien.png",
          legend:
              "L’hôtel du Faisan en 1776-1778. Terrier de Saint-Julien, ADIL H 528"),
      FocusItemPart.image(
          imagePath: "$_folder/banquet-50-eme-anniversaire.png",
          legend:
              "Hôtel du Faisan : menu du banquet du 50e anniversaire de la SAT, 1890"),
      FocusItemPart.image(
          imagePath: "$_folder/annees-1930.png",
          legend:
              "L’hôtel du Faisan vers les années 1930. Collection particulière"),
      FocusItemPart.image(
          imagePath: "$_folder/1940.png",
          legend:
              "1940 : les ruines du quartier et l’emplacement de l’hôtel du Faisan"),
      FocusItemPart.navigation(),
    ]);
