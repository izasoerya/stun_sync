import 'package:go_router/go_router.dart';
import 'package:stun_sync/components/template/main_layout.dart';
import 'package:stun_sync/screen/home.dart';
import 'package:stun_sync/screen/statistic.dart';

class PageRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (context, state) => const MainLayout(child: HomePage()),
        routes: <RouteBase>[
          GoRoute(
            path: 'statistic',
            builder: (context, state) =>
                const MainLayout(child: StatisticPage()),
          )
          /**
           * Add more routes here
           * Example:
           * GoRoute(
           *    path: 'profile',
           *    builder: (context, state) => const MainLayout(child: ProfilePage()),
           * )
           */
        ],
      )
    ],
  );
}
