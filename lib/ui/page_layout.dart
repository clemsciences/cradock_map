

import "package:flutter/material.dart";

/// Wrapper to build great web pages.
class PageLayout extends StatefulWidget {
  PageLayout({super.key, required this.child, this.scrollController});

  final Widget child;


  final ScrollController? scrollController;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  @override
  void dispose() {
    widget.scrollController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // This is the breakpoint where the horizontal scrollbar becomes visible.
    // You can adjust this value as needed.
    // const double horizontalScrollBreakpoint = 800.0;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Determine if the horizontal scrollbar should be visible.
        print("max width: ${constraints.maxWidth}");

        Widget content = ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            // Ensure the content can be wider than the viewport if needed for horizontal scrolling.
            // minWidth: showHorizontalScroll ? horizontalScrollBreakpoint : constraints.maxWidth,
            // minWidth: max(constraints.maxWidth, horizontalScrollBreakpoint),
          ),
          child: widget.child,
        );

        // Always have vertical scroll.
        return Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          controller: widget.scrollController,
          child: SingleChildScrollView(
            controller: widget.scrollController,
            scrollDirection: Axis.vertical,
            child: content,
          ),
        );
      },
    );
  }
}