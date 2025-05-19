import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class ImageTile extends OverlayImage {


  final String imagePath;
  @override
  final double opacity;


  ImageTile({super.key, required this.imagePath, required this.opacity})
      : super(
            opacity: opacity,
            bounds: LatLngBounds(const LatLng(47.286173, 0.378891), const LatLng(47.429017, 0.722311)),
            imageProvider: AssetImage(imagePath));
}
