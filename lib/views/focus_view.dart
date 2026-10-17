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
      body: PageLayout(child: Builder(
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NavBar(),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SelectableText(
                    "Points abordés lors du Goûter de nos trésors",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              // Centered column of bounded width rather than a 20% margin on
              // each side, which left almost no room on phones.
              for (var focus in focusData)
                Center(
                  child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: FocusItemTile(item: focus)),
                )
            ],
          );
        },
      )),
    );
  }
}
