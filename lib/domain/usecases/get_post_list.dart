import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/core/errors/failure.dart';
import 'package:prueba_ceiba/domain/entities/post.dart';
import 'package:prueba_ceiba/domain/repositories/post_repository.dart';

class GetPostList {
  final PostRepository repository;

  GetPostList(this.repository);

  Future<Either<Failure, List<Post>>> call(int userId) =>
      repository.getPostList(userId);
}
