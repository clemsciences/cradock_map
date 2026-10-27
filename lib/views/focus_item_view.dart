import "dart:math";

import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/images/my_sat_image.dart";
import "package:cradock_map/ui/images/sat_gallery.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:cradock_map/ui/texts/text_link.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class FocusItemView extends StatelessWidget {
  FocusItemView({super.key, required this.focusItem, required this.focus});

  final FocusItem focusItem;
  final List<FocusItem> focus;

  static const EdgeInsets mainLeftPadding = EdgeInsets.only(left: 16);
  static const int MAX_WIDTH_FOR_ROW = 800;
  static const double MAX_PAGE_WIDTH = 1300;
  static const double COMPACT_WIDTH = 600;
  static const double MAX_GALLERY_HEIGHT = 600;

  final ScrollController _scrollController =
      ScrollController(initialScrollOffset: 0);

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < COMPACT_WIDTH;

  /// Justified text leaves large gaps on a narrow column.
  static TextAlign bodyTextAlign(BuildContext context) =>
      isCompact(context) ? TextAlign.start : TextAlign.justify;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    // Title of the browser tab (and of the page seen by search engines).
    return Title(
        title: "${focusItem.title} – Le voyage de Mme Cradock en Touraine",
        color: Theme.of(context).colorScheme.primary,
        child: Scaffold(
          body: PageLayout(
              scrollController: _scrollController,
              child: Center(
                child: SizedBox(
                  width: min(width, MAX_PAGE_WIDTH),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const NavBar(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Semantics(
                          header: true,
                          child: SelectableText(
                            focusItem.title,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                      ),
                      if (focusItem.author != null)
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Builder(builder: (context) {
                              final style = Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(fontStyle: FontStyle.italic);
                              final authors = focusItem.author!;
                              return Wrap(
                                alignment: WrapAlignment.end,
                                crossAxisAlignment: WrapCrossAlignment.center,
                                children: [
                                  Text("par ", style: style),
                                  for (var (index, author)
                                      in authors.indexed) ...[
                                    if (index > 0)
                                      Text(
                                          index == authors.length - 1
                                              ? " et "
                                              : ", ",
                                          style: style),
                                    TextLink(
                                        text: author.normalizedName,
                                        style: style,
                                        onPressed: () => context.go(
                                            AppRoutes.getAuthorItemRoute(
                                                author))),
                                  ],
                                ],
                              );
                            }),
                          ),
                        ),
                      for (var part in focusItem.parts) buildPart(context, part)
                    ],
                  ),
                ),
              )),
        ));
  }

  Widget _bodyText(BuildContext context, String text) {
    return SelectableText.rich(
      TextSpan(children: [TextSpan(text: text)]),
      textAlign: bodyTextAlign(context),
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }

  Widget buildPart(BuildContext context, FocusItemPart part) {
    final compact = isCompact(context);
    return switch (part.type) {
      PartType.subtitle => KeyedSubtree(
          key: part.key,
          child: part.subtitle.isEmpty
              ? const SizedBox.shrink()
              : Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        top: compact ? 32 : 64,
                        bottom: 16,
                        right: 16),
                    child: Semantics(
                      header: true,
                      child: SelectableText(
                        part.subtitle,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
        ),
      PartType.normalParagprah => Padding(
          key: part.key,
          padding: const EdgeInsets.all(16.0),
          child: _bodyText(context, part.text),
        ),
      PartType.paragraphWithLeftImage => KeyedSubtree(
          key: part.key,
          child: LayoutBuilder(builder: (context, constraints) {
            if (constraints.maxWidth < MAX_WIDTH_FOR_ROW) {
              return Column(children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: MySatImage(
                    assetName: part.imagePath!,
                    legend: part.legend ?? "",
                    padding: const EdgeInsets.all(16),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: compact ? 16.0 : 32.0),
                    child: _bodyText(context, part.text))
              ]);
            }
            return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                          child: _bodyText(context, part.text)))
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
                          .copyWith(right: compact ? 16 : 32)
                          .copyWith(top: 32, bottom: 32),
                      child: _bodyText(context, part.text)),
                  Padding(
                    padding: const EdgeInsets.all(16),
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
                          child: _bodyText(context, part.text))),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: MySatImage(
                      assetName: part.imagePath!,
                      legend: part.legend ?? "",
                    ),
                  ),
                ]);
          }),
        ),
      PartType.onlyImage => Padding(
          key: part.key,
          padding: const EdgeInsets.all(16),
          child: Center(
            child: MySatImage(
              assetName: part.imagePath!,
              legend: part.legend ?? "",
            ),
          ),
        ),
      PartType.citation => Padding(
          key: part.key,
          padding: mainLeftPadding.copyWith(right: 16),
          child: SelectableText.rich(
              TextSpan(children: [TextSpan(text: part.text)]),
              textAlign: bodyTextAlign(context),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontStyle: FontStyle.italic, fontSize: compact ? 22 : 32)),
        ),
      PartType.quote => Padding(
          key: part.key,
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.only(left: 16),
            decoration: BoxDecoration(
                border: Border(
                    left: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SelectableText(part.text,
                    textAlign: bodyTextAlign(context),
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontStyle: FontStyle.italic)),
                if (part.legend?.isNotEmpty ?? false)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: SelectableText(part.legend!,
                        textAlign: TextAlign.end,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
              ],
            ),
          ),
        ),
      PartType.gallery => LayoutBuilder(
          key: part.key,
          builder: (context, constraints) => Padding(
            padding: compact ? EdgeInsets.zero : mainLeftPadding,
            child: Column(children: [
              SizedBox(
                height: min(MAX_GALLERY_HEIGHT, constraints.maxWidth * 0.75),
                child: SatGallery(
                  assetNames: part.gallery!,
                  legend: part.legend,
                ),
              ),
              // Below the images, so that a long legend or enlarged text
              // takes the room it needs.
              if (part.legend?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.fromLTRB(56, 4, 56, 0),
                  // Already the text alternative of each image.
                  child: ExcludeSemantics(
                    child: Text(part.legend!,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodySmall),
                  ),
                ),
            ]),
          ),
        ),
      PartType.navigation =>
        KeyedSubtree(key: part.key, child: _buildNavigation(context, compact)),
      PartType.summary => Align(
          key: part.key,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(
                left: 16.0 +
                    (compact ? 0 : MediaQuery.sizeOf(context).width * 0.10),
                right: 16.0),
            child: Semantics(
              label: "Sommaire",
              container: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var item in focusItem.parts
                      .where((item) => item.subtitle.isNotEmpty))
                    TextLink(
                        text: item.subtitle,
                        onPressed: () => goToPart(context, item)),
                ],
              ),
            ),
          ),
        ),
      PartType.space => SizedBox(
          key: part.key,
          height: 16,
        )
    };
  }

  /// Previous / next article links; stacked on narrow screens so that the
  /// titles are not squeezed into two thin columns.
  Widget _buildNavigation(BuildContext context, bool compact) {
    final hasPrevious = focusItem.rank > 0;
    final hasNext = focusItem.rank < focus.length - 1;
    void goTo(int rank) => context.go(AppRoutes.getFocusItemRouteByRank(rank));

    final previous = hasPrevious
        ? InkWell(
            onTap: () => goTo(focusItem.rank - 1),
            child: Row(children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.arrow_back),
              ),
              Flexible(child: Text(focus[focusItem.rank - 1].title)),
            ]),
          )
        : const SizedBox.shrink();
    final next = hasNext
        ? InkWell(
            onTap: () => goTo(focusItem.rank + 1),
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              Flexible(
                  child: Text(focus[focusItem.rank + 1].title,
                      textAlign: TextAlign.end)),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Icon(Icons.arrow_forward),
              ),
            ]),
          )
        : const SizedBox.shrink();

    if (compact) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [previous, next],
      );
    }
    return Row(children: [
      Expanded(child: previous),
      const SizedBox(width: 32),
      Expanded(child: next),
    ]);
  }

  String getAuthorsHeadline() {
    return focusItem.author!.map((item) => item.normalizedName).join(", ");
  }

  void goToPart(BuildContext context, FocusItemPart item) {
    final BuildContext? targetContext = item.key.currentContext;
    if (targetContext != null) {
      Scrollable.ensureVisible(
        targetContext,
        duration: MediaQuery.disableAnimationsOf(context)
            ? Duration.zero
            : const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
