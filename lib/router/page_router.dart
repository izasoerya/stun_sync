import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:stun_sync/components/template/main_layout.dart';
import 'package:stun_sync/screen/home.dart';
import 'package:stun_sync/screen/login.dart';
import 'package:stun_sync/screen/register.dart';
import 'package:stun_sync/screen/statistic.dart';

class PageRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: <RouteBase>[
      GoRoute(
        path: '/login',
        builder: (context, state) => const Scaffold(body: LoginPage()),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const Scaffold(body: RegisterPage()),
      ),
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
              path: 'home',
              builder: (context, state) => const MainLayout(child: HomePage())),
          // other routes...
        ],
      ),
    ],
  );
}
