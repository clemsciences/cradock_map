import "dart:core";

import "package:cradock_map/data/authors.dart";
import "package:cradock_map/data/focus.dart";
import "package:cradock_map/models/author.dart";
import "package:cradock_map/models/focus_item.dart";
import "package:cradock_map/views/author_item_view.dart";
import "package:cradock_map/views/authors_view.dart";
import "package:cradock_map/views/focus_item_view.dart";
import "package:cradock_map/views/focus_view.dart";
import "package:cradock_map/views/references_view.dart";
import "package:cradock_map/views/sequence_item_view.dart";
import "package:cradock_map/views/sequence_view.dart";
import "package:cradock_map/views/welcome_view.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

class AppRoutes {
  static const String WELCOME_ROUTE = "/";
  static const String BALADE_ROUTE = "/balade";
  static const String SEQUENCE_ROUTE = "/sequence";
  static const String SEQUENCE_ITEM_ROUTE = "/sequence/:id";
  static const String REFERENCES_ROUTE = "/references";
  static const String FOCUS_ROUTE = "/focus";
  static const String FOCUS_ITEM_ROUTE = "$FOCUS_ROUTE/:id";
  static const String AUTHORS_ROUTE = "/auteurs";
  static const String AUTHOR_ITEM_ROUTE = "$AUTHORS_ROUTE/:id";

  static String replaceItem(String route, String id) {
    return route.replaceAll(":id", id);
  }

  static String getAuthorItemRoute(Author author) {
    var route = "${author.firstName}-${author.familyName}";
    return replaceItem(AUTHOR_ITEM_ROUTE, route);
  }

  static String getFocusItemRoute(FocusItem item) {
    return replaceItem(FOCUS_ITEM_ROUTE, item.routeId);
  }
  static String getFocusItemRouteByRank(int rank) {
    if(rank < 0 || rank >= focusData.length) {
      throw Exception("Rank out of bounds");
    }
    return replaceItem(FOCUS_ITEM_ROUTE, focusData[rank].routeId);
  }
}

class SatAnimation1 extends CustomTransitionPage {
  SatAnimation1({
    required super.child,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
    super.transitionDuration = const Duration(milliseconds: 500),
    super.reverseTransitionDuration = const Duration(milliseconds: 500),
    super.maintainState = true,
    super.fullscreenDialog = false,
    super.opaque = true,
    super.barrierDismissible = false,
    super.barrierColor,
    super.barrierLabel,
  }) : super(transitionsBuilder:
            (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        });
}

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: AppRoutes.WELCOME_ROUTE,
  errorBuilder: (context, state) => WelcomeView(),
  routes: [
    GoRoute(
        path: AppRoutes.WELCOME_ROUTE,
        pageBuilder: (context, state) {
          return SatAnimation1(key: state.pageKey, child: WelcomeView());
        }),
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
    GoRoute(
        path: AppRoutes.FOCUS_ROUTE, builder: (context, state) => FocusView()),
    for (var focusItem in focusData)
      GoRoute(
          path: "${AppRoutes.FOCUS_ROUTE}/${focusItem.routeId}",
          builder: (context, state) => FocusItemView(
                focusItem: focusItem,
            focus: focusData,
              )),
    GoRoute(
        path: AppRoutes.AUTHORS_ROUTE,
        builder: (context, state) => AuthorsView(
              authors: authors,
            )),
    for (var author in authors)
      GoRoute(
          path: AppRoutes.getAuthorItemRoute(author),
          builder: (context, state) => AuthorItemView(
                author: author,
              )),
    GoRoute(
      path: "*",
      builder: (context, state) => WelcomeView(),
    ),
  ],
);
