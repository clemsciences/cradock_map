import "package:cradock_map/routes/routes.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  static const double compactBreakpoint = 600;

  static const List<(String, String)> destinations = [
    ("Accueil", AppRoutes.WELCOME_ROUTE),
    ("Séquence", AppRoutes.SEQUENCE_ROUTE),
    ("Focus", AppRoutes.FOCUS_ROUTE),
    ("Référence", AppRoutes.REFERENCES_ROUTE),
    ("Auteurs", AppRoutes.AUTHORS_ROUTE),
    ("Paramètres", AppRoutes.GENERAL_ROUTE),
  ];

  @override
  Widget build(BuildContext context) {
    final currentPath = GoRouterState.of(context).uri.path;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > compactBreakpoint) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            // At least the full width, so that the buttons stay centered
            // whatever the alignment of the page around the NavBar.
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: constraints.maxWidth),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (var (label, route) in destinations)
                  _NavButton(
                    label: label,
                    isSelected: currentPath == route,
                    onPressed: () => context.go(route),
                  ),
              ]),
            ),
          );
        }
        // On phones, a single menu instead of several rows of buttons.
        final currentLabel = destinations
            .where((destination) =>
                currentPath == destination.$2 ||
                (destination.$2 != AppRoutes.WELCOME_ROUTE &&
                    currentPath.startsWith(destination.$2)))
            .map((destination) => destination.$1)
            .firstOrNull;
        return Center(
          child: PopupMenuButton<String>(
            tooltip: "Menu",
            onSelected: (route) => context.go(route),
            itemBuilder: (context) => [
              for (var (label, route) in destinations)
                CheckedPopupMenuItem<String>(
                  value: route,
                  checked: currentPath == route,
                  child: Text(label),
                ),
            ],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.menu),
                  const SizedBox(width: 8),
                  Text(currentLabel ?? "Menu",
                      style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _NavButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onPressed;

  const _NavButton({
    required this.label,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (isSelected) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: FilledButton.tonal(
          onPressed: onPressed,
          child: Text(label),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
        onPressed: onPressed,
        child: Text(label),
      ),
    );
  }
}
