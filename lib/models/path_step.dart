import 'package:latlong2/latlong.dart';

class PathStep {
  final int id;
  final String name;
  final String description;
  final List<String> references;
  final LatLng position;
  final double zoom;

  PathStep(
      {required this.id,
      required this.name,
      required this.description,
      required this.references,
      required this.position,
      required this.zoom});

}
