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
  FocusItemView({super.key, required this.focusItem, required this.focus});

  final FocusItem focusItem;
  final List<FocusItem> focus;

  static const EdgeInsets mainLeftPadding = EdgeInsets.only(left: 16);
  static const int MAX_WIDTH_FOR_ROW = 800;

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    print(
        "MediaQuery.of(context).size.width: ${MediaQuery.of(context).size.width}");
    return Scaffold(
      body: PageLayout(
          scrollController: _scrollController,
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
                                        text: "${author.normalizedName}",
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            context.go(
                                                AppRoutes.getAuthorItemRoute(
                                                    author));
                                            print(
                                                "Lien vers la page de l'auteur cliqué !");
                                            // Vous pouvez ajouter ici la navigation vers la page de l'auteur
                                            // par exemple, en utilisant Navigator.push()
                                          },
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline,
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
                    //if (MediaQuery.of(context).size.width > 800)
                    buildPart(context, part)
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     mainAxisSize: MainAxisSize.min,
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: [
                  //       ...buildPart(context, part),
                  //     ],
                  //   ),
                  // )
                  /*else
                  SizedBox(
                    height: 800,
                    child: Column(
                      children: [
                        ...buildPart(context, part),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          )),
    );
  }

  // It is inside a row
  Widget buildPart(BuildContext context, FocusItemPart part) {
    return switch (part.type) {
      PartType.subtitle => Row(
            key: part.key, // Assigner la clé au widget racine de cette partie
            children: [
              if (part.subtitle.isNotEmpty)
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16, top: 64, bottom: 16, right: 16),
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
                    ),
                  ),
                )
            ]),
      PartType.normalParagprah => Row(
            key: part.key,
            // Assigner la clé
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SelectableText.rich(
                      TextSpan(children: [TextSpan(text: part.text)]),
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
              )
            ]),
      PartType.paragraphWithLeftImage => KeyedSubtree(
          key: part.key,
          child: // Envelopper avec KeyedSubtree ou assigner directement si possible
              LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < MAX_WIDTH_FOR_ROW) {
              return Column(children: [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: MySatImage(
                    assetName: part.imagePath!,
                    legend: part.legend ?? "",
                    padding: EdgeInsets.all(16),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: SelectableText.rich(
                      TextSpan(children: [
                        TextSpan(
                          text: part.text,
                        )
                      ]),
                      textAlign: TextAlign.justify,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ))
              ]);
            }
            return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: MySatImage(
                      assetName: part.imagePath!,
                      legend: part.legend ?? "",
                    ),
                  ),
                  Expanded(
                      child: Padding(
                          padding: mainLeftPadding
                              .copyWith(right: 32)
                              .copyWith(top: 32, bottom: 32),
                          child: SelectableText.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: part.text,
                              )
                            ]),
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyLarge,
                          )))
                ]);
          }),
        ),
      PartType.paragraphWithRightImage => KeyedSubtree(
          key: part.key,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < MAX_WIDTH_FOR_ROW) {
              return Column(
                children: [
                  Padding(
                      padding: mainLeftPadding
                          .copyWith(right: 32)
                          .copyWith(top: 32, bottom: 32),
                      child: SelectableText.rich(
                        TextSpan(children: [
                          TextSpan(
                            text: part.text,
                          )
                        ]),
                        textAlign: TextAlign.justify,
                        style: Theme.of(context).textTheme.bodyLarge,
                      )),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: MySatImage(
                      assetName: part.imagePath!,
                      legend: part.legend ?? "",
                    ),
                  ),
                ],
              );
            }
            return Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: Padding(
                          padding: mainLeftPadding.copyWith(right: 32),
                          child: SelectableText.rich(
                            TextSpan(children: [
                              TextSpan(
                                text: part.text,
                              )
                            ]),
                            textAlign: TextAlign.justify,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ))),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: MySatImage(
                      assetName: part.imagePath!,
                      legend: part.legend ?? "",
                    ),
                  ),
                ]);
          }),
        ),
      PartType.onlyImage => Row(
            key: part.key,
            // Assigner la clé
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: MySatImage(
                    assetName: part.imagePath!,
                    legend: part.legend ?? "",
                  ),
                ),
              )
            ]),
      PartType.citation => Row(
            key: part.key,
            // Assigner la clé
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Padding(
                      padding: mainLeftPadding.copyWith(right: 16),
                      child: SelectableText.rich(
                          TextSpan(children: [
                            TextSpan(
                              text: part.text,
                            )
                          ]),
                          textAlign: TextAlign.justify,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontStyle: FontStyle.italic, fontSize: 32)))),
            ]),
      PartType.gallery => Row(
            key: part.key,
            // Assigner la clé
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 600,
                  padding: mainLeftPadding,
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
            ]),
      PartType.navigation => Row(
            key: part.key,
            // Assigner la clé (si la navigation elle-même doit être scrollable)
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
              focusItem.rank > 0
                  ? Expanded(
                      child: SelectableText(focus[focusItem.rank - 1].title))
                  : Spacer(),
              Spacer(),
              focusItem.rank < focus.length - 1
                  ? Expanded(
                      child: SelectableText(focus[focusItem.rank + 1].title))
                  : Spacer(),
              IconButton(
                padding: EdgeInsets.all(24),
                icon: Icon(Icons.arrow_forward),
                onPressed: focusItem.rank < focus.length - 1
                    ? () {
                        print("${focusItem.rank} -> ${focusItem.rank + 1}");
                        context.go(AppRoutes.getFocusItemRouteByRank(
                            focusItem.rank + 1));
                      }
                    : null,
              )
            ]),
      PartType.summary => Row(
            key: part.key,
            // Assigner la clé (si le sommaire lui-même doit être scrollable)
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center, // Centrer horizontalement
            children: [
              // Ajouter un SizedBox pour le décalage à gauche
              SizedBox(width: MediaQuery.of(context).size.width * 0.10),
              Padding(
                padding: EdgeInsets.only(left: 16.0), // Garder le padding original si nécessaire
                child: SelectableText.rich(
                  TextSpan(children: [
                    for (var item in focusItem.parts
                        .where((item) => item.subtitle.isNotEmpty))
                      TextSpan(
                          text: "${item.subtitle}\n",
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              goToPart(context, item);
                            },
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ))
                  ]),
                ),
              ),
              Spacer(), // Le Spacer remplira l'espace restant à droite
            ]),
      PartType.space => SizedBox(
          key: part.key, // Assigner la clé (si l'espace doit être scrollable)
          height: 16,
        )
    };
  }

  String getAuthorsHeadline() {
    return focusItem.author!.map((item) => item.normalizedName).join(", ");
  }

  void goToPart(BuildContext context, FocusItemPart item) {
    final BuildContext? targetContext = item.key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        // controller: _scrollController, // Use the controller owned by this widget
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        // alignment: alignment,
      );
    } else {
      print("Target context for scrolling not found in ParentScaffold.");
    }
  }
}
