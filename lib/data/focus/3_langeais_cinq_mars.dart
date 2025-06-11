import "package:cradock_map/models/focus_item.dart";

var langeaisToCinqMars = FocusItem(
    title: "Première partie du journal de Mme Cradock",
    rank: 2,
    routeId: 'premiere-lecture',
    author: null,
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.subtitle("Texte du journal de Mme Cradock"),
      FocusItemPart.paragraphWithRightImage(
          legend: "Gavure du château",
          text: """
Langeais, mercredi 14 septembre 1785.
Vers deux heures nous arrivions à Langeais où nous dînions à « l'Écu-de-France », auberge assez supportable. M. Cradock se trouvant souffrant, nous nous déterminâmes à nous y arrêter la nuit. Dans la soirée, nous fîmes un tour hors de la ville située sur un coteau au pied duquel coule la Loire. On voit encore quelques ruines d'un très ancien château, et les restes d'un autre plus moderne servant de prison. Toujours une campagne fertile, des sites gracieux et des vues de la rivière. Nous soupions à huit heures, et allions nous coucher à dix heures et demie. Les chambres d'une humidité extrême, les lits absolument mouillés ; néanmoins, n'y ayant pas d'insectes, je dormis bien et n'attrapai aucun mal.""",
          imagePath: "assets/focus/3-langeais-chateau/gravure-chateau.jpg"),
      FocusItemPart.navigation()
    ]);
