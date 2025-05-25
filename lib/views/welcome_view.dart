import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        child: Column(
          children: [
            NavBar(),
            Image.asset(
              "assets/icons/SAT-couleur-1000.png",
              height: 300,
            ),
            SizedBox(
              height: 80,
            ),
            SelectableText(
              "Bienvenue sur le site de Mme Cradock en Touraine",
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
