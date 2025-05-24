
import "package:cradock_map/ui/nav_bar.dart";
import "package:flutter/material.dart";

import "map_view.dart";

class BaladeView extends StatelessWidget {
  const BaladeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MapView(title: "Cradock - balade",);
  }
}
