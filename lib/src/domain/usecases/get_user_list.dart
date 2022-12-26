import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/src/core/errors/failure.dart';
import 'package:prueba_ceiba/src/domain/entities/user.dart';
import 'package:prueba_ceiba/src/domain/repositories/user_repository.dart';

class GetUserList {
  final UserRepository repository;

  GetUserList(this.repository);

  Future<Either<Failure, List<User>>> call() => repository.getUserList();
}
