


import "package:cradock_map/models/view_mode.dart";
import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/buttons/opacity_slider.dart";
import "package:cradock_map/ui/buttons/post_house_switch.dart";
import "package:cradock_map/ui/buttons/show_all_markers_switch.dart";
import "package:cradock_map/ui/buttons/switch_button.dart";
import "package:cradock_map/ui/buttons/view_mode_switch.dart";
import "package:cradock_map/ui/buttons/web/print_map_button.dart";
import "package:cradock_map/ui/map/map.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

import "../ui/step/step_tile.dart";

class MapView extends StatefulWidget {
  const MapView({super.key, required this.title});

  final String title;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AppStateNotifier>(builder: (context, multiNotifier, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: SelectableText(widget.title),
        ),
        body: PageLayout(
          child: Column(
            children: [
              NavBar(),
              const ViewModeRadioButton(),
              switch (multiNotifier.viewMode) {
                ViewMode.balade => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                          height: 800,
                          width: 1000,
                          child: TouraineMap(
                            mapKey: multiNotifier.mapKey,
                            initialCenter: multiNotifier.initialCenter,
                          )),
                      Row(
                        children: [
                          const ShowOverlayButton(),
                          const OpacitySlider(),
                          PrintMapButton(
                            mapKey: multiNotifier.mapKey,
                          ),
                          const SizedBox(
                            height: 50,
                            width: 200,
                            child: ShowAllMarkersSwitch(
                              legend: "Montrer tous les marqueurs",
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                ViewMode.sequence => Row(
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(
                              height: size.height * 0.7,
                              width: size.width * 0.5,
                              child: TouraineMap(
                                mapKey: multiNotifier.mapKey,
                                initialCenter: multiNotifier.initialCenter,
                              )),
                          Row(
                            children: [
                              // const ShowOverlayButton(),
                              const OpacitySlider(),
                              PrintMapButton(
                                mapKey: multiNotifier.mapKey,
                              ),
                              // Container(
                              //     // width: size.width * 0.5,
                              //     // height: size.height * 0.5,
                              //   height: 100,
                              //     width: 200,
                              //     child: const MarkerSwitch(
                              //       legend: "Marqueur",
                              //     )),
                              const SizedBox(
                                height: 100,
                                width: 200,
                                child: ShowAllMarkersSwitch(
                                  legend: "Montrer tous les marqueurs",
                                ),
                              ),
                              const SizedBox(
                                height: 100,
                                width: 200,
                                child: PostHouseSwitch(
                                  legend: "Montrer tous les relais de poste",
                                ),
                              ),

                              ElevatedButton(
                                  onPressed: () {
                                    multiNotifier.flushTrackPoints();
                                  },
                                  child: const SelectableText("Tout enlever")),
                              ElevatedButton(
                                  onPressed: () {
                                    multiNotifier.removeLastTrackPoint();
                                  },
                                  child: const SelectableText("Annuler"))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                            height: size.height * 0.7,
                            child: ListView.builder(
                                itemExtent: 60,
                                itemCount: multiNotifier.steps.length,
                                itemBuilder: (context, index) => StepTile(
                                    selectedStepId:
                                    multiNotifier.selectedStepId,
                                    step: multiNotifier.steps[index]))))
                  ],
                ),
              }
            ],
          ),
        ),
      );
    });
  }
}
