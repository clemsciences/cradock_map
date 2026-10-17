import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/3-langeais-chateau";

var langeaisToCinqMars = FocusItem(
    title: "Langeais et la route de Tours",
    rank: 2,
    routeId: "premiere-lecture",
    author: [
      emilieTrebuchet
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("Langeais"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-langeais.png",
          legend: "Langeais sur la carte d'état-major"),
      FocusItemPart.journal(CradockTextData.passagesOf(1).take(1).toList()),
      FocusItemPart.paragraphWithRightImage(
          legend: "Langeais",
          imagePath: "$_folder/gravure-chateau.jpg",
          text:
              """Mme Cradock est un témoin direct des préoccupations à la fois esthétiques et culturelles de la haute société anglaise du XVIIIe s. Les voyages se focalisent dans le Val de Loire sur les villes-étapes, avec un attrait pour leurs châteaux, ponts, remparts et édifices religieux (églises, abbayes, cathédrales). C’est un intérêt clairement orienté vers les édifices médiévaux et modernes, qui omet presque toujours celui, plus français et catholique, porté sur les témoins de l’Antiquité et de la grandeur de Rome (on est à l’époque de Félix Le Royer de la Sauvagère et du comte de Caylus qui se focalisent sur les antiquités mais sans doute hors réseau des Anglais)."""),
      FocusItemPart.normalParagraph(
          text:
              """Avec ce premier extrait, nous avons un condensé du regard systématique que pose Anna Cradock sur les sites patrimoniaux qu’elle traverse : un goût évident pour les caractéristiques architecturales et la teneur historique des lieux, mais presque toujours elle replace le patrimoine bâti dans son environnement naturel, dans un paysage plus large. Elle associe le plus souvent les monuments qui lui plaisent à une nature abondante (rivière, sites arborés…) et à des activités agricoles florissantes (vigne, élevage…). C’est d’ailleurs plus largement une particularité des Britanniques qui relatent leurs voyages aux XVIIe et XVIIIe s. : ils développent une observation et une esthétique particulières des paysages naturels, allant même privilégier au XVIIIe s. les voyages dans les Alpes, autour des grands paysages de montagne."""),
      FocusItemPart.paragraphWithLeftImage(
          legend:
              "Langeais, le vieux château. Tableaux chronologiques de l’histoire de France, pl. 71, XVIIIe ou XIXe s. Le jardin anglais n’existait pas à l’époque de Mme Cradock.",
          imagePath: "$_folder/chateau-2.jpg",
          text:
              """A Langeais, Mme Cradock a ainsi bien conscience de la topographie des lieux. De manière imprécise, en parlant de coteau, elle rappelle que les châteaux y ont été bâtis sur un grand promontoire qui domine la Loire. Elle observe clairement les ruines du premier donjon édifié par Foulque Nerra, détruit durant la guerre de Cent Ans et dont il ne reste déjà comme à notre époque plus qu’une façade. Celle-ci a été longtemps interprétée comme un vestige de l’époque gallo-romaine, avant d’être étudiée dans les années 1990 (Impey, Lorans)."""),
      FocusItemPart.paragraphWithRightImage(
          legend: "Langeais, le château",
          imagePath: "$_folder/chateau-3.jpg",
          text:
              """Mme Cradock ne fait que voir de loin le château édifié sous Louis XI (achevé en 1469), qui sert de prison et est sans doute en très mauvais état. Cela nous rappelle aussi qu’elle voyage seulement 4 ans avant la Révolution, à laquelle va succéder la destruction d’édifices religieux qu’elle visite sur son parcours (dont l’église abbatiale de Marmoutier)."""),
      FocusItemPart.image(
          imagePath: "$_folder/chateau-4.jpg",
          legend:
              "Langeais, le château. Lithographie couleur, Isidore Dagnan. Collection SAT"),
      FocusItemPart.subtitle("De Langeais à Tours"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-langeais-tours.png",
          legend: "De Langeais à Tours, en passant par Cinq-Mars et Luynes"),
      FocusItemPart.journal([
        ...CradockTextData.passagesOf(1).skip(1),
        ...CradockTextData.passagesOf(2),
      ]),
      FocusItemPart.image(
          imagePath: "$_folder/carte-cinq-mars.png",
          legend: "Cinq-Mars-la-Pile sur la carte d'état-major"),
      FocusItemPart.paragraphWithRightImage(
          legend: "La pile de Cinq-Mars",
          imagePath: "$_folder/pile-de-cinq-mars.png",
          text:
              """Sur ce trajet de transition entre Langeais et Tours, la voyageuse se focalise sur la campagne et ses richesses, puis sa dangerosité. On comprend qu’elle longe le bas du coteau au moins jusqu’au bourg de Cinq-Mars-la-Pile (habitations troglodytes), mais on peut s’interroger sur son parcours ensuite pour atteindre Tours (en haut de coteau ?). Elle ne mentionne ni la pile de Cinq-Mars, ni le château et l’aqueduc de Luynes, pourtant déjà bien identifiés et étudiés par les archéologues antiquaires de l’époque."""),
      FocusItemPart.normalParagraph(
          text:
              "Un autre voyageur, qui parcourt la Touraine un an plus tôt, s'arrête au contraire sur les vestiges de Luynes :"),
      FocusItemPart.quote(SoreauTextData.luynes,
          source: SoreauTextData.sourceAt("p. 134")),
      FocusItemPart.navigation()
    ]);
