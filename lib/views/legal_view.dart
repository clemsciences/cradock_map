import "package:cradock_map/data/legal_data.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";

class LegalView extends StatelessWidget {
  const LegalView({super.key});

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
                  child: SelectionArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Semantics(
                          header: true,
                          child: Text(LegalData.title,
                              style: textTheme.headlineLarge),
                        ),
                        for (var (heading, paragraphs)
                            in LegalData.sections) ...[
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 8),
                            child: Semantics(
                              header: true,
                              child:
                                  Text(heading, style: textTheme.headlineSmall),
                            ),
                          ),
                          for (var paragraph in paragraphs)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child:
                                  Text(paragraph, style: textTheme.bodyLarge),
                            ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
