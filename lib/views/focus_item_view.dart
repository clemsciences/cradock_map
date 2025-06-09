import "dart:math";

import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/images/sat_gallery.dart";
import "package:cradock_map/ui/images/sat_image.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FocusItemView extends StatelessWidget {
  const FocusItemView(
      {super.key, required this.focusItem, required this.focus});

  final FocusItem focusItem;
  final List<FocusItem> focus;

  @override
  Widget build(BuildContext context) {
    print(
        "MediaQuery.of(context).size.width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      body: PageLayout(
          child: Center(
        child: SizedBox(
          width: min(MediaQuery.of(context).size.width, 1300),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              NavBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SelectableText(
                    focusItem.title,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ],
              ),
              if (focusItem.author != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(12.0),
                      child: SelectableText.rich(
                        TextSpan(
                            children: [
                              TextSpan(text: "par "),
                              for (var author in focusItem.author!)
                                TextSpan(
                                    text: "#${author.normalizedName}",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        context.go(AppRoutes.getAuthorItemRoute(
                                            author));
                                        print(
                                            "Lien vers la page de l'auteur cliqué !");
                                        // Vous pouvez ajouter ici la navigation vers la page de l'auteur
                                        // par exemple, en utilisant Navigator.push()
                                      },
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue))
                            ],
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(fontStyle: FontStyle.italic)),
                      ),
                    ),
                  ],
                ),
              for (var part in focusItem.parts)
                if (MediaQuery.of(context).size.width > 800)
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ...buildPart(context, part),
                      ],
                    ),
                  )
                else
                  SizedBox(
                    height: 800,
                    child: Column(
                      children: [
                        ...buildPart(context, part),
                      ],
                    ),
                  ),
            ],
          ),
        ),
      )),
    );
  }

  // It is inside a row
  List<Widget> buildPart(BuildContext context, FocusItemPart part) {
    return switch (part.type) {
      PartType.subtitle => [
          if (part.subtitle.isNotEmpty)
            Expanded(
                child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SelectableText.rich(
                  TextSpan(children: [TextSpan(text: part.subtitle)]),
                  style: Theme.of(context).textTheme.headlineMedium,
                )
              ],
            ))
        ],
      PartType.normalParagprah => [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: SelectableText.rich(
                  TextSpan(children: [TextSpan(text: part.text)]),
                  textAlign: TextAlign.justify,
                  style: Theme.of(context).textTheme.bodyLarge),
            ),
          )
        ],
      PartType.paragraphWithLeftImage => [
          Expanded(
            child: Padding(
              padding:  EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  MySatImage(
                    assetName: part.imagePath!,
                    legend: part.legend ?? "",
                  ),
                  Expanded(
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: SelectableText.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: part.text,
                              )
                            ]),
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )))
                ],
              ),
            ),
          ),
        ],
      PartType.paragraphWithRightImage => [
          Expanded(
              child: Padding(
                  padding:  EdgeInsets.only(left: 8),
                  child: SelectableText.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: part.text,
                      )
                    ]),
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ))),
          MySatImage(
            assetName: part.imagePath!,
            legend: part.legend ?? "",
          ),
        ],
      PartType.onlyImage => [
          MySatImage(
            padding:  EdgeInsets.only(left: 8),
            assetName: part.imagePath!,
            legend: part.legend ?? "",
          )
        ],
      PartType.citation => [
          Expanded(
              child: Padding(
                  padding:  EdgeInsets.only(left: 8),
                  child: SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: part.text,
                        )
                      ]),
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge))),
        ],
      PartType.gallery => [
          Expanded(
            child: Container(
              height: 600,
              padding:  EdgeInsets.only(left: 8),
              child: SatGallery(
                assetNames: part.gallery!,
                legend: part.legend,
              ),
            ),
          ),
          // Stack(children: [
          //   Align(
          //       alignment: Alignment.center,
          //       child: ),
          //   if (part.legend != null)
          //     Align(
          //       alignment: Alignment.bottomCenter,
          //       child: Container(
          //           padding: EdgeInsets.all(8.0),
          //           decoration: BoxDecoration(
          //             color: SatStyle.lightBlueColor.withOpacity(0.9),
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           child: SelectableText(part.legend!,
          //               style: Theme.of(context)
          //                   .textTheme
          //                   .labelMedium
          //                   ?.copyWith(color: Colors.white))),
          //     )
          // ]),

          // Column(children: [
          //   for(var imagePath in part.gallery!)
          //     SatImage(assetName: imagePath)
          // ],)
        ],
      PartType.navigation => [
          IconButton(
              padding: EdgeInsets.all(24),
              icon: Icon(Icons.arrow_back),
              onPressed: focusItem.rank > 0
                  ? () {
                      print("${focusItem.rank} -> ${focusItem.rank - 1}");
                      context.go(AppRoutes.getFocusItemRouteByRank(
                          focusItem.rank - 1));
                    }
                  : null),
          Spacer(),
          IconButton(
            padding: EdgeInsets.all(24),
            icon: Icon(Icons.arrow_forward),
            onPressed: focusItem.rank < focus.length - 1
                ? () {
                    print("${focusItem.rank} -> ${focusItem.rank + 1}");
                    context.go(
                        AppRoutes.getFocusItemRouteByRank(focusItem.rank + 1));
                  }
                : null,
          )
        ],
      PartType.summary => [
        Align(
          alignment: Alignment.topLeft,
          child: SelectableText.rich(TextSpan(
            children: [
              for(var item in focusItem.parts.where((item) => item.subtitle.isNotEmpty))
                TextSpan(
                  text: "${item.subtitle}\n",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                    goToPart(context, item);
                    },
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ))
            ]
          )),
        )
      ]
    };
  }

  String getAuthorsHeadline() {
    return focusItem.author!.map((item) => item.normalizedName).join(", ");
  }

  void goToPart(BuildContext context, FocusItemPart item) {

  }
}
