import "package:cradock_map/data/authors.dart";
import "package:cradock_map/models/focus_item.dart";

var cradockJournal = FocusItem(
    title: "Le journal de Mme Cradock",
    routeId: "journal-cradock",
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.subtitle(""),
      FocusItemPart.paragraphWithLeftImage(
          text: """
L’aventure des goûters de nos trésors a débuté en 2023 avec l’acquisition par la BHT du Journal de Madame Cradock : voyage en France sur la suggestion de l’un des membres de la bibliothèque, Jean-Didier Butard, dont le XVIIIe siècle est le siècle de prédilection. D’autres récits de voyage, comme les voyages en France, d’Arthur Young, entre 1787 et 1789, auraient également pu retenir notre attention : Arthur Young est un agriculteur et agronome britannique. C’est un observateur avisé qui livre des informations précieuses sur la France rurale, l’état du réseau routier, le mode de vie des habitants et leur état d’esprit  Mais ce qui nous a touchés dans les Voyages de Madame Cradock est précisément ce qui est décrit par Madame Balleyguier (sur qui je reviendrai plus tard) dans la préface de l’ouvrage : 

""",
          imagePath:
              "assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution.png",
          legend: ""),
      FocusItemPart.normalParagraph(
        text:
            """C’est à Londres, au milieu d’un lot de papiers sans importance, chez un brocanteur n’y portant aucune attention qu’Odalie Balleyguier mit la main sur ce journal manuscrit noirci d’une délicate écriture féminine. Fière de sa trouvaille, elle le traduisit en français et le fit publier en 1896 aux éditions Perrin sous la forme d’un petit volume de plus de 300 pages.""",
      ),
      FocusItemPart.gallery([
        "assets/focus/1-edition/1-manuscrit-original-1.png",
        "assets/focus/1-edition/1-manuscrit-original-2.png",
        "assets/focus/1-edition/1-manuscrit-original-3.png"
      ], "Manuscrit original"),
      FocusItemPart.paragraphWithRightImage(
          text:
              """En 2012, l’ouvrage, numérisé par la BnF  et également accessible sur Gallica, est réédité (HACHETTE LIVRE les imprimant à la demande). En juin 2023, Jean-Marie Balleyguier, descendant d’Odalie, scanne, annote et enrichit le texte édité par sa trisaïeule.""",
          imagePath:
              "assets/focus/1-edition/1-la-vie-francaise-a-la-veille-de-la-revolution-juin-2023.png",
          legend: ""),
      FocusItemPart.normalParagraph(
          text:
              """Quelques mots sur Madame Balleyguier, à qui nous devons de connaître les aventures de Madame Cradock : Odalie Wherris (1829-1908) est de nationalité anglaise. En 1854, elle épouse Delphin Balleyguier, musicien passionné qui passa toute sa vie au Ministère des Finances…""",
          ),
      FocusItemPart.normalParagraph(
          text:
              """Mme Cradock prit le parti de noter chaque jour ce qu'elle voyait. A ces récits, très exactement, simplement et même naïvement rédigés, elle mêle les détails intimes de sa vie journalière et personnelle donnant la juste note de l'existence d'une anglaise voyageant à l'étranger. Mme Cradock ne paraît pas avoir été une personne supérieure. Elle ne se livre à aucune considération philosophique si fort à la mode à l'époque, ni à aucune réflexion d'une portée élevée. Elle n'aperçoit même, dans ses voyages, à travers la France, aucun indice précurseur de la grande révolution qui se prépare, ou, du moins, il n'en est aucune trace dans son journal. Cette absence de toute vue de l'au-delà est précisément ce qui donne un prix inestimable à ses récits. Elle voit et décrit la vie telle qu'elle était alors, et rien de plus. Elle est, en revanche, d'une exactitude telle que certaines pages de son journal forment une suite de tableaux saisis sur le vif. Soit qu'elle dépeigne la vie de Paris avec son incessant mouvement, ses processions, ses foires, ses fêtes; soit qu'elle fasse la description d'un palais, d'un hôtel, d'une habitation comme celle du comte de Bar, elle n'oublie rien dans ses investigations, au point que l'on pourrait, à l'aide de sa relation, reconstituer le palais, l'hôtel ou l'habitation. Enfin, la bonne humeur constante de Mme Cradock, quoi qu'il lui arrive, ne laisse pas que de rendre agréable la lecture de son journal.""",
      ),
      FocusItemPart.navigation(),
    ],
    rank: 0,
    author: [florenceCailleau]);
