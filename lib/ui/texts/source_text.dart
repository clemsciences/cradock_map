import "package:cradock_map/models/text.dart";
import "package:flutter/material.dart";

class SourceText extends StatelessWidget {
  final CradockOriginalBookPage page;

  const SourceText({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return SelectableText.rich(TextSpan(children: [
      for(var line in page.text.split("\n"))
        TextSpan(text: line)
    ]));
  }
}
