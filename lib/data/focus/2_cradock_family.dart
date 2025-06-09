import "package:cradock_map/data/authors.dart";
import "package:cradock_map/models/focus_item.dart";

var cradockFamily = FocusItem(
    title: "La famille Cradock",
    routeId: "famille-cradock",
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("Origine"),
      FocusItemPart.paragraphWithLeftImage(
          text:
              "Joseph et Anna Francisca Cradock sont originaire du milieu de l’Angleterre dans les comtés de Leicester et de Warwick.",
          imagePath: "assets/focus/2-family/carte-angleterre.jpeg",
          legend: ""),
      FocusItemPart.image(
          imagePath: "assets/focus/2-family/merevale-leicester.jpg",
          legend: "Merevale et Leicester"),
      FocusItemPart.image(
          imagePath: "assets/focus/2-family/merevale-hall.jpg",
          legend: "Merevale Hall"),
      FocusItemPart.subtitle("Famille de Mme Cradock"),
      FocusItemPart.paragraphWithRightImage(
          legend:
              "Acte de naissance d'Anna Francisca Stratford (future Cradock)",
          imagePath:
              "assets/focus/2-family/acte-naissance-anna-francisca-cradock.jpg",
          text:
              """Née à Merevale Hall. Anna Francisca Stratford, fille de Francis Stratford et d’Anne Packe, est baptisée le 6 septembre 1737 .
Elle est la 3e d’une fratrie de 5 enfants :un garçon, James, décédé à l’âge de 4 ans et 4 filles, Sarah, Anna Francisca, Maria et Pénélope Bates.
Son père décède en 1762, âgé de 56 ans."""),
      FocusItemPart.subtitle("Mariage des Cradock"),
      FocusItemPart.paragraphWithLeftImage(
          legend: "Joseph Cradock",
          imagePath: "assets/focus/2-family/joseph-cradock.gif",
          text:
              "En 1765, elle épouse Joseph Cradock, gentleman farmer fort riche. Elle lui apporte la somme de 5000 livres que son père lui a légué par testament."),
      FocusItemPart.subtitle("Dr Heberden"),
      FocusItemPart.paragraphWithRightImage(
          legend: "Le portait du docteur Heberden",
          imagePath: "assets/focus/2-family/dr-heberden.jpg",
          text:
              """De santé fragile et suite à une crise de paralysie, c’est sur les conseils du Dr William Heberden qu’ils entreprennent ce long et intéressant voyage dans le sud de la France, en Flandre et en Hollande.
Le Dr Heberden est l’un des plus éminents médecins anglais du XVIIIe siècle et rhumatologue à qui l’on doit l’Arthrose d'Heberden."""),
      FocusItemPart.subtitle("Fin de Mme Cradock"),
      FocusItemPart.paragraphWithLeftImage(
          legend: "",
          imagePath: "assets/focus/2-family/gumley-hall.jpg",
          text:
              "La santé d’Anna Francisca sembla s’être stabilisée jusqu’au 25 décembre 1816, jour de Noël, à Gumley Hall. "
              "Elle descendait le dernier escalier, son livre de prières à la main, pour se rendre à l'église, parla à la servante et tomba aussitôt, probablement prise d'une crise ; "
              "on lui trouva cependant une fracture importante à la tête. Elle est morte sur le coup."),
      FocusItemPart.subtitle("Famille de Mme Cradock"),
      FocusItemPart.paragraphWithRightImage(
          imagePath: "assets/focus/2-family/cradock-genealogie.jpg",
          legend: "",
          text:
              """Joseph Cradock est le représentant d'une branche cadette d'une famille liée depuis de nombreuses années à la ville de Leicester. Seul fils survivant de Joseph Cradock, bonnetier et drapier, et de sa première épouse, Mary, fille de l'échevin Annice, il nait à Leicester le 9 janvier 1742."""),
      FocusItemPart.subtitle("Les Cradock et la vaccination"),
      FocusItemPart.paragraphWithLeftImage(
          legend: "église St Martin, Leicester",
          imagePath: "assets/focus/2-family/cradock-vaccination.jpg",
          text:
              "Son père, citoyen célèbre de Leicester, était suffisamment intelligent pour braver les préjugés virulents de ses concitoyens en faisant vacciner son fils contre la variole, alors que la pratique venait tout juste d'être introduite."),
      FocusItemPart.image(
        imagePath: "assets/focus/2-family/saint-martin-leicester.jpg",
      ),
      FocusItemPart.subtitle("Décès des parents"),
      FocusItemPart.paragraphWithRightImage(
          imagePath: "assets/focus/2-family/sepulture-joseph-cradock.jpeg",
          legend: "sépulture de Joseph Cradock",
          text:
              """Sa mère décède en 1749 et son père en 1759, lui laissant une fortune considérable."""),
      FocusItemPart.subtitle("Gumley Hall"),
      FocusItemPart.gallery([
        "assets/focus/2-family/gumley-hall-2.jpg",
        "assets/focus/2-family/gumley-hall-3.jpg",
      ], "Gumley Hall"),
      FocusItemPart.normalParagraph(
          text:
              "En 1764, il dépense – huit mille livres, dit-on – pour (re)construire Gumley Hall et aménager les jardins sur le modèle de ceux de Saint-Cloud."),
      FocusItemPart.subtitle("Mariage des Cradock"),
      FocusItemPart.normalParagraph(
          text:
              "En 1765, il épouse Anna Francisca qui 5 ans de plus que lui. Pourtant on a pu lire dans de nombreuses publications que « Madame Cradock était fort choyée par son vieux mari », « qu’il était beaucoup plus vieux qu’elle » !"),
      FocusItemPart.subtitle("Oeuvres"),
      FocusItemPart.paragraphWithRightImage(
          imagePath: "assets/focus/2-family/distribution-wolsey.jpeg",
          legend: "",
          text:
              """Passionné pour le théâtre, il avait établi chez lui une scène, sur laquelle il jouait lui-même et faisait jouer à ses invités la tragédie et la comédie. Il y fit représenter une adaptation de l’Henri VIII de Shakespeare, où il tenait le rôle du cardinal Wolsey, et son épouse celui de Catherine d’Aragon."""),
      FocusItemPart.paragraphWithLeftImage(
        text:
            "Il traduisit et adapta la tragédie Les Scythes, de Voltaire, sous le titre de Zobéide et elle fut représentée en 1773 sur le théâtre de Covent Garden à Londres : Mme Yates, actrice en renom, y tenait le principal rôle, et Goldsmith, l'auteur du Vicaire de Wakefield, en écrivit le prologue.",
        imagePath: "assets/focus/2-family/zobeide.jpeg",
        legend: "",
      ),
      FocusItemPart.subtitle("Correspondance avec Voltaire"),
      FocusItemPart.paragraphWithRightImage(
        legend: "",
        imagePath: "assets/focus/2-family/lettre-voltaire-j-cradock.jpg",
        text:
            """Joseph Cradock en envoya un exemplaire à Voltaire qui lui répondit ainsi, en anglais.""",
      ),
      FocusItemPart.citation(
        """« Monsieur,
9 octobre 1773, à Ferney.
Grâce à votre Muse, un cuivre étranger brille,
Transformé en or et frappé en argent sterling.
Vous avez fait trop d'honneur à un vieil homme malade de quatre-vingts ans.
Je suis, avec la plus sincère estime et gratitude,
Monsieur, votre obéissant serviteur, Voltaire""",
      ),
      FocusItemPart.image(
          imagePath: "assets/focus/2-family/portrait-cradock.gif"),
      FocusItemPart.subtitle("Vie et fin de M. Cradock"),
      FocusItemPart.paragraphWithLeftImage(
          imagePath: "assets/focus/2-family/memoire-cradock.jpg",
          legend: "Mémoire de Mr Cradock.",
          text:
              """Pendant de nombreuses années après son retour au pays, des problèmes de santé contraignirent M. Cradock à se retirer largement de la société ; 
En janvier 1826, il publia le premier volume de ses « Mémoires littéraires et divers », dédié, avec son autorisation, au roi, un honneur dont M. Cradock était à juste titre fier. Vers la fin de la même année, il publia un second volume, relatant son voyage à Paris et dans le Midi de la France de 1783 à 1786.
Bien que remarquable par son hospitalité et ses bonnes manières, il avait à peine bu un verre de vin pendant vingt ans ; et il se nourrissait principalement de navets, de pommes rôties, de café et de boissons alcoolisées, en très petites quantités., tandis que ses médecins le soignaient avec une régularité impitoyable. 
Il avait une constitution particulière, qui l'obligeait à se soumettre constamment à des ventouses ; on l'a vu en recevoir parfois deux fois par jour. Pourtant, malgré toutes ses infirmités et ses souffrances, il éprouvait une compassion des plus tendres, même pour l'apparence de détresse des autres, et, lorsqu'il n'avait plus mal, personne n'était plus joyeux et communicatif ; 
on peut même dire qu'il débordait d'anecdotes, avec une grande part de la loquacité de la vieillesse. 
Au cours des deux dernières semaines, il n'a rien bu d'autre que de l'eau. 
On se souviendra longtemps de lui dans les environs de Gumley, où il était respecté par tous pour sa valeur et idolâtré par les pauvres pour sa bienveillance. D’après ses amis proche, ce portrait réalisé quelques semaines avant sa mort est très ressemblant
Après un déclin progressif pendant environ trois semaines, ce vénérable gentleman mourut le 15 décembre 1826, dans ses appartements du Strand, à l'âge de 85 ans. Lors de ses funérailles, le samedi 23 décembre, une nombreuse assemblée de ses amis était présente pour lui rendre un dernier hommage."""),
      FocusItemPart.navigation()
    ],
    rank: 1,
    author: [patrickRanger]);
