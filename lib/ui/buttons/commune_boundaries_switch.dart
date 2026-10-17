import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class CommuneBoundariesSwitch extends StatelessWidget {
  const CommuneBoundariesSwitch({super.key, required this.legend});

  final String legend;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, state, child) {
      return SwitchListTile(
          title: Text(legend),
          // The data is usually preloaded; if not, show that it is coming.
          secondary: state.isLoadingCommuneBoundaries
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : null,
          value: state.showCommuneBoundaries,
          onChanged: (isChecked) {
            state.switchCommuneBoundaries();
          });
    });
  }
}
