import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/src/core/errors/failure.dart';
import 'package:prueba_ceiba/src/domain/entities/user.dart';
import 'package:prueba_ceiba/src/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, List<User>>> call(String query) =>
      repository.getUserListByQuery(query);

  Future<Either<Failure, User>> getById(int userId) =>
      repository.getUserById(userId);
}
