import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ShowAllMarkersSwitch extends StatelessWidget {
  const ShowAllMarkersSwitch({super.key, required this.legend});

  final String legend;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, state, child) {
      return SwitchListTile(
          title: Text(legend),
          value: state.showAllMarkers,
          onChanged: (isChecked) {
            state.switchShowAllMarkers();
          });
    });
  }
}
