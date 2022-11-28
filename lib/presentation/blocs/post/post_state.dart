import 'package:equatable/equatable.dart';
import 'package:prueba_ceiba/domain/entities/post.dart';
import 'package:prueba_ceiba/domain/entities/user.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object?> get props => [];
}

class PostEmpty extends PostState {}

class PostLoading extends PostState {}

class PostError extends PostState {
  const PostError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class PostHasData extends PostState {
  const PostHasData(this.posts);

  final List<Post> posts;

  @override
  List<Object?> get props => [posts];
}

class PostHasUser extends PostState {
  const PostHasUser(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}
