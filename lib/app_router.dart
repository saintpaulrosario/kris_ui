import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kris/presentation/screen/word_list_screen.dart';

import 'presentation/page/home_page.dart';
import 'presentation/page/word_page.dart';

// ---------------------
// Route constants
// ---------------------
const routeHome = '/home';
const routeLogin = '/login';
const routeAncestry = '/ancestry';
const routeProfile = '/profile/:alias';
const routeWord = '/word';
const routeWordInfo = '/info/:sku';

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
  initialLocation: routeHome,
  routes: [
    // --------------------------------
    // **** HOME SHELL ****
    // --------------------------------
    ShellRoute(
      navigatorKey: _shellNav,
      builder: (context, state, child) => HomePage(child: child),
      routes: [
        GoRoute(path: routeHome, name: "home", builder: (_, __) => WordPage()),
      ],
    ),
  ],
);
