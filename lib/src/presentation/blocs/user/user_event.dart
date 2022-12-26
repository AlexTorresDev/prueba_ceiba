import 'package:equatable/equatable.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class OnGetAll extends UserEvent {
  const OnGetAll();

  @override
  List<Object?> get props => [];
}

class OnSearch extends UserEvent {
  const OnSearch(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
