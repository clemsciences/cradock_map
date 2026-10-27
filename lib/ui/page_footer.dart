import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/texts/text_link.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// Link to the legal notice at the bottom of every page.
class PageFooter extends StatelessWidget {
  const PageFooter({super.key});

  static const double height = 48;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: TextLink(
            text: "Mentions légales et crédits",
            style: Theme.of(context).textTheme.bodySmall,
            onPressed: () => context.go(AppRoutes.LEGAL_ROUTE)),
      ),
    );
  }
}
