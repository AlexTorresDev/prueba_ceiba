// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

import '../../presentation/pages/home/home_page.dart' as _i1;
import '../../presentation/pages/post/post_page.dart' as _i2;

class AppRouter extends _i3.RootStackRouter {
  AppRouter([_i4.GlobalKey<_i4.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    PostRoute.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<PostRouteArgs>(
          orElse: () => PostRouteArgs(id: pathParams.getInt('id')));
      return _i3.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.PostPage(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };

  @override
  List<_i3.RouteConfig> get routes => [
        _i3.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i3.RouteConfig(
          PostRoute.name,
          path: '/post/:id',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i3.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.PostPage]
class PostRoute extends _i3.PageRouteInfo<PostRouteArgs> {
  PostRoute({
    _i4.Key? key,
    required int id,
  }) : super(
          PostRoute.name,
          path: '/post/:id',
          args: PostRouteArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'PostRoute';
}

class PostRouteArgs {
  const PostRouteArgs({
    this.key,
    required this.id,
  });

  final _i4.Key? key;

  final int id;

  @override
  String toString() {
    return 'PostRouteArgs{key: $key, id: $id}';
  }
}
