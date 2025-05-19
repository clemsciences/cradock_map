import 'package:cradock_map/style/style.dart';
import 'package:cradock_map/ui/markers/disk_marker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SatMarker extends Marker {
  final Function? onTap;
  final LatLng position;
  final bool withCarrosse;
  final double height;
  final double width;

  SatMarker(
      {required this.position,
      required this.onTap,
      required this.withCarrosse,
      this.height = 80,
      this.width = 80})
      : super(
            // alignment: Alignment.topCenter,
            point: position,
            height: height,
            rotate: false,
            child: GestureDetector(
              onTap: () {
                if (onTap != null) {
                  onTap();
                }
              },
              child: Container(
                height: height,
                child: withCarrosse
                    ? Stack(
                        children: [
                          DiskWidget(alpha: 200, radius: height/2, color: Colors.white,),
                          // DiskWidget(alpha: 200, radius: 5, color: Colors.red,),
                          Image.asset(
                            "assets/images/carrosse.png",
                            height: height,
                          ),
                        ],
                      )
                    : Icon(
                        Icons.location_pin,
                        size: height,
                        color: SatStyle.redColor,
                      ),
              ),
            ));
}
