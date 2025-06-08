import "package:cradock_map/models/author.dart";
import "package:cradock_map/ui/nav_bar.dart";
import "package:cradock_map/ui/page_layout.dart";
import "package:flutter/material.dart";

class AuthorItemView extends StatelessWidget {
  final Author author;
  const AuthorItemView({super.key, required this.author});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageLayout(child: Column(
        children: [
          NavBar(),
          SelectableText("${author.firstName} ${author.familyName.toUpperCase()}"),
          const SizedBox(height: 12,),
          SelectableText(author.biography ?? ""),
          SelectableText(author.bibliography ?? ""),

        ],
      )),
    );
  }
}
