import 'package:go_router/go_router.dart';
import 'package:prueba_ceiba/src/presentation/pages/home/home_page.dart';
import 'package:prueba_ceiba/src/presentation/pages/post/post_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (_, state) => const HomePage(),
    ),
    GoRoute(
      path: '/post/:id',
      builder: (_, state) => PostPage(id: int.parse(state.params['id']!)),
    ),
  ],
);
