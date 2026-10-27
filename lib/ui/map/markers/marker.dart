import "package:cradock_map/data/image_previews.dart";
import "package:cradock_map/style/style.dart";
import "package:cradock_map/ui/map/markers/disk_marker.dart";
import "package:flutter/material.dart";
import "package:flutter_map/flutter_map.dart";
import "package:latlong2/latlong.dart";

class SatMarker extends Marker {
  final Function? onTap;
  final LatLng position;
  final bool withCarrosse;
  final String? label;
  final bool showNamePopup;
  @override
  final double height;
  @override
  final double width;

  SatMarker({
    required this.position,
    required this.onTap,
    required this.withCarrosse,
    this.label,
    this.showNamePopup = false,
    this.height = 80,
    this.width = 80,
  }) : super(
          // alignment: Alignment.topCenter,
          point: position,
          height: height,
          rotate: false,
          child: Tooltip(
            message: label ?? "",
            child: GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
              },
              child: SizedBox(
                height: height,
                width: width,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // The visual marker (carriage or pin)
                    Align(
                      alignment: Alignment.center,
                      child: withCarrosse
                          ? Stack(
                              children: [
                                DiskWidget(
                                  alpha: 200,
                                  radius: height / 2,
                                  color: Colors.white,
                                ),
                                Image.asset(
                                  ImagePreviews.pathOf(
                                      "assets/images/carrosse.png"),
                                  height: height,
                                  semanticLabel: "Carrosse de Mme Cradock",
                                ),
                              ],
                            )
                          : Icon(
                              Icons.location_pin,
                              size: height,
                              color: SatStyle.redColor,
                            ),
                    ),
                    if (showNamePopup && (label?.isNotEmpty ?? false))
                      Positioned(
                        top: -8,
                        right: -8,
                        child: Semantics(
                          label: label,
                          child: Container(
                            key: ValueKey('sat_marker_popup_${label}'),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x33000000),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                )
                              ],
                              border: Border.all(
                                color: Colors.black12,
                              ),
                            ),
                            child: Text(
                              label!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
}
