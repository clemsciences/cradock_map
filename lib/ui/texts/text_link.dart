import "package:flutter/material.dart";

/// An underlined text link reachable with the keyboard (Tab, then Enter) and
/// announced as a link by screen readers, unlike a tappable TextSpan.
class TextLink extends StatelessWidget {
  const TextLink(
      {super.key, required this.text, required this.onPressed, this.style});

  final String text;
  final VoidCallback onPressed;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final base = style ?? Theme.of(context).textTheme.bodyLarge;
    return Semantics(
      link: true,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
          child: Text(text,
              style: base?.copyWith(
                  decoration: TextDecoration.underline,
                  // The primary colour of the theme has a sufficient contrast
                  // on the background (WCAG AA), unlike Colors.blue.
                  color: Theme.of(context).colorScheme.primary)),
        ),
      ),
    );
  }
}
