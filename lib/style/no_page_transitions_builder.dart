import "package:flutter/material.dart";

/// Shows the new page immediately, like a regular website. The default
/// transitions (zoom on Android/Windows/Linux, slide on macOS/iOS) animate the
/// whole page, nav bar included, at every click.
class NoPageTransitionsBuilder extends PageTransitionsBuilder {
  const NoPageTransitionsBuilder();

  @override
  Duration get transitionDuration => Duration.zero;

  @override
  Widget buildTransitions<T>(
      PageRoute<T> route,
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return child;
  }
}
