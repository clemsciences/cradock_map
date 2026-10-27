import "dart:async";

import "package:cradock_map/data/app_data.dart";
import "package:cradock_map/data/commune_boundary_data.dart";
import "package:cradock_map/data/tile_provider_data.dart";
import "package:cradock_map/models/commune_boundary.dart";
import "package:cradock_map/models/path_step.dart";
import "package:cradock_map/models/view_mode.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/zoom_buttons.dart";
import "package:cradock_map/ui/map/image_tile.dart";
import "package:cradock_map/ui/map/markers/marker.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:flutter_map_animations/flutter_map_animations.dart";
import "package:latlong2/latlong.dart";
import "package:provider/provider.dart";

class TouraineMap extends StatefulWidget {
  final GlobalKey mapKey;
  final LatLng initialCenter;

  const TouraineMap(
      {super.key, required this.mapKey, required this.initialCenter});

  @override
  State<TouraineMap> createState() => _TouraineMapState();
}

class _TouraineMapState extends State<TouraineMap>
    with TickerProviderStateMixin {
  static const double minZoom = 6;
  static const double maxZoom = 25;
  static const Color communeBorderColor = Color(0xFF6A1B9A);

  late final AnimatedMapController _animatedMapController =
      AnimatedMapController(vsync: this);
  StreamSubscription<List<PathStep>>? _stepSubscription;

  // The map is rebuilt at every tick of the sequence animation: polygons are
  // built once per data set instead (label placement is computed on them).
  List<CommuneBoundary>? _polygonsSource;
  List<Polygon> _communePolygons = [];

  List<Polygon> _buildCommunePolygons(List<CommuneBoundary> communes) {
    if (!identical(communes, _polygonsSource)) {
      _polygonsSource = communes;
      _communePolygons = [
        for (var commune in communes)
          for (var (index, part) in commune.parts.indexed)
            Polygon(
              points: part.outer,
              holePointsList: part.holes,
              borderColor: communeBorderColor,
              borderStrokeWidth: 1.5,
              // Only the main part of the commune is labelled.
              label: index == 0 ? commune.name : null,
              labelStyle: const TextStyle(
                  color: communeBorderColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w600),
              labelPlacement: PolygonLabelPlacement.polylabel,
            )
      ];
    }
    return _communePolygons;
  }

  @override
  void initState() {
    super.initState();
    // Once the map is on screen, prepare the optional layers' data.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<AppStateNotifier>().preloadCommuneBoundaries();
      }
    });
  }

  @override
  void dispose() {
    _stepSubscription?.cancel();
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      key: widget.mapKey,
      child: Consumer<AppStateNotifier>(
        builder: (context, appStateNotifier, child) {
          return FlutterMap(
            mapController: _animatedMapController.mapController,
            options: MapOptions(
                maxZoom: maxZoom,
                minZoom: minZoom,
                initialCenter: widget.initialCenter,
                initialZoom: 11.0,
                onTap: (position, location) {
                  // Outil de tracé réservé au mode expert : sinon chaque tap
                  // (notamment sur mobile) modifierait le chemin.
                  if (appStateNotifier.isExpertMode) {
                    appStateNotifier.addTrackPoint(location);
                  }
                },
                onMapReady: () {
                  _stepSubscription =
                      appStateNotifier.pathStepStream.listen((pathSteps) {
                    if (pathSteps.isNotEmpty) {
                      _animatedMapController.mapController
                          .move(pathSteps[0].position, pathSteps[0].zoom);
                    }
                  });
                }),
            children: [
              TileLayer(
                urlTemplate: TileProviderData.carteEtatMajor19Century,
                userAgentPackageName: AppData.appData,
                // Since flutter_map 8.2, obsolete tile requests are cancelled by the
                // default provider (the cancellable one is discontinued).
                tileProvider: NetworkTileProvider(),
              ),
              if (appStateNotifier.isShowing)
                OverlayImageLayer(overlayImages: [
                  ImageTile(
                      opacity: appStateNotifier.opacity,
                      imagePath: "assets/images/extrait.jpg")
                ]),
              if (appStateNotifier.showCommuneBoundaries)
                PolygonLayer(
                  polygons:
                      _buildCommunePolygons(appStateNotifier.communeBoundaries),
                  drawLabelsLast: true,
                ),
              if (appStateNotifier.showTrack &&
                  appStateNotifier.trackPoints.isNotEmpty)
                PolylineLayer(polylines: [
                  Polyline(
                    points: appStateNotifier.trackPoints,
                    strokeWidth: 4.0,
                    color: Colors.blue,
                  )
                ]),
              MarkerLayer(markers: [
                if (appStateNotifier.selectedSteps.isNotEmpty)
                  SatMarker(
                      onTap: () {},
                      position: appStateNotifier.selectedSteps[0].position,
                      label: appStateNotifier.selectedSteps[0].name,
                      withCarrosse: appStateNotifier.withCarrosse,
                      showNamePopup:
                          appStateNotifier.viewMode == ViewMode.sequence &&
                              !appStateNotifier.showAllMarkers),
                if (appStateNotifier.showAllMarkers)
                  for (var step in appStateNotifier.steps)
                    SatMarker(
                        position: step.position,
                        label: step.name,
                        onTap: () => appStateNotifier.selectStepId(step.id),
                        withCarrosse: appStateNotifier.withCarrosse,
                        width: 40,
                        height: 40),
                if (appStateNotifier.withPostHouses)
                  for (var marker in appStateNotifier.postHouses)
                    SatMarker(
                        position: marker,
                        label: "Relais de poste",
                        onTap: () {},
                        withCarrosse: true,
                        width: 40,
                        height: 40)
              ]),
              ZoomButtons(
                mapController: _animatedMapController.mapController,
                minZoom: minZoom,
                maxZoom: maxZoom,
                alignment: Alignment.topRight,
                padding: 8,
              ),
              // Collapsible: a one-line attribution overflows on narrow maps.
              RichAttributionWidget(
                attributions: [
                  const TextSourceAttribution("IGN – Carte de l'état-major"),
                  if (appStateNotifier.showCommuneBoundaries)
                    const TextSourceAttribution(
                        CommuneBoundaryData.attribution),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
