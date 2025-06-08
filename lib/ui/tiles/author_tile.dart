import "package:cradock_map/models/author.dart";
import "package:cradock_map/routes/routes.dart";
import "package:cradock_map/ui/tiles/sat_list_tile.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";


class AuthorTile extends StatelessWidget {
  const AuthorTile({super.key, required this.author});
  final Author author;

  @override
  Widget build(BuildContext context) {
    var title = "${author.firstName} ${author.familyName.toUpperCase()}";
    return SatTile(title: title, subtitle: "", onTap: () {
      context.go(AppRoutes.getAuthorItemRoute(author));
    });
  }
}
