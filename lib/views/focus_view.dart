

import "package:cradock_map/data/focus.dart";
import "package:cradock_map/ui/tiles/focus_item_tile.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(child: Column(
        children: [
          NavBar(),
          SelectableText("Points abordés lors du Goûter de nos trésors", style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: 12,),
          for(var focus in focusData)
            FocusItemTile(item: focus)

        ],
      )),
    );
  }
}
