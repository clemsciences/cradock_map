import "package:flutter/material.dart";

class SatTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const SatTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MouseRegion(
                    cursor: SystemMouseCursors.text,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {},
                      child: SelectableText(
                        title,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  MouseRegion(
                    cursor: SystemMouseCursors.text,
                    child: GestureDetector(
                      // Empêche la sélection de texte d'annuler le clic global
                      behavior: HitTestBehavior.translucent,
                      onTap: () {}, // Empêche la propagation, mais ne fait rien
                      child: SelectableText(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
