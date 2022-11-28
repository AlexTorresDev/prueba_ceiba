import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:prueba_ceiba/core/errors/exceptions.dart';
import 'package:prueba_ceiba/data/models/post_model.dart';
import 'package:prueba_ceiba/data/models/user_model.dart';

abstract class RemoteDataSource {
  Future<List<UserModel>> getUserList();
  Future<List<PostModel>> getPostList(int userId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({
    required this.client,
  });

  final http.Client client;
  final _baseURL = 'https://jsonplaceholder.typicode.com';

  @override
  Future<List<UserModel>> getUserList() async {
    final response = await client.get(Uri.parse('$_baseURL/users'));

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List;
      return results.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<PostModel>> getPostList(int userId) async {
    final response =
        await client.get(Uri.parse('$_baseURL/posts?userId=$userId'));

    if (response.statusCode == 200) {
      final results = json.decode(response.body) as List;
      return results.map((e) => PostModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
