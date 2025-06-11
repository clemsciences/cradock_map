import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/routes/routes.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "sat_list_tile.dart";

class FocusItemTile extends StatelessWidget {
  final FocusItem item;

  const FocusItemTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return SatTile(
      title: item.title,
      subtitle: item.parts
          .map((i) => i.subtitle)
          .where((item) => item.isNotEmpty)
          .join(", "),
      onTap: () {
        context.go(AppRoutes.getFocusItemRoute(item));
      });
  }
}
