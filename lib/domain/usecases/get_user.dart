import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/core/errors/failure.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/user_repository.dart';

class GetUser {
  final UserRepository repository;

  GetUser(this.repository);

  Future<Either<Failure, List<User>>> call(String query) =>
      repository.getUserListByQuery(query);

  Future<Either<Failure, User>> getById(int userId) =>
      repository.getUserById(userId);
}
