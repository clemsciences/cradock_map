import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OpacitySlider extends StatelessWidget {
  const OpacitySlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(
      builder: (context, notifier, child) => Slider(
        min: 0,
        max: 1,
        divisions: 10,
        value: notifier.opacity,
        onChanged: (double value) {
          notifier.updateOpacity(value);
        },
      ),
    );
  }
}
