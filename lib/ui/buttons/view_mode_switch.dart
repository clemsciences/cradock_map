import 'package:cradock_map/models/view_mode.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewModeRadioButton extends StatelessWidget {
  const ViewModeRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, multiNotifier, _) {
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: RadioListTile<ViewMode>(
              title: const Text("Mode balade"),
                value: ViewMode.balade,
                groupValue: multiNotifier.viewMode,
                onChanged: (newValue) {
                  multiNotifier.updateViewMode(newValue!);
                }),
          ),
          Flexible(
            flex: 1,
            child: RadioListTile<ViewMode>(
              title: const Text("Mode séquence"),
                value: ViewMode.sequence,
                groupValue: multiNotifier.viewMode,
                onChanged: (newValue) {
                  multiNotifier.updateViewMode(newValue!);
                }),
          ),

        ],
      );
    });
  }
}
