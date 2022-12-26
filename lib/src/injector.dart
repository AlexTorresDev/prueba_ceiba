import 'package:get_it/get_it.dart';
import 'package:prueba_ceiba/src/core/connections/database.dart';
import 'package:prueba_ceiba/src/core/network/client_service.dart';
import 'package:prueba_ceiba/src/data/datasources/local_data_source.dart';
import 'package:prueba_ceiba/src/data/datasources/remote_data_source.dart';
import 'package:prueba_ceiba/src/data/reposirories/post_repository_impl.dart';
import 'package:prueba_ceiba/src/data/reposirories/user_repository_impl.dart';
import 'package:prueba_ceiba/src/domain/repositories/post_repository.dart';
import 'package:prueba_ceiba/src/domain/repositories/user_repository.dart';
import 'package:prueba_ceiba/src/domain/usecases/get_post_list.dart';
import 'package:prueba_ceiba/src/domain/usecases/get_user.dart';
import 'package:prueba_ceiba/src/domain/usecases/get_user_list.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post/post_bloc.dart';
import 'package:prueba_ceiba/src/presentation/blocs/post_user/post_user_bloc.dart';
import 'package:prueba_ceiba/src/presentation/blocs/user/user_bloc.dart';

final getIt = GetIt.instance;

void init() {
  // BLoC
  getIt.registerFactory(() => UserBloc(getIt(), getIt()));
  getIt.registerFactory(() => PostBloc(getIt()));
  getIt.registerFactory(() => PostUserBloc(getIt()));

  // Use case
  getIt.registerLazySingleton(() => GetUserList(getIt()));
  getIt.registerLazySingleton(() => GetUser(getIt()));
  getIt.registerLazySingleton(() => GetPostList(getIt()));

  // Repository
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));
  getIt.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
        remoteDataSource: getIt(),
        localDataSource: getIt(),
      ));

  // Data sources
  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: getIt()));
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(dbProvider: getIt()));

  // Core
  getIt.registerLazySingleton(() => ClientService());
  getIt.registerLazySingleton(() => DBProvider.instance);
}
