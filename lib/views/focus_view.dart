import "package:cradock_map/data/focus.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:cradock_map/ui/tiles/focus_item_tile.dart";
import "package:flutter/material.dart";

class FocusView extends StatelessWidget {
  const FocusView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(child: LayoutBuilder(
        builder: (context, constraints) {
          var size = MediaQuery.of(context).size;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(),
              Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: SelectableText(
                  "Points abordés lors du Goûter de nos trésors",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              for (var focus in focusData)
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                    child: FocusItemTile(item: focus))
            ],
          );
        },
      )),
    );
  }
}
