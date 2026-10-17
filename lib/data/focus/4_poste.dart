import "package:cradock_map/data/authors.dart";
import "package:cradock_map/models/focus_item.dart";

const String _folder = "assets/focus/4-chaise-de-poste";

var moyensDeTransport = FocusItem(
    title: "Les moyens de transport",
    routeId: "moyens-de-transport",
    parts: [
      FocusItemPart.navigation(),
      FocusItemPart.summary([]),
      FocusItemPart.subtitle("La chaise de poste"),
      FocusItemPart.paragraphWithRightImage(
          text:
              """Permettez-moi de vous expliquer la manière de voyager de M. et Mme Cradock : ils utilisent une chaise de poste, c’est un véhicule léger, à deux roues. Comme la caisse est très basse et que les roues sont très grandes, on y entre par l’avant. Ce véhicule, en raison de sa légèreté et de sa rapidité, était au départ uniquement destiné au courrier (nom de la personne qui transportait la correspondance de la Poste aux lettres) et a ensuite été adopté par les particuliers.
La chaise de poste a 2 places. M. et Mme Cradock ont 2 chaises de poste car ils sont accompagnés de leurs domestiques : l’une pour Mme Cradock et sa femme de chambre, l’autre pour M. Cradock et son majordome. Dans les auberges, ils devaient aussi avoir chacun leur chambre avec leurs domestiques respectifs. Ce sont leurs véhicules personnels, et à chaque étape ils doivent louer les chevaux.""",
          imagePath: "$_folder/chaise-de-poste.jpg",
          legend: "Chaise de poste"),
      FocusItemPart.subtitle("La poste aux chevaux"),
      FocusItemPart.paragraphWithLeftImage(
          text:
              """La chaise de poste est tirée par un cheval placé entre les brancards, et menée par un postillon monté sur un deuxième cheval, le porteur. Un troisième cheval, le bricolier, pouvait être attelé du côté droit. Le postillon porte des grandes bottes en cuir, avec des renforts en bois, pour être protégé des barres de l’attelage. Il ne marche pas avec ses bottes. Elles sont restées célèbres car ce sont ses bottes dites de 7 lieues (distance entre 2 relais) qu’emprunte le Petit Poucet pour aller plus vite.
Le postillon n’avait pas bonne réputation. Il était hâbleur, volage, parfois ivre, et parlait fort (d’où le terme postillon, pour les jets de salive sortant de la bouche). D’ailleurs Mme Cradock se plaint à plusieurs reprises du comportement du postillon.
Au début, il n’y avait pas de système de freinage pour les véhicules attelés ; pour ralentir la voiture, on devait ralentir les chevaux. Le plus compliqué était dans les descentes rapides : on bloquait les roues avec des pièces de bois, d’où l’expression « mettre des bâtons dans les roues ». Ensuite on inventa le frein à sabot.""",
          imagePath: "$_folder/chaise-de-poste-et-postillon.png",
          legend: "La poste aux chevaux. Chaise de poste et postillon botté"),
      FocusItemPart.subtitle("Les relais"),
      FocusItemPart.paragraphWithRightImage(
          text:
              """L’organisation des déplacements repose sur le principe du relais. Disposés à l’origine toutes les 7 lieues (1 lieue équivaut à env. 4 km), ils ont été établis toutes les 4-5 lieues, soit 16 à 20 km, et le trajet durait environ 1 heure pour les voyageurs ; il pouvait être plus rapide pour le transport du courrier, car les chevaux avaient le droit d’aller au galop.""",
          imagePath: "$_folder/changement-de-chevaux.jpg",
          legend: "Changement de chevaux"),
      FocusItemPart.normalParagraph(
          text:
              """A chaque relais, le postillon attelait les chevaux, conduisait les voyageurs au relais suivant où les chevaux étaient remplacés et le postillon revenait à son relais d’origine avec les chevaux.
Dans les relais se trouvait aussi une auberge où les voyageurs pouvaient déjeuner et dormir."""),
      FocusItemPart.image(
          imagePath: "$_folder/relais-langeais-amboise.png",
          legend:
              "Relais de poste de Langeais à Amboise : Langeais, Cinq-Mars, le port de Luynes, Tours, La Frillière, Vouvray, Amboise"),
      FocusItemPart.navigation(),
    ],
    rank: 3,
    author: [anneDebalMorche]);
