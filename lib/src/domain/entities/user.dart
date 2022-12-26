import 'package:equatable/equatable.dart';

class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
    this.phone,
  });

  final int? id;
  final String? name;
  final String? email;
  final String? phone;

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
      ];
}
