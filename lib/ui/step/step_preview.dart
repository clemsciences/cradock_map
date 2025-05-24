import "package:cradock_map/models/path_step.dart";
import "package:flutter/material.dart";

class StepPreview extends StatelessWidget {
  final PathStep step;

  const StepPreview({super.key, required this.step});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: Text(step.name),
    );
  }
}
