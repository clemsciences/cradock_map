import "package:cradock_map/notifiers/app_state_notifier.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";

class GeneralView extends StatelessWidget {
  const GeneralView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateNotifier>(builder: (context, multiNotifier, _) {
      return Scaffold(
        body: PageLayout(
          child: Column(
            children: [
              const NavBar(),
              const SizedBox(height: 20),
              SelectableText(
                "Options Générales",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Mode Expert : "),
                  Switch(
                    value: multiNotifier.isExpertMode,
                    onChanged: (value) {
                      multiNotifier.switchExpertMode();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Le mode expert active des contrôles avancés sur la carte (impression, réglage de transparence, outils de tracé).",
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    });
  }
}
