import 'package:dartz/dartz.dart';

import 'package:prueba_ceiba/src/core/errors/failure.dart';
import 'package:prueba_ceiba/src/domain/entities/post.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getPostList(int userId);
}
