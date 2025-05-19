import 'package:cradock_map/models/path_step.dart';
import 'package:latlong2/latlong.dart';

class StepData {
  static final List<PathStep> steps = [
    PathStep(
        id: 1,
        zoom: 15,
        name: "Langeais",
        description: "Début du voyage en Touraine",
        references: ["https://www.wikidata.org/wiki/Q383360", ],
        position: const LatLng(47.325556, 0.406111)),
    PathStep(
        id: 2,
        zoom: 15,
        name: "Cinq Mars la Pile",
        description: "",
        references: ["https://www.wikidata.org/wiki/Q671169"],
        position: const LatLng(47.3475, 0.461667)),
    PathStep(
        id: 3,
        zoom: 15,
        name: "Tours - pont",
        description: "Pont de Tours (rive nord = bas de la tranchée actuelle). Il faudrait \"dessiner\" le pont à son emplacement de 1785 (seul le vieux pont figure sur la carte geoportail)",
        references: [],
        position: const LatLng(47.399029, 0.685568)),
    PathStep(
        id: 4,
        zoom: 15,
        name: "Tours - Hôtel du faisan",
        description: "en haut de l’actuelle rue Nationale, côté Ouest, à l’emplacement de l’actuel café Feuillette ou de la Boîte à Livres",
        references: [],
        position: const LatLng(47.395091, 0.686619)),
    PathStep(
        id: 5,
        zoom: 15,
        name: "Tours – Cathédrale et archevêché",
        description: "en haut de l’actuelle rue Nationale, côté Ouest, à l’emplacement de l’actuel café Feuillette ou de la Boîte à Livres",
        references: [],
        position: const LatLng(47.39557, 0.694235)),
    PathStep(
        id: 6,
        zoom: 15,
        name: "Tours – les mails",
        description: "ce sont les actuels boulevards Béranger et Heurteloup / sur la carte Géoportail c’est toute la bordure crénelée qui borde la ville au sud et à l’est (je l'ai mise en jaune)",
        references: [],
        position: const LatLng(47.391124, 0.695232)),
    PathStep(
        id: 7,
        zoom: 15,
        name: "Tours - basilique St Martin",
        description: "",
        references: ["https://www.wikidata.org/wiki/Q1464908"],
        position: const LatLng(47.393056, 0.682778)),
    PathStep(
        id: 8,
        zoom: 15,
        name: "Marmoutier",
        description: "",
        references: ["https://www.wikidata.org/wiki/Q177050"],
        position: const LatLng(47.403056, 0.717222)),
    PathStep(
        id: 9,
        zoom: 15,
        name: "Chanteloup (au sud-ouest d'Amboise)",
        description: "",
        references: ["https://www.wikidata.org/wiki/Q477341"],
        position: const LatLng(47.390972, 0.97)),
  ];
}
