import 'package:equatable/equatable.dart';
import 'package:prueba_ceiba/src/domain/entities/user.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserEmpty extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  const UserError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class UserHasData extends UserState {
  const UserHasData(this.users);

  final List<User> users;

  @override
  List<Object?> get props => [users];
}
