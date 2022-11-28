import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/core/errors/failure.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';
import 'package:prueba_ceiba/domain/repositories/user_repository.dart';

class GetUserList {
  final UserRepository repository;

  GetUserList(this.repository);

  Future<Either<Failure, List<User>>> call() => repository.getUserList();
}
