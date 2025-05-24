import "dart:core";

import "package:cradock_map/views/focus_view.dart";
import "package:cradock_map/views/references_view.dart";
import "package:cradock_map/views/sequence_item_view.dart";
import "package:cradock_map/views/sequence_view.dart";
import "package:cradock_map/views/welcome_view.dart";
import "package:go_router/go_router.dart";

class AppRoutes {
  static const String WELCOME_ROUTE = "/";
  static const String BALADE_ROUTE = "/balade";
  static const String SEQUENCE_ROUTE = "/sequence";
  static const String SEQUENCE_ITEM_ROUTE = "/sequence/:id";
  static const String REFERENCES_ROUTE = "/references";
  static const String FOCUS_ROUTE = "/focus";
}

final GoRouter router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: AppRoutes.WELCOME_ROUTE,
    errorBuilder: (context, state) => WelcomeView(),
    routes: [
      GoRoute(
          path: AppRoutes.WELCOME_ROUTE,
          builder: (context, state) => WelcomeView()),
      /*GoRoute(
          path: AppRoutes.BALADE_ROUTE,
          builder: (context, state) => BaladeView()),*/
      GoRoute(
          path: AppRoutes.SEQUENCE_ROUTE,
          builder: (context, state) => SequenceView()),
      GoRoute(
          path: AppRoutes.SEQUENCE_ITEM_ROUTE,
          builder: (context, state) => SequenceItemView()),
      GoRoute(
          path: AppRoutes.REFERENCES_ROUTE,
          builder: (context, state) => ReferencesView()),
      GoRoute(path: AppRoutes.FOCUS_ROUTE,
        builder: (context, state) => FocusView()
      ),
      GoRoute(
        path: '*',
        builder: (context, state) => WelcomeView(),
      ),
    ]);
