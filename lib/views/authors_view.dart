import "package:cradock_map/models/author.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:cradock_map/ui/tiles/author_tile.dart";
import "package:flutter/material.dart";


class AuthorsView extends StatelessWidget {
  const AuthorsView({super.key, required this.authors});
  final List<Author> authors;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(child: Column(
        children: [
          NavBar(),
          SelectableText("Auteurs", style: Theme.of(context).textTheme.headlineLarge,),
          SizedBox(height: 12,),
          for(var author in authors)
            AuthorTile(author: author,)
        ],
      )),
    );
  }
}
