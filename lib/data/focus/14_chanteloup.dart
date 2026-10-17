import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/cradock_text_data.dart";
import "package:cradock_map/data/soreau_text_data.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/14-chanteloup";

var chanteloup = FocusItem(
    title: "Amboise et Chanteloup",
    routeId: "chanteloup",
    rank: 13,
    author: [
      anneDebalMorche
    ],
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("Vers Amboise"),
      FocusItemPart.image(
          imagePath: "$_folder/carte-vers-amboise.png",
          legend: "Vers Amboise : La Frillière, Vouvray, Amboise"),
      FocusItemPart.journal(
          [CradockTextData.passageTitled("De Marmoutier à Amboise")]),
      FocusItemPart.subtitle("Chanteloup"),
      FocusItemPart.gallery([
        "$_folder/carte-amboise-chanteloup.png",
        "$_folder/carte-chanteloup.png",
      ], "D’Amboise à Chanteloup sur la carte d’état-major"),
      FocusItemPart.journal(CradockTextData.passagesOf(9)),
      FocusItemPart.image(
          imagePath: "$_folder/manuscrit-chanteloup.jpeg",
          legend:
              "Le manuscrit original de Mme Cradock : Amboise, « Sunday September the 18th » 1785"),
      FocusItemPart.paragraphWithLeftImage(
          imagePath: "$_folder/chateau-de-chanteloup-lithographie.JPG",
          legend: "Château de Chanteloup. Bourgerie, lithographie",
          text:
              """Un premier château est élevé en 1715 pour le compte de Marie Anne de la Trémouille (1642-1722) qui avait épousé en 1675 le duc de Bracciano, Flavio Orsini, et est connue sous le nom de princesse des Ursins.
Entre 1761 et 1770, le domaine est acheté et embelli par le duc de Choiseul. Brillant officier dans sa jeunesse sous le nom de comte de Stainville, Choiseul avait épousé en 1750 la fille d'un riche financier. C'est l'appui de Mme de Pompadour qui le lança dans la carrière diplomatique, d'où il parvint au poste de Secrétaire d'État à la Guerre et à la Marine. En 1758, il prit le titre de duc de Choiseul et Louis XV lui confia le gouvernement de la Touraine. Voulant tenir son rang, Choiseul acheta alors un hôtel à Tours et, en 1761, le domaine de Chanteloup."""),
      FocusItemPart.paragraphWithRightImage(
          imagePath: "$_folder/chateau-de-chanteloup.JPG",
          legend: "Château de Chanteloup",
          text:
              """Avec Choiseul, le château de Chanteloup devint une magnifique résidence de campagne, entourée de beaux jardins, qu'on n'hésitait pas à comparer à Versailles. L'architecte du duc, Louis-Denis Le Camus, établit deux longues ailes ornées de colonnades, terminées l'une par une chapelle et l'autre par un pavillon des bains. Il procéda également à des aménagements intérieurs, dessina de nouveaux parterres et édifia de vastes communs (on trouvait du marbre jusque dans les étables).
Disgracié en 1770, Choiseul se retira en Touraine. Une foule de visiteurs n'a pas cessé de se presser à Chanteloup entre 1772 et 1774. A cette époque le monde de la Cour délaissait Versailles et Compiègne pour se retrouver à Villers-Cotterêts chez le duc d'Orléans, à Chantilly chez le prince de Condé et chez Choiseul à Chanteloup. Louis XV, en effet, avait interdit l'accès de Chanteloup à toutes les personnes qui ne seraient pas de la famille proche des Choiseul. Il n'en fallut pas plus pour que les visiteurs — qui voulaient par là affirmer leur indépendance — affluent à Amboise."""),
      FocusItemPart.subtitle("La pagode"),
      FocusItemPart.paragraphWithLeftImage(
          imagePath: "$_folder/pagode-de-chanteloup.JPG",
          legend: "Pagode de Chanteloup. Gravure, Le Magasin pittoresque",
          text:
              """En 1774, il décida d'élever au sud du château, près de la grande pièce d'eau, un monument en l'honneur de tous ceux qui étaient venus le voir dans son exil. Ce fut une « pagode », dont la construction fut menée par l'architecte Louis-Denis Le Camus entre 1775 et 1778.
Haute de 44 mètres, la Pagode comporte six étages, en retrait les uns sur les autres, qui reposent sur un péristyle circulaire de seize colonnes et seize piliers. La silhouette générale évoque les chinoiseries de fantaisie en vogue au XVIIIe siècle, d'où le nom de Pagode, mais la colonnade, les quatre balcons de ferronnerie et toute la décoration sont de pur style Louis XVI. Les sept niveaux comportent chacun une salle circulaire voûtée en coupole et sont desservis par un escalier intérieur de 142 marches. Cet escalier est en bois d'acajou, à l'exception de celui du 1er étage qui est de pierre et gardé par une rampe en fer forgé, ornée de bronzes dorés en double C entrelacés (initiales de Choiseul et de Crozat, son épouse). Au rez-de-chaussée, des caractères chinois représentent les mots Amitié et Reconnaissance."""),
      FocusItemPart.subtitle("D’autres regards sur Chanteloup"),
      FocusItemPart.quote(SoreauTextData.chanteloup,
          source: SoreauTextData.sourceAt("p. 125-126")),
      FocusItemPart.quote(CradockTextData.passagesOf(9).single.notes.last,
          source:
              "Note de l’édition de 1896 du Journal de Mme Cradock, p. 292-293"),
      FocusItemPart.subtitle("La fin du voyage en Touraine"),
      FocusItemPart.journal(
          [CradockTextData.passageTitled("D'Amboise à Blois")]),
      FocusItemPart.normalParagraph(
          text:
              "Et c’est ainsi que se termine le voyage de M. et de Mme Cradock en Touraine. Ils se dirigèrent vers Blois où elle apprécia les paysages de Loire et l’animation des bateaux. Elle qui avait dû parfois se contenter d’un morceau de pain apprécia aussi la dinde supérieurement rôtie servie par l’aubergiste, et la promenade sur le mail qui conclut, selon ses termes, cette soirée merveilleuse du 18 septembre 1785."),
      FocusItemPart.navigation(),
    ]);
