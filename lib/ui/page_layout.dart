import "package:flutter/material.dart";

/// Wrapper to build great web pages.
class PageLayout extends StatelessWidget {
  const PageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: child,
              ),
            ));
  }
}
