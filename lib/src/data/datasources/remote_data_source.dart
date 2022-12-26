import 'dart:convert';

import 'package:prueba_ceiba/src/core/errors/exceptions.dart';
import 'package:prueba_ceiba/src/core/network/client_service.dart';
import 'package:prueba_ceiba/src/data/models/post_model.dart';
import 'package:prueba_ceiba/src/data/models/user_model.dart';

abstract class RemoteDataSource {
  Future<List<UserModel>> getUserList();
  Future<List<PostModel>> getPostList(int userId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({
    required this.client,
  });

  final ClientService client;

  @override
  Future<List<UserModel>> getUserList() async {
    final response = await client.get('/users');

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List;
      return results.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPostList(int userId) async {
    final response = await client.get('/posts?userId=$userId');

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List;
      return results.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
