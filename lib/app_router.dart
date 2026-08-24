import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/model/account.dart';

import 'feature/presentation/page/authentication_page.dart';
import 'model/identifier.dart';
import 'presentation/page/home_page.dart';
import 'presentation/page/word_page.dart';

// ---------------------
// Route constants
// ---------------------
const routeHome = '/';
const routeAuthentication = '/authenticate';
const routeAncestry = '/ancestry';
const routeProfile = '/profile/:alias';
const routeWord = '/word';
const routeWordInfo = '/info/:sku';
const routeWordDetail = 'word/:sku';
const routePayloadDetail = '/payload/:sku';

// ---------------------
// Navigator Keys
// ---------------------
final _rootNav = GlobalKey<NavigatorState>();
final _shellNav = GlobalKey<NavigatorState>();
final _profileNav = GlobalKey<NavigatorState>();
final _ancestryNav = GlobalKey<NavigatorState>();
final _kodofolaNav = GlobalKey<NavigatorState>();

// ---------------------
// App Router
// ---------------------
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNav,
  initialLocation: routeWord,
  routes: [
    // --------------------------------
    // **** HOME SHELL ****
    // --------------------------------
    ShellRoute(
      navigatorKey: _shellNav,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(
          path: routeWord,
          name: routeWord,
          builder: (_, _) => WordPage(),
        ),
        GoRoute(
          path: routeWordDetail,
          name: routeWordDetail,
          builder: (_, state) {
            final sku = state.pathParameters['sku']!;

            Identifier identifier = Identifier(
              sku: sku,
              version: 0,
              ordinal: 0,
              createdDate: DateTime.now(),
              lastModifiedDate: DateTime.now(),
              createdBy: Account.initial(),
              lastModifiedBy: Account.initial(),
            );
            return Text("data");
          },
        ),
        GoRoute(
          path: routePayloadDetail,
          name: routePayloadDetail,
          builder: (_, state) {
            final sku = state.pathParameters['sku']!;

            Identifier identifier = Identifier(
              sku: sku,
              version: 0,
              ordinal: 0,
              createdDate: DateTime.now(),
              lastModifiedDate: DateTime.now(),
              createdBy: Account.initial(),
              lastModifiedBy: Account.initial(),
            );
            return Text("");
          },
        ),

        // --------------------------------
        // **** LOGIN (ROOT) ****
        // --------------------------------
      ],
    ),
    GoRoute(
      parentNavigatorKey: _rootNav,
      path: routeAuthentication,
      name: routeAuthentication,
      builder: (_, _) => const AuthenticationPage(),
    ),
  ],
);
