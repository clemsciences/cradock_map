

import "dart:math";

import "package:flutter/material.dart";

/// Wrapper to build great web pages.
class PageLayout extends StatelessWidget {
  PageLayout({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    // This is the breakpoint where the horizontal scrollbar becomes visible.
    // You can adjust this value as needed.
    // const double horizontalScrollBreakpoint = 800.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the horizontal scrollbar should be visible.
        print("max width: ${constraints.maxWidth}");
        final bool showHorizontalScroll = false;//constraints.maxWidth < horizontalScrollBreakpoint;

        Widget content = ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            // Ensure the content can be wider than the viewport if needed for horizontal scrolling.
            // minWidth: showHorizontalScroll ? horizontalScrollBreakpoint : constraints.maxWidth,
            // minWidth: max(constraints.maxWidth, horizontalScrollBreakpoint),
          ),
          child: child,
        );

        // Wrap with horizontal scroll if needed.
        if (showHorizontalScroll) {
          print("showHorizontalScroll visible");
          content = Scrollbar(
            thickness: 5,
            trackVisibility: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,

              child: content,
            ),
          );
        }

        // Always have vertical scroll.
        return SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: content,
        );
      },
    );
  }
}