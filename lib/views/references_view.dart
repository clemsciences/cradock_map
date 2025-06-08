import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";

class ReferencesView extends StatelessWidget {
  const ReferencesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(
        child: Column(
          children: [
            NavBar(),
          ],
        ),
      ),
    );
  }
}
