

import "package:cradock_map/routes/routes.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    /*return NavigationBar(destinations: [
      NavigationDestination(icon: icon, label: label)
    ]);*/
    return LayoutBuilder(builder: (context, constraints) {
      if(constraints.maxWidth > 300) {
        return Row(
          children: [
            TextButton(onPressed: () {
              context.go(AppRoutes.WELCOME_ROUTE);
            }, child: Text("Accueil")),
            //TextButton(onPressed: () {
            //  context.go(AppRoutes.BALADE_ROUTE);
            //}, child: Text("Balade")),
            TextButton(onPressed: () {
              context.go(AppRoutes.SEQUENCE_ROUTE);
            }, child: Text("Séquence")),
            TextButton(onPressed: () {
              context.go(AppRoutes.FOCUS_ROUTE);
            }, child: Text("Focus")),
            TextButton(onPressed: () {
              context.go(AppRoutes.REFERENCES_ROUTE);
            }, child: Text("Référence")),
          ],
        );
      } else {
        return Column(
          children: [
            TextButton(onPressed: () {
              context.go(AppRoutes.WELCOME_ROUTE);
            }, child: Text("Accueil")),
            //TextButton(onPressed: () {
            //  context.go(AppRoutes.BALADE_ROUTE);
            //}, child: Text("Balade")),
            TextButton(onPressed: () {
              context.go(AppRoutes.SEQUENCE_ROUTE);
            }, child: Text("Séquence")),
            TextButton(onPressed: () {
              context.go(AppRoutes.FOCUS_ROUTE);
            }, child: Text("Focus")),
            TextButton(onPressed: () {
              context.go(AppRoutes.REFERENCES_ROUTE);
            }, child: Text("Référence")),
          ],
        );
      }

    });
  }
}
