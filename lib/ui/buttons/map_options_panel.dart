import "package:cradock_map/models/view_mode.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/commune_boundaries_switch.dart";
import "package:cradock_map/ui/buttons/opacity_slider.dart";
import "package:cradock_map/ui/buttons/post_house_switch.dart";
import "package:cradock_map/ui/buttons/print_map_button.dart";
import "package:cradock_map/ui/buttons/print_map_button/print_map_button.dart";
import "package:cradock_map/ui/buttons/show_all_markers_switch.dart";
import "package:cradock_map/ui/buttons/show_track_switch.dart";
import "package:cradock_map/ui/buttons/switch_button.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

/// Map display options, shown under the map on wide screens and in a bottom
/// sheet on narrow ones.
class MapOptionsPanel extends StatelessWidget {
  const MapOptionsPanel({super.key});

  static const double switchWidth = 260;

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, notifier, _) {
      final isBalade = notifier.viewMode == ViewMode.balade;
      return Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8,
        runSpacing: 8,
        children: [
          if (isBalade) const ShowOverlayButton(),
          if (notifier.isExpertMode) const OpacitySlider(),
          if (notifier.isExpertMode)
            PrintMapButton(
              mapKey: notifier.mapKey,
              opener: MyOpener(),
            ),
          const SizedBox(
            width: switchWidth,
            child: ShowAllMarkersSwitch(
              legend: "Montrer tous les marqueurs",
            ),
          ),
          const SizedBox(
            width: switchWidth,
            child: ShowTrackSwitch(
              legend: "Montrer le chemin",
            ),
          ),
          if (!isBalade)
            const SizedBox(
              width: switchWidth,
              child: PostHouseSwitch(
                legend: "Montrer tous les relais de poste",
              ),
            ),
          if (!isBalade)
            const SizedBox(
              width: switchWidth,
              child: CommuneBoundariesSwitch(
                legend: "Montrer les limites des communes actuelles",
              ),
            ),
          if (!isBalade && notifier.isExpertMode)
            ElevatedButton(
                onPressed: notifier.flushTrackPoints,
                child: const Text("Tout enlever")),
          if (!isBalade && notifier.isExpertMode)
            ElevatedButton(
                onPressed: notifier.removeLastTrackPoint,
                child: const Text("Annuler")),
        ],
      );
    });
  }
}
