import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stun_sync/components/template/main_layout.dart';
import 'package:stun_sync/screen/home.dart';
import 'package:stun_sync/screen/login.dart';
import 'package:stun_sync/screen/statistic.dart';

class PageRouter {
  static final router = GoRouter(
    redirect: (BuildContext context, GoRouterState state) {
      if (isLoggedIn) {
        return null;
      } else {
        return '/login';
      }
    },
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const MainLayout(child: HomePage()),
        routes: <RouteBase>[
          GoRoute(
            path: 'statistic',
            builder: (context, state) =>
                const MainLayout(child: StatisticPage()),
          ),
          GoRoute(
            path: 'login',
            builder: (context, state) => const Scaffold(body: LoginPage()),
          ),
          /**
           * Add more routes here
           * Example:
           * GoRoute(
           *    path: 'profile',
           *    builder: (context, state) => const MainLayout(child: ProfilePage()),
           * )
           */
        ],
      ),
    ],
  );
}
