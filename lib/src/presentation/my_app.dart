import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prueba_ceiba/src/core/framework/colors.dart';
import 'package:prueba_ceiba/src/core/framework/router.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post/post_bloc.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post_user/post_user_bloc.dart';
import 'package:prueba_ceiba/src/presentation/blocs/user/user_bloc.dart';
import 'package:prueba_ceiba/src/injector.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.getIt<UserBloc>(),
        ),
        BlocProvider(
          create: (_) => di.getIt<PostBloc>(),
        ),
        BlocProvider(
          create: (_) => di.getIt<PostUserBloc>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: router,
        theme: ThemeData(
          primaryColor: primaryColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: primaryColor,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: primaryColor,
          ),
          inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
            prefixIconColor: primaryColor,
            labelStyle: TextStyle(
              color: primaryColor,
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: primaryColor,
          ),
          progressIndicatorTheme: const ProgressIndicatorThemeData(
            color: primaryColor,
          ),
        ),
      ),
    );
  }
}
