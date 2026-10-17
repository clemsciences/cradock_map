import "package:cradock_map/models/view_mode.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class ViewModeRadioButton extends StatelessWidget {
  const ViewModeRadioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, multiNotifier, _) {
      if (!multiNotifier.isExpertMode) {
        return const SizedBox.shrink();
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SegmentedButton<ViewMode>(
          segments: const <ButtonSegment<ViewMode>>[
            ButtonSegment<ViewMode>(
              value: ViewMode.balade,
              label: Text("Balade"),
              icon: Icon(Icons.map),
            ),
            ButtonSegment<ViewMode>(
              value: ViewMode.sequence,
              label: Text("Séquence"),
              icon: Icon(Icons.route),
            ),
          ],
          selected: <ViewMode>{multiNotifier.viewMode},
          onSelectionChanged: (Set<ViewMode> newSelection) {
            multiNotifier.updateViewMode(newSelection.first);
          },
        ),
      );
    });
  }
}
