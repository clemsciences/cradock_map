import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

/// Wrapper to build great web pages.
class PageLayout extends StatefulWidget {
  const PageLayout({super.key, required this.child, this.scrollController});

  final Widget child;


  final ScrollController? scrollController;

  @override
  State<PageLayout> createState() => _PageLayoutState();
}

class _PageLayoutState extends State<PageLayout> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    // Dispose the controller only if it was created internally.
    // If it was passed in, the owner is responsible for disposing it.
    if (widget.scrollController == null) _scrollController.dispose();
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

        Widget content = ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
            // Ensure the content can be wider than the viewport if needed for horizontal scrolling.
            // minWidth: showHorizontalScroll ? horizontalScrollBreakpoint : constraints.maxWidth,
            // minWidth: max(constraints.maxWidth, horizontalScrollBreakpoint),
          ),
          child: widget.child,
        );

        // Always have vertical scroll. The scrollbar stays visible with a
        // mouse; on touch devices it only shows while scrolling.
        final isDesktop = switch (defaultTargetPlatform) {
          TargetPlatform.linux ||
          TargetPlatform.macOS ||
          TargetPlatform.windows =>
            true,
          _ => false,
        };
        return SafeArea(
          child: Scrollbar(
            trackVisibility: isDesktop,
            thumbVisibility: isDesktop,
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.vertical,
              child: content,
            ),
          ),
        );
      },
    );
  }
}