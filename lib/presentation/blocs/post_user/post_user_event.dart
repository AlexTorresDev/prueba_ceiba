import 'package:equatable/equatable.dart';

abstract class PostUserEvent extends Equatable {
  const PostUserEvent();

  @override
  List<Object?> get props => [];
}

class OnGetUser extends PostUserEvent {
  const OnGetUser(this.id);

  final int id;

  @override
  List<Object?> get props => [id];
}
