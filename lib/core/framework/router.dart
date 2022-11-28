import 'package:auto_route/auto_route.dart';
import 'package:prueba_ceiba/presentation/pages/home/home_page.dart';
import 'package:prueba_ceiba/presentation/pages/post/post_page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: HomePage,
      initial: true,
    ),
    AutoRoute(
      path: '/post/:id',
      page: PostPage,
    ),
    /*AutoRoute(
      path: '*',
      page: ErrorPage,
      name: 'ErrorRoute',
    ),*/
  ],
)
class $AppRouter {}
