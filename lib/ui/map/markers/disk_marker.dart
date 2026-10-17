import "package:cradock_map/ui/map/markers/disk_painter.dart";
import "package:flutter/material.dart";

class DiskWidget extends StatelessWidget {
  final double radius;
  final int alpha;
  final Color color;

  const DiskWidget({super.key, required this.radius, required this.alpha, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiskPainter(radius: radius, alpha: alpha, color: color),
      size: Size(radius * 2, radius * 2),
    );
  }
}
