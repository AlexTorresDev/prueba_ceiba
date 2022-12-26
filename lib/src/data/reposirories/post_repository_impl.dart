import 'dart:io';

import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/src/core/errors/exceptions.dart';
import 'package:prueba_ceiba/src/core/errors/failure.dart';
import 'package:prueba_ceiba/src/data/datasources/local_data_source.dart';
import 'package:prueba_ceiba/src/data/datasources/remote_data_source.dart';
import 'package:prueba_ceiba/src/domain/entities/post.dart';
import 'package:prueba_ceiba/src/domain/repositories/post_repository.dart';

class PostRepositoryImpl implements PostRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  PostRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Post>>> getPostList(int userId) async {
    try {
      final localPostList = await localDataSource.getPostList(userId);

      if (localPostList.isEmpty) {
        final remotePostList = await remoteDataSource.getPostList(userId);
        localDataSource.savePostList(remotePostList);
        return Right(remotePostList);
      } else {
        return Right(localPostList);
      }
    } on CacheException {
      return const Left(
        DatabaseFailure('Failed to get post list from cache'),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
