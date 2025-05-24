import "package:flutter/material.dart";

class DiskWidget extends StatelessWidget {
  final double radius;
  final int alpha;
  final Color color;

  DiskWidget({required this.radius, required this.alpha, required this.color});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiskPainter(radius: radius, alpha: alpha, color: color),
      size: Size(radius * 2, radius * 2),
    );
  }
}

class DiskPainter extends CustomPainter {
  final double radius;
  final int alpha;
  final Color color;

  DiskPainter({required this.radius, required this.alpha, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final innerPaint = Paint()
      ..color = color.withAlpha(alpha)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(radius, radius), radius, innerPaint);

    final edgePain = Paint()
      ..color = color.withAlpha(alpha)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(Offset(radius, radius), radius, edgePain);
  }

  @override
  bool shouldRepaint(DiskPainter oldDelegate) {
    return oldDelegate.radius != radius || oldDelegate.alpha != alpha;
  }
}
