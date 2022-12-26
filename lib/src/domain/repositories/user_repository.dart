import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/src/core/errors/failure.dart';
import 'package:prueba_ceiba/src/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> getUserList();
  Future<Either<Failure, List<User>>> getUserListByQuery(String query);
  Future<Either<Failure, User>> getUserById(int userId);
}
