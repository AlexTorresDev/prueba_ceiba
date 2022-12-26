import 'package:equatable/equatable.dart';
import 'package:prueba_ceiba/src/domain/entities/user.dart';

abstract class PostUserState extends Equatable {
  const PostUserState();

  @override
  List<Object?> get props => [];
}

class UserEmpty extends PostUserState {}

class UserLoading extends PostUserState {}

class UserError extends PostUserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class PostUserHasData extends PostUserState {
  const PostUserHasData(this.user);

  final User user;

  @override
  List<Object?> get props => [user];
}
