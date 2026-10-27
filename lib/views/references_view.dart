import "package:cradock_map/data/reference_data.dart";
import "package:cradock_map/managers/url_opener.dart";
import "package:cradock_map/models/reference.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:cradock_map/ui/texts/text_link.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class ReferencesView extends StatelessWidget {
  const ReferencesView({super.key});

  static const double maxTextWidth = 800;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: PageLayout(
        child: Column(
          children: [
            const NavBar(),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxTextWidth),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        header: true,
                        child: Text(ReferenceData.title,
                            style: textTheme.headlineLarge),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SelectableText(ReferenceData.introduction,
                            style: textTheme.bodyLarge),
                      ),
                      for (var section in ReferenceData.sections) ...[
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 8),
                          child: Semantics(
                            header: true,
                            child: Text(section.title,
                                style: textTheme.headlineSmall),
                          ),
                        ),
                        if (section.introduction != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: SelectableText(section.introduction!,
                                style: textTheme.bodyLarge),
                          ),
                        for (var reference in section.references)
                          _buildReference(context, reference),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReference(BuildContext context, Reference reference) {
    final textTheme = Theme.of(context).textTheme;
    final url = reference.url;
    final articles = reference.articles;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectableText(reference.text, style: textTheme.bodyLarge),
          if (url != null)
            UrlOpener.canOpen
                ? TextLink(
                    text: url,
                    style: textTheme.bodyMedium,
                    onPressed: () => UrlOpener.open(url))
                : SelectableText(url, style: textTheme.bodyMedium),
          if (reference.usedIn != null)
            Text("Utilisé dans ${reference.usedIn}.",
                style: textTheme.bodyMedium),
          if (articles.isNotEmpty)
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Text("Cité dans : ", style: textTheme.bodyMedium),
                for (var (index, item) in articles.indexed) ...[
                  TextLink(
                      text: item.title,
                      style: textTheme.bodyMedium,
                      onPressed: () =>
                          context.go(AppRoutes.getFocusItemRoute(item))),
                  if (index < articles.length - 1)
                    Text(", ", style: textTheme.bodyMedium),
                ],
              ],
            ),
        ],
      ),
    );
  }
}
