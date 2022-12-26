import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAll extends PostEvent {
  const OnGetAll(this.userId);

  final int userId;

  @override
  List<Object?> get props => [userId];
}
