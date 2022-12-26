import 'package:prueba_ceiba/src/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    int? id,
    String? name,
    String? email,
    String? phone,
  }) : super(
          id: id,
          name: name,
          email: email,
          phone: phone,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
      };
}
