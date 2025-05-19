import 'package:cradock_map/models/view_mode.dart';
import 'package:cradock_map/notifiers/multi_notifier.dart';
import 'package:cradock_map/notifiers/app_state_notifier.dart';
import 'package:cradock_map/style/style.dart';
import 'package:cradock_map/ui/buttons/marker_switch.dart';
import 'package:cradock_map/ui/buttons/opacity_slider.dart';
import 'package:cradock_map/ui/buttons/show_all_markers_switch.dart';
import 'package:cradock_map/ui/buttons/web/print_map_button.dart';
import 'package:cradock_map/ui/buttons/switch_button.dart';
import 'package:cradock_map/ui/buttons/view_mode_switch.dart';
import 'package:cradock_map/ui/map.dart';
import 'package:cradock_map/ui/step/step_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/buttons/post_house_switch.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Le voyage de Mme Cradock en Touraine",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: SatStyle.lightBlueColor),
        useMaterial3: true,
      ),
      home: const MultiNotifier(
        child: MyHomePage(
          title: "Le parcours des Cradock",
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Consumer<AppStateNotifier>(builder: (context, multiNotifier, _) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            const ViewModeRadioButton(),
            switch (multiNotifier.viewMode) {
              ViewMode.balade => Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
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
                          Container(
                            height: 50,
                            width: 200,
                            child: const ShowAllMarkersSwitch(
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
                          Container(
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
                              Container(
                                height: 100,
                                width: 200,
                                child: const ShowAllMarkersSwitch(
                                  legend: "Montrer tous les marqueurs",
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 200,
                                child: const PostHouseSwitch(
                                  legend: "Montrer tous les relais de poste",
                                ),
                              ),

                              ElevatedButton(
                                  onPressed: () {
                                    multiNotifier.flushTrackPoints();
                                  },
                                  child: const Text("Tout enlever")),
                              ElevatedButton(
                                  onPressed: () {
                                    multiNotifier.removeLastTrackPoint();
                                  },
                                  child: const Text("Annuler"))
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
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
        )),
      );
    });
  }
}
