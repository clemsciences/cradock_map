import "dart:io";

import "package:cradock_map/data/focus.dart";
import "package:cradock_map/data/image_previews.dart";
import "package:cradock_map/notifiers/multi_notifier.dart";
import "package:cradock_map/ui/images/my_sat_image.dart";
import "package:cradock_map/ui/images/progressive_asset_image.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:flutter/material.dart";
import "package:flutter_test/flutter_test.dart";
import "package:go_router/go_router.dart";

void main() {
  test("Every image of the published articles has a preview", () {
    final images = {
      for (var item in focusData)
        for (var part in item.parts) ...[
          if (part.imagePath?.isNotEmpty ?? false) part.imagePath!,
          ...?part.gallery,
        ]
    };
    for (var image in images) {
      expect(ImagePreviews.all.containsKey(image), isTrue,
          reason: "$image: run python3 tool/make_previews.py");
      expect(File(ImagePreviews.pathOf(image)).existsSync(), isTrue,
          reason: ImagePreviews.pathOf(image));
    }
  });

  testWidgets("Article images get their final size on the first frame",
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1400, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    final article = focusData[1]; // the article with the most images
    final router = GoRouter(routes: [
      GoRoute(
          path: "/",
          builder: (context, state) =>
              FocusItemView(focusItem: article, focus: focusData)),
    ]);
    await tester.pumpWidget(
        MultiNotifier(child: MaterialApp.router(routerConfig: router)));

    // No waiting for the images: each frame already has the image ratio.
    final images = find.byType(MySatImage);
    expect(images, findsWidgets);
    for (var element in images.evaluate()) {
      final image = element.widget as MySatImage;
      final frame = find
          .descendant(of: find.byWidget(image), matching: find.byType(SizedBox))
          .first;
      final size = tester.getSize(frame);
      expect(
          size.width / size.height,
          moreOrLessEquals(ImagePreviews.aspectRatioOf(image.assetName)!,
              epsilon: 0.01),
          reason: image.assetName);
    }
    expect(find.byType(ProgressiveAssetImage), findsWidgets);
    await tester.pump(const Duration(seconds: 1));
  });
}
