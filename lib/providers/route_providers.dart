import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tcg_calculator/view/pages/deck_details_page.dart';
import 'package:flutter_tcg_calculator/view/pages/error_page.dart';
import 'package:flutter_tcg_calculator/view/pages/home_page.dart';
import 'package:flutter_tcg_calculator/view/pages/list_of_decks.dart';
import 'package:go_router/go_router.dart';

final routeProvider = Provider<GoRouter>((ref) => GoRouter(
  errorBuilder: (context, state) => const ErrorPage(),
  routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) => const MaterialPage(child: HomePage()),
      ),
      GoRoute(
          path: '/decklist',
          pageBuilder: (context, state) {
            return const MaterialPage(child: CustomListView());
          },
          routes: [
            GoRoute(
                path: ':deckId',
                pageBuilder: (context, state) {
                  final String? deckId = state.pathParameters['deckId'];
                  return MaterialPage(child: DeckDetailsPage(deckId: deckId));
                }),
          ]),
    ]));