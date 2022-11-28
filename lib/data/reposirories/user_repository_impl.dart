import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:prueba_ceiba/core/errors/exceptions.dart';
import 'package:prueba_ceiba/core/errors/failure.dart';
import 'package:prueba_ceiba/data/datasources/local_data_source.dart';
import 'package:prueba_ceiba/data/datasources/remote_data_source.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<User>>> getUserList() async {
    try {
      final localUserList = await localDataSource.getUserList();

      if (localUserList.isEmpty) {
        final remoteUserList = await remoteDataSource.getUserList();
        localDataSource.saveUserList(remoteUserList);
        return Right(remoteUserList);
      } else {
        return Right(localUserList);
      }
    } on CacheException {
      return const Left(
        DatabaseFailure('Failed to get user list from cache'),
      );
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getUserListByQuery(String query) async {
    try {
      final localUsers = await localDataSource.getUserListByQuery(query);

      if (localUsers.isEmpty) {
        return const Left(DatabaseFailure('List is empty'));
      } else {
        return Right(localUsers);
      }
    } on CacheException {
      return const Left(
        DatabaseFailure('Failed to get users from cache'),
      );
    }
  }

  @override
  Future<Either<Failure, User>> getUserById(int userId) async {
    try {
      final localUser = await localDataSource.getUserById(userId);

      if (localUser == null) {
        return const Left(DatabaseFailure('Error getting user'));
      } else {
        return Right(localUser);
      }
    } on CacheException {
      return const Left(
        DatabaseFailure('Failed to get user from cache'),
      );
    }
  }
}
