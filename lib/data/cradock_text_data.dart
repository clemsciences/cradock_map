import "package:cradock_map/models/text.dart";

/// Mme Cradock's journal from Saumur to Blois (14-18 September 1785), checked
/// against the scans of the 1896 edition in assets/texts/ (pages 281-294) and
/// split into passages linked to the steps of [StepData].
///
/// Corrections made to the scanned text: OCR errors, lost punctuation and
/// italics, words hyphenated at the end of a line rejoined, footnotes spread
/// over two pages put back together. The spelling of the edition is kept
/// ("A" for "À", "Marmoutiers", "Chantéloup", "inouis"…).
/// Italics are written *like this*; spaces before ";", ":" and inside
/// « » are non-breaking. The opening lines of page 281
/// (end of the Saumur entry) and of page 294 (start of the Blois entry) are
/// left out as they are incomplete sentences outside Touraine.
class CradockTextData {
  static const CradockOriginalBook book = CradockOriginalBook(
      title: "Journal de Madame Cradock",
      subtitle: "Voyage en France (1783-1786)",
      publisher:
          "Librairie académique Didier, Perrin et Cie, libraires-éditeurs",
      publicationLocation: "Paris",
      url: "https://gallica.bnf.fr/ark:/12148/bpt6k1028087",
      year: 1896);

  static const String wednesday = "mercredi 14 septembre 1785";
  static const String thursday = "jeudi 15 septembre 1785";
  static const String friday = "vendredi 16 septembre 1785";
  static const String saturday = "samedi 17 septembre 1785";
  static const String sunday = "dimanche 18 septembre 1785";

  /// In the order of the journal.
  static const List<JournalPassage> passages = [
    JournalPassage(
        title: "De Saumur à Langeais",
        date: wednesday,
        stepIds: [],
        firstPage: 281,
        lastPage: 281,
        paragraphs: [
          "A huit heures, nous quittions cette jolie ville de Saumur, plus propre que beaucoup d'autres que nous avions visitées. Aux coins des principales rues, sont affichées des ordonnances de police concernant l'entretien et la propreté des rues, et, en même temps, les peines encourues en y contrevenant. Des officiers de justice doivent veiller à l'observation des règlements. D'après le nombre des travaux commencés, la ville semble destinée à s'agrandir considérablement.",
          "Pas tout à fait aussi élevée, la route continue comme celle que nous avions précédemment parcourue ; mais elle est préservée dans différents endroits par des barrières ; aussi, je pus, à mon aise, regarder le charmant pays que nous traversions.",
        ]),
    JournalPassage(
        title: "Une nuit à Langeais",
        date: wednesday,
        stepIds: [1],
        firstPage: 281,
        lastPage: 282,
        paragraphs: [
          "Vers deux heures nous arrivions à Langeais où nous dînions à « l'Écu-de-France », auberge assez supportable. M. Cradock se trouvant souffrant, nous nous déterminâmes à nous y arrêter la nuit. Dans la soirée, nous fîmes un tour hors de la ville située sur un coteau au pied duquel coule la Loire. On voit encore quelques ruines d'un très ancien château, et les restes d'un autre plus moderne servant de prison. Toujours une campagne fertile, des sites gracieux et des vues de la rivière. Nous soupions à huit heures, et allions nous coucher à dix heures et demie. Les chambres d'une humidité extrême, les lits absolument mouillés ; néanmoins, n'y ayant pas d'insectes, je dormis bien et n'attrapai aucun mal.",
        ]),
    JournalPassage(
        title: "Départ de Langeais",
        date: thursday,
        stepIds: [1],
        firstPage: 282,
        lastPage: 282,
        paragraphs: [
          "A sept heures, j'étais levée. M. Cradock, se ressentant encore de son indisposition de la veille, ne se leva qu'à neuf heures. Après son déjeuner, se trouvant mieux, il commanda les chevaux ; mais il nous fallut les attendre jusqu'à dix heures et demie.",
        ]),
    JournalPassage(
        // The road along the troglodyte hillsides passes through Cinq-Mars.
        title: "La route de Tours",
        date: thursday,
        stepIds: [2],
        firstPage: 282,
        lastPage: 283,
        paragraphs: [
          "Nous partîmes enfin pour Tours, longeant toujours des rocs creusés servant d'habitation, et des coteaux couverts, à perte de vue, de vignes surchargées de superbes grappes. A gauche, d'énormes prairies où paissent des troupeaux de bœufs, de vaches, de moutons. Pendant deux milles, nous continuâmes à suivre cette route aplanie lorsque, de nouveau, elle devint élevée et très dangereuse, si bien que, pendant toute la durée d'un relai, ayant un postillon obstiné qui ne voulait rien écouter, je crus plus d'une fois qu'il en était fait de nous. Cependant nous atteignîmes Tours sans accident.",
        ]),
    JournalPassage(
        title: "Le pont de Tours",
        date: thursday,
        stepIds: [3],
        firstPage: 283,
        lastPage: 283,
        paragraphs: [
          "Rien n'égale le coup d'œil du pont à l'entrée de la ville ; il traverse la Loire et conduit en droite ligne à la nouvelle rue que l'on vient d'achever, et qui se prolonge en avenue, même au-delà, dans la campagne.",
        ]),
    JournalPassage(
        title: "L'hôtel du Faisan",
        date: thursday,
        stepIds: [4],
        firstPage: 283,
        lastPage: 283,
        paragraphs: [
          "Nous descendions à deux heures au « Faisan », hôtel dont l'intérieur est loin de répondre à l'extérieur : chambres petites, nourriture peu soignée, tout très inconfortable et très cher.",
        ]),
    JournalPassage(
        title: "La cathédrale",
        date: thursday,
        stepIds: [5],
        firstPage: 283,
        lastPage: 284,
        paragraphs: [
          "Après un dîner médiocre, nous allions voir la cathédrale : quoique dégradée, elle est d'une richesse et d'un fini incomparables. Au-dessus de chacune des entrées de côté, il y a de magnifiques rosaces, entourées d'un travail si délicat qu'on dirait une dentelle de pierre. Dans un des bas-côtés, se trouve une horloge dans le genre de celle de Lyon¹ ; seulement, Dieu le Père n'y est pas représenté ; elle marche, mais ne sonne plus. A côté, sur un autel, un calvaire en bois peint, grandeur nature ; la croix était presque cachée sous un nombre infini d'ex-voto que notre guide nous dit être à vendre pour huit sous pièce ; il nous offrit une jambe et un bras en cire placés au pied de la croix ; mais nous refusâmes, ne comprenant pas la vertu attachée à ces emblèmes. M. Cradock monta jusque dans le clocher voir la vue, une des plus belles de France ; je n'osai affronter cette ascension et continuai à visiter l'église ; aussi notre guide fit-il une nouvelle tentative en me sollicitant de donner de l'argent pour payer des messes, afin que nous fissions bon voyage, proposition que je repoussai comme la première.",
        ],
        notes: [
          "Horloge à mécanique où des personnages sortaient à toutes les heures.",
        ]),
    JournalPassage(
        title: "L'archevêché",
        date: thursday,
        stepIds: [5],
        firstPage: 284,
        lastPage: 284,
        paragraphs: [
          "L'archevêché, magnifique construction moderne, est près de la cathédrale ; l'arcade en pierre sculptée surmontant la grille d'entrée, est remarquable, et ce bâtiment, vu du bout de la rue qu'il termine, est très beau. Dans la bibliothèque, il existe deux manuscrits fort curieux : l'un, le *Pentateuque*, écrit entièrement en petites lettres majuscules ; l'autre, les *Quatre Évangiles*, transcrits en lettres saxonnes.",
        ]),
    JournalPassage(
        title: "Le mail",
        date: thursday,
        stepIds: [6],
        firstPage: 284,
        lastPage: 285,
        paragraphs: [
          "De là, nous sortîmes de la ville et allâmes sur le mail, promenade formée de trois allées d'un mille de longueur, ombragées par quatre rangées de grands ormeaux. Cette promenade était, paraît-il, autrefois si bien entretenue, qu'il n'était pas permis d'y passer après la pluie ; depuis qu'on a tracé de nouvelles avenues, il n'en est certes plus de même, car j'ai même vu paître des vaches sur l'herbe au bord du mail. Ces avenues sont entourées, de chaque côté, d'immenses jardins fruitiers où croissent en abondance les poires, les pommes, le raisin, les pêches, etc., etc.",
        ]),
    JournalPassage(
        title: "Une mauvaise nuit au Faisan",
        date: thursday,
        stepIds: [4],
        firstPage: 285,
        lastPage: 285,
        paragraphs: [
          "A dix heures, je me mettais au lit, mais je n'y étais pas seule : les punaises me furent une société importune.",
        ]),
    JournalPassage(
        title: "La basilique Saint-Martin",
        date: friday,
        stepIds: [7],
        firstPage: 285,
        lastPage: 286,
        paragraphs: [
          "Levés à sept heures, cette mauvaise nuit nous décida à quitter Tours le lendemain. A onze heures, nous allions à l'église Saint-Martin, la plus célèbre de cette ville¹. Derrière le grand autel, se trouve le tombeau du saint où, nous dit-on, se célèbrent, chaque jour, trente messes. Cette église, très ancienne, et d'une étendue immense, divisée en cinq ailes, est d'un style particulier, sans sculptures à l'extérieur. Elle est assombrie par des vitraux peints, dont quelques-uns sont d'une grande richesse de couleurs. De l'entrée, la vue embrasse d'un seul coup la longue nef, et les tribunes du fond composées de trois cintres formés d'élégantes et légères colonnettes, reliées entre elles et soutenues par de magnifiques piliers. Dans chaque cintre, une rangée de petits vitraux. Rien n'est à la fois plus gracieux et plus imposant, quoique les détails en soient un peu interceptés par une clôture, le chœur et le reste de la nef. Autrefois, toutes les grilles autour de l'autel étaient en argent massif ; maintenant elles sont en cuivre et fer forgé. On nous montra, dans la sacristie, les vêtements des grandes fêtes : ils sont d'une richesse et d'un travail inouis ; ceux en velours, brodés d'or de différentes nuances, dépassent tout ce que nous avons vu dans ce genre. Le dais du Saint-Sacrement pour la Fête-Dieu est en velours cramoisi brodé d'or ; c'est le plus riche de France. Nous admirâmes un ostensoir donné cette année à l'église : il est en argent ; les rayons en or, au milieu, un cristal prodigieux ; le travail en est exquis et a dû être exécuté par un artiste de talent. En sortant, nous remarquâmes, derrière un pilier, dans un coin peu apparent, une statue de la Vierge avec l'Enfant-Jésus revêtue d'habillements et d'ornements plus qu'ordinaires. Nous en fîmes l'observation à notre guide, qui nous répondit que c'était la Vierge du peuple.",
        ],
        notes: [
          "Détruite à la Révolution, il n'en reste que deux tours qui sont assez pour attester de la grandeur et de la magnificence de cette antique basilique.",
        ]),
    JournalPassage(
        title: "Les quais et le mail",
        date: friday,
        stepIds: [6],
        firstPage: 286,
        lastPage: 287,
        paragraphs: [
          "Revenus à l'hôtel à deux heures. Après un dîner aussi détestable que celui de la veille, nous nous dirigeâmes vers les quais plantés de deux rangées d'arbres ; de là, on voit la Loire se dérouler au loin, arrosant un pays idéal et formant des îles charmantes. Avant de reprendre le mail, nous nous arrêtâmes à une église dépendant d'un couvent de religieuses : petite, soignée et simple, nous n'y remarquâmes qu'un autel orné de fleurs, sans doute l'ouvrage des bonnes sœurs. — A six heures je rentrai. M. Cradock se promena jusqu'à dix heures. Revenus pour souper, nous ne pûmes obtenir que les restes d'une carpe laissée sans doute par d'autres voyageurs auxquels l'odeur avait suffi. Nous préférâmes nous contenter d'un morceau de pain.",
        ]),
    JournalPassage(
        title: "Départ du Faisan",
        date: saturday,
        stepIds: [4],
        firstPage: 287,
        lastPage: 288,
        paragraphs: [
          "Après déjeuner, nous visitions encore quatre églises, où nous ne remarquions guère que les vitraux et quelques bons tableaux. A une heure, nous prenions notre dernier repas dans cet hôtel où tout, excepté le vin, était mauvais et d'un prix extravagant. Ainsi, pour deux déjeuners composés chacun d'un petit pain, d'un peu de beurre, de trois cuillerées de lait, de sucre jaunâtre, d'une théière d'eau bouillante (j'avais mon propre thé), on nous compta quatre livres, et tout à l'avenant. Quant aux domestiques, peu prévenants et peu polis, leur excuse est qu'ils étaient fort occupés de l'abbesse de Fontevrault descendue avec sa suite dans cet hôtel, où elle est arrivée dans un carrosse attelé de six à huit mules¹. En somme, Tours me parut triste, d'autant plus que je n'y vis aucun amusement public.",
        ],
        notes: [
          "La célèbre abbaye des Bénédictines de Fontevrault, en Anjou, fut fondée en 1100, par Robert d'Arbriscelle, pour des moines et des religieuses. Henri II d'Angleterre, qui en fut un des principaux bienfaiteurs, fut enterré dans le chœur de l'abbaye, ainsi que sa femme, la reine Eléonore, son fils Richard Ier Cœur de Lion, et Isabelle, fille du comte d'Angoulême, troisième femme du roi Jean, et mère de Henri III, qui mourut religieuse de l'abbaye. Le cœur du roi Henri III fut donné à l'abbaye vingt ans après sa mort, selon la promesse qu'il en avait faite durant sa vie, par son fils Edouard Ier. Plusieurs princesses de sang royal devinrent abbesses de l'abbaye de Fontevrault qui, avant la Révolution, était excessivement riche. Le nombre des religieux des deux sexes s'élevait à plus de deux cents, sous la direction de l'abbesse dont l'autorité spirituelle et temporelle était absolue.\nPendant la Révolution, l'abbaye fut convertie en prison, et la chapelle, où se trouvaient les statues des personnages royaux, entièrement détruite. Les statues avaient été mises dans un cellier dépendant de l'abbaye, où on les retrouva en 1816. Le gouvernement anglais désirait les faire transporter à Westminster, mais ne put en obtenir l'autorisation, et, depuis, elles ont été replacées dans la chapelle qui a été relevée.",
        ]),
    JournalPassage(
        title: "L'abbaye de Marmoutier",
        date: saturday,
        stepIds: [8],
        firstPage: 288,
        lastPage: 290,
        paragraphs: [
          "A trois heures, nous partions pour nous arrêter à l'abbaye de Marmoutiers, une des plus riches et des plus anciennes de France. Elle est occupée maintenant par les Bénédictins. Les hommes seuls peuvent pénétrer dans ce couvent ; mais l'église est ouverte à tous et j'en profitai : vaste et magnifique, le chœur séparé du reste est réservé aux moines. Je regardai à travers la grille épaisse et aperçus quelques belles sculptures ; là, pas de statues de saints habillées, le grand autel est superbe. J'attendais en dehors avec ma femme de chambre, tandis que M. Cradock visitait le couvent, quand un frère lai, nous apercevant, nous invita fort obligeamment à entrer nous asseoir dans la loge, ce que nous fîmes. De retour, M. Cradock demanda s'il pouvait me laisser avoir un aperçu du nouvel escalier auquel travaillent encore les ouvriers, mais qui sera bientôt fini. Notre nouvel ami y condescendit, ajoutant que, les moines étant en ce moment à l'office, nous pourrions passer par le réfectoire qui s'ouvre sur cet escalier. Il nous accompagna même auprès du suisse pour lui dire qu'en notre qualité d'Anglaises et d'étrangères il nous laissât entrer, ce dont je fus très fière, car la porte est irrévocablement fermée à toute femme. Le réfectoire avec plafond à corniche, et tables tout autour, est orné de plusieurs tableaux remarquables, particulièrement celui qui recouvre tout le fond de la salle et qui est considéré comme un chef-d'œuvre. Le milieu représente la Cène : Notre-Seigneur est à table avec ses disciples ; à droite, le Christ lave les pieds de ses disciples, et enfin, à gauche, sainte Madeleine essuie ceux du Sauveur avec ses cheveux. L'escalier, moderne et fort élégant, est coupé à angles droits ; il conduit à tous les étages et se termine au-dessous d'un plafond peint ; mais n'étant pas montés, nous ne pûmes distinguer le sujet de la peinture. Nous fîmes ensuite le tour des cloîtres formant un carré couvert autour d'un jardin garni de jolis parterres. A la porte, nous rencontrâmes notre frère lai auquel nous exprimâmes notre admiration pour le beau tableau du réfectoire ; sur ce, il dit au suisse de nous montrer aussi le réfectoire d'hiver. Il est moins grand que le premier, mais tapissé également de tableaux de valeur ; deux surtout me frappèrent : l'un, la sainte Vierge évanouie auprès du corps du Sauveur qu'on vient de descendre de la Croix ; l'autre, saint Mathieu écrivant l'Evangile sur une table devant lui ; la tête du bœuf est vivante.",
          "Le suisse allait nous conduire plus loin, lorsque, apercevant les moines revenant de l'office, il s'arrêta subitement et nous pria de l'excuser de ne pouvoir nous en montrer davantage. Nous fûmes donc forcés à regret d'écourter notre visite et de remercier, plus tôt que nous ne l'eussions désiré, le complaisant suisse et l'aimable frère lai. Les bons Pères ne doivent pas s'ennuyer dans cette superbe résidence, entourée de dépendances admirablement entretenues et dominant un site délicieux ; d'ailleurs, ils peuvent, nous dit-on, recevoir des invités.",
        ]),
    JournalPassage(
        title: "De Marmoutier à Amboise",
        date: saturday,
        stepIds: [],
        firstPage: 290,
        lastPage: 291,
        paragraphs: [
          "Remontés dans notre chaise, nous poursuivîmes notre voyage jusqu'à Amboise, suivant une route sablée baignée par la Loire, route si charmante, qu'on semble traverser perpétuellement un parc coupé par des jardins. Peu après six heures, nous arrivions à la vieille petite ville d'Amboise, et descendions au « Cheval-Bardé », véritable auberge de rouliers, où sept voitures chargées stationnaient devant la porte, mais propre et bien tenue. A huit heures, nous soupions.",
        ]),
    JournalPassage(
        title: "Chanteloup",
        date: sunday,
        stepIds: [9],
        firstPage: 291,
        lastPage: 293,
        paragraphs: [
          "Après déjeuner, été à pied à un quart de lieue d'Amboise voir Chanteloup, résidence du duc de Choiseul, mort il y a quatre mois. Le feu duc est si regretté, qu'un pauvre homme, garde-barrière du pont menant à la ville, dit à M. Cradock que, « si pour rendre la vie au duc, il eût suffi de faire pleurer les cailloux du chemin, on leur eût arraché des larmes ». Sa mort a été un véritable deuil pour le pays tout entier où il répandait en abondance ses bienfaits, surtout parmi les pauvres qu'il soulageait généreusement. De la ville à Chantéloup, la route plantée de beaux arbres, suit presque tout le temps les bords de la rivière.",
          "Le château est à gauche, au bout d'une longue avenue coupant d'immenses champs de vignes. Les appartements du duc et de la duchesse sont somptueusement décorés. La bibliothèque du duc¹, vaste et longue, contient, avec les livres, quelques antiques excessivement rares. A la suite, son petit cabinet de travail dans lequel nous remarquâmes une table à écrire fort curieuse et trois bons tableaux, dont deux, représentant *Rome ancienne* et *Rome moderne*, sont suspendus de chaque côté de la cheminée ; le troisième, faisant face, reproduit l'entrée du duc comme ambassadeur à Rome.",
          "Du cabinet de toilette de la duchesse, où il y a un beau portrait en tapisserie des Gobelins, nous passâmes dans sa bibliothèque, petite et étroite, éclairée d'en haut. Une fois la porte fermée, on ne peut découvrir aucune entrée, ni deviner comment on accède à une galerie au dessus. En touchant un ressort, une porte ayant l'air de faire partie du meuble où sont placés les livres s'ouvre sur un très petit escalier tournant, par lequel on arrive à la galerie garnie d'une légère rampe en fer. Nous remarquâmes aussi dans cette bibliothèque quantité d'objets d'art en bronze et en marbre. Des appartements du rez-de-chaussée, on n'a aucune vue sur la Loire, bien qu'on n'en soit pas loin. Par une des fenêtres de la grande salle, on appela notre attention sur une immense pagode bâtie par le duc. Par malheur, il n'y a pas d'héritiers directs et on craint que cette belle propriété ne soit vendue².",
        ],
        notes: [
          "Une partie du corps de la bibliothèque de Chanteloup est maintenant à la Bibliothèque municipale de Tours.",
          "Arthur Young, le célèbre agriculteur et voyageur anglais, qui vint à Chanteloup deux ans après, en septembre 1787, dit : « Été à Chanteloup, magnifique résidence du duc de Choiseul, sur une hauteur, à une petite distance de la Loire qu'on aperçoit en hiver, ou lorsqu'elle déborde, mais à peine distincte dans cette saison. Le rez-de-chaussée comprend sept pièces. La salle à manger mesure 30 pieds de longueur sur 20 de largeur ; le salon 30 sur 33. La bibliothèque qui mesure 72 pieds sur 200, a été tendue par le possesseur actuel (le duc de Penthièvre) de superbes tapisseries des Gobelins. Dans les jardins d'agrément, sur une colline commandant une vue splendide, s'élève une pagode chinoise de 120 pieds de hauteur. Construite par le duc en souvenir de ceux de ses amis qui venaient le visiter dans son exil, tous les noms sont inscrits sur les murs de la première chambre ; le nombre et le rang des personnes inscrites font honneur au duc et à elles-mêmes. La forêt, aperçue du haut de la pagode a, dit-on, une étendue de 11 lieues. De belles allées, tracées dans différents sens, aboutissent toutes à cette pagode où, du vivant du duc, on se donnait rendez-vous pour les chasses. »\nLe beau domaine de Chanteloup n'existe plus. Il a été vendu par lots, et le château détruit : la pagode seule a été respectée.",
        ]),
    JournalPassage(
        title: "D'Amboise à Blois",
        date: sunday,
        stepIds: [],
        firstPage: 293,
        lastPage: 294,
        paragraphs: [
          "Revenus à notre auberge à midi, nous nous disposâmes à poursuivre notre voyage. Notre aubergiste nous présenta un mémoire si exorbitant que nous refusâmes de le payer sans diminution, et il finit par accepter nos offres.",
          "La route est de nouveau très mauvaise, aussi n'eus-je guère moins de craintes que sur celle de Saumur, surtout à cause de notre détestable postillon ; cependant nous arrivâmes à cinq heures, sains et saufs à Blois, où nous descendîmes à l'« hôtel Gallère », très vieil hôtel où s'arrêtait toujours Louis XIV, lors de ses chasses royales. Les appartements que nous occupons portent encore le nom d'appartements du roi : quelques meubles sont les mêmes que du temps du grand monarque. Les murs sont tendus d'étoffe magnifique tissée de soie et d'argent, le sofa est en velours vert richement brodé ; mais les portes et le plancher seraient tout au plus dignes d'une chaumière ; les fenêtres, d'une écurie ; et le plafond, d'une grange. La situation de cet hôtel, au bout de la ville sur un quai au bord de la Loire, rachète le délabré de l'intérieur. A gauche, on découvre un superbe pont en pierre reposant sur treize arches, au milieu duquel s'élève un obélisque de 50 pieds. Ce pont conduit à un bourg qui apparaît sur la hauteur boisée de la rive opposée. La grande route et les bateaux, vu de nos fenêtres, donnent une animation et une vie extraordinaires à ce paysage.",
          "La propriétaire de l'hôtel, veuve avec sept enfants, nous traita on ne peut mieux. A souper, elle nous servit une dinde supérieurement rôtie.",
          "La soirée étant merveilleuse, nous allions à huit heures et demie faire un tour sur le mail, promenade sablée longeant la rivière et plantée de deux rangées d'ormeaux si épais, qu'ils ne laissent pénétrer ni le soleil, ni le vent. A dix heures, nous nous mettions au lit.",
        ]),
  ];

  /// The passage called [title] (for the passages without a step).
  static JournalPassage passageTitled(String title) =>
      passages.firstWhere((passage) => passage.title == title);

  /// The passages about the step [stepId], in the order of the journal.
  static List<JournalPassage> passagesOf(int stepId) => [
        for (var passage in passages)
          if (passage.stepIds.contains(stepId)) passage
      ];
}
