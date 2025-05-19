import 'dart:async';
import 'dart:ui';

import 'package:cradock_map/data/app_data.dart';
import 'package:cradock_map/data/tile_provider_data.dart';
import 'package:cradock_map/managers/web_manager.dart';
import 'package:cradock_map/models/view_mode.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/ui/buttons/zoom_buttons.dart';
import 'package:cradock_map/ui/image_tile.dart';
import 'package:cradock_map/ui/marker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class TouraineMap extends StatefulWidget {
  final GlobalKey mapKey;
  final LatLng initialCenter;

  TouraineMap({super.key, required this.mapKey, required this.initialCenter});

  @override
  State<TouraineMap> createState() => _TouraineMapState();
}

class _TouraineMapState extends State<TouraineMap>
    with TickerProviderStateMixin {
  late AnimatedMapController _animatedMapController =
      AnimatedMapController(vsync: this);

  // final _waitingForAnimation = Completer<bool>();

  @override
  void initState() {
    super.initState();
    _animatedMapController = AnimatedMapController(vsync: this);

    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (context.mounted) {
    //     context.read<AppStateNotifier>().setAnimatedMapController(
    //         _animatedMapController);
    //     _waitingForAnimation.complete(true);
    //   }
    // });
  }

  @override
  void dispose() {
    // _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Carte d'état-major"),
      ),
      body: RepaintBoundary(
          key: widget.mapKey,
          child: /*FutureBuilder<bool>(
          future: _waitingForAnimation.future,
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return*/
              Consumer<AppStateNotifier>(
            builder: (context, appStateNotifier, child) {
              return FlutterMap(
                mapController: _animatedMapController.mapController,
                options: MapOptions(
                    maxZoom: 25,
                    minZoom: 6,
                    initialCenter: widget.initialCenter,
                    initialZoom: 11.0,
                    onMapEvent: (MapEvent event) {
                      print(event.source);
                      print(event.camera);
                      // switch (event.source) {
                      //   case MapEventSource.mapController:
                      //     print("MapEventSource.mapController");
                      //     break;
                      //   case MapEventSource.tap:
                      //     break;
                      //   case MapEventSource.secondaryTap:
                      //     break;
                      //   case MapEventSource.longPress:
                      //     break;
                      //   case MapEventSource.doubleTap:
                      //     break;
                      //   case MapEventSource.doubleTapHold:
                      //     break;
                      //   case MapEventSource.dragStart:
                      //     break;
                      //   case MapEventSource.onDrag:
                      //     break;
                      //   case MapEventSource.dragEnd:
                      //     break;
                      //   case MapEventSource.multiFingerGestureStart:
                      //     break;
                      //   case MapEventSource.onMultiFinger:
                      //     break;
                      //   case MapEventSource.multiFingerEnd:
                      //     break;
                      //   case MapEventSource.flingAnimationController:
                      //     break;
                      //   case MapEventSource.doubleTapZoomAnimationController:
                      //     break;
                      //   case MapEventSource.interactiveFlagsChanged:
                      //     break;
                      //   case MapEventSource.fitCamera:
                      //     break;
                      //   case MapEventSource.custom:
                      //     break;
                      //   case MapEventSource.scrollWheel:
                      //     break;
                      //   case MapEventSource.nonRotatedSizeChange:
                      //     break;
                      //   case MapEventSource.cursorKeyboardRotation:
                      //     break;
                      //   case MapEventSource.keyboard:
                      //     break;
                      // }
                      print("zoom: ${event.camera.zoom}");
                    },
                    onTap: (position, location) {
                      //print(position);
                      //print(location);
                      appStateNotifier.addTrackPoint(location);
                      print(appStateNotifier.trackPoints.length);
                    },
                    onPositionChanged: (camera, changed) {},
                    onMapReady: () {
                      print("ready");
                      print(
                          "appStateNotifier.selectedSteps: ${appStateNotifier.selectedSteps}");
                      appStateNotifier.pathStepStream.listen((pathSteps) {
                        if (pathSteps.isNotEmpty) {
                          print("step selected");
                          _animatedMapController.mapController.fitCamera(
                              CameraFit.coordinates(
                                  coordinates: [pathSteps[0].position]));
                          _animatedMapController.mapController
                              .move(pathSteps[0].position, pathSteps[0].zoom);
                          //mapController.fitCamera(CameraFit.bounds(
                          //    bounds: LatLngBounds(LatLng(47.3, 0.40), LatLng(47.5, 0.42)), maxZoom: 20, minZoom: 13)
                          //);
                        }
                      });
                    }
                    // interactionOptions: InteractionOptions()
                    ),
                children: [
                  TileLayer(
                    urlTemplate: TileProviderData.carteEtatMajor19Century,
                    userAgentPackageName: AppData.appData,
                    tileProvider: CancellableNetworkTileProvider(),
                  ),
                  if (appStateNotifier.isShowing)
                    OverlayImageLayer(overlayImages: [
                      ImageTile(
                          opacity: appStateNotifier.opacity,
                          imagePath: "assets/images/extrait.jpg")
                    ]),
                  if (appStateNotifier.trackPoints.isNotEmpty)
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
                          withCarrosse: appStateNotifier.withCarrosse),
                    if (appStateNotifier.showAllMarkers /*&&
                        appStateNotifier.viewMode == ViewMode.balade*/)
                      for (var marker in appStateNotifier.steps)
                        SatMarker(
                            position: marker.position,
                            onTap: () {},
                            withCarrosse: appStateNotifier.withCarrosse,
                            width: 40,
                            height: 40),
                    if(appStateNotifier.withPostHouses)
                      for(var marker in appStateNotifier.postHouses)
                        SatMarker(position: marker, onTap: () {}, withCarrosse: true, width: 40, height: 40)
                  ]),
                  RichAttributionWidget(
                    // Include a stylish prebuilt attribution widget that meets all requirments
                    attributions: [
                      TextSourceAttribution(
                        'OpenStreetMap contributors',
                        onTap: () => WebManager.launchUrl(Uri.parse(
                            'https://openstreetmap.org/copyright')), // (external)
                      ),
                      // Also add images...
                    ],
                  ),
                  // ZoomButtons(
                  //   mapController: _animatedMapController.mapController,
                  //   alignment: Alignment.bottomRight,
                  //   padding: 30,
                  // )
                ],
              );
            },
          ) /*;
            }
            // Future.microtask(() {
            //   if(context.mounted) {
            //     context.read<AppStateNotifier>().setAnimatedMapController(
            //         _animatedMapController);
            //     _waitingForAnimation.complete(true);
            //   }
            // });
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),*/
          ),
    );
  }
}
