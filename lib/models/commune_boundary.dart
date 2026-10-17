import "package:latlong2/latlong.dart";

/// One part of a commune: an outer ring and its holes (enclaves).
class CommunePart {
  final List<LatLng> outer;
  final List<List<LatLng>> holes;

  const CommunePart({required this.outer, required this.holes});
}

/// Current boundary of a commune (IGN ADMIN EXPRESS COG).
class CommuneBoundary {
  final String name;
  final String inseeCode;
  final List<CommunePart> parts;

  const CommuneBoundary(
      {required this.name, required this.inseeCode, required this.parts});

  /// Builds a commune from a GeoJSON feature with a Polygon or MultiPolygon
  /// geometry (coordinates are [longitude, latitude]).
  factory CommuneBoundary.fromGeoJson(Map<String, dynamic> feature) {
    final properties = feature["properties"] as Map<String, dynamic>;
    final geometry = feature["geometry"] as Map<String, dynamic>;
    final coordinates = geometry["coordinates"] as List;
    final polygons =
        geometry["type"] == "MultiPolygon" ? coordinates : [coordinates];

    List<LatLng> toRing(List ring) => [
          for (var point in ring)
            LatLng((point[1] as num).toDouble(), (point[0] as num).toDouble())
        ];

    return CommuneBoundary(
      name: properties["nom"] as String,
      inseeCode: properties["code_insee"] as String,
      parts: [
        for (var polygon in polygons.cast<List>())
          CommunePart(
            outer: toRing(polygon.first as List),
            holes: [for (var hole in polygon.skip(1)) toRing(hole as List)],
          )
      ],
    );
  }
}
