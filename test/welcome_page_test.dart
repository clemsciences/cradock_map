//
// import "package:flutter/material.dart";
// import "package:flutter_test/flutter_test.dart";
// import "package:cradock_map/main.dart" as app;
//
// /// Test the welcome page of the app.
// void main() {
//   testWidgets("The page has a big SAT picture", (tester) async {
//     await tester.pumpWidget(app.MyApp());
//     find.widgetWithImage(widgetType, image)
//   });
//   group("WelcomePage Tests", () {
//     testWidgets("Welcome page displays correctly", (WidgetTester tester) async {
//       app.main();
//       await tester.pumpAndSettle();
//
//       // Verify that the "Welcome to Flutter Playground" text is present.
//       expect(find.text("Welcome to Flutter Playground"), findsOneWidget);
//
//       // Verify that the "Get Started" button is present.
//       expect(find.widgetWithText(ElevatedButton, "Get Started"), findsOneWidget);
//     });
//
//     testWidgets("Get Started button navigates to home page", (WidgetTester tester) async {
//       app.main();
//       await tester.pumpAndSettle();
//       // Add navigation test logic here when the HomePage is implemented.
//     });
//   });
// }