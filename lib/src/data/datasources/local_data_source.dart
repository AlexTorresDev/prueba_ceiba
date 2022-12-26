import 'package:sqflite/sqflite.dart';

import 'package:prueba_ceiba/src/data/models/post_model.dart';
import 'package:prueba_ceiba/src/data/models/user_model.dart';
import 'package:prueba_ceiba/src/core/connections/database.dart';

abstract class LocalDataSource {
  Future<List<UserModel>> getUserList();
  Future<List<UserModel>> getUserListByQuery(String query);
  Future<UserModel?> getUserById(int userId);
  Future<List<PostModel>> getPostList(int userId);
  void saveUserList(List<UserModel> userList);
  void savePostList(List<PostModel> postList);
}

class LocalDataSourceImpl implements LocalDataSource {
  final DBProvider? dbProvider;

  LocalDataSourceImpl({
    required this.dbProvider,
  });

  @override
  Future<List<UserModel>> getUserList() async {
    final database = await dbProvider!.database;
    final maps = await database!.query('user');

    if (maps.isNotEmpty) {
      return maps.map((e) => UserModel.fromJson(e)).toList();
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<UserModel>> getUserListByQuery(String query) async {
    final database = await dbProvider!.database;
    final maps = await database!.query(
      'user',
      where: 'name LIKE ?',
      whereArgs: ['%$query%'],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => UserModel.fromJson(e)).toList();
    } else {
      return Future.value([]);
    }
  }

  @override
  Future<List<PostModel>> getPostList(int userId) async {
    final database = await dbProvider!.database;
    final maps = await database!.query(
      'post',
      where: 'userId = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return maps.map((e) => PostModel.fromJson(e)).toList();
    } else {
      return Future.value([]);
    }
  }

  @override
  void saveUserList(List<UserModel> userList) async {
    final database = await dbProvider!.database;

    for (final user in userList) {
      await database!.insert(
        'user',
        user.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  void savePostList(List<PostModel> postList) async {
    final database = await dbProvider!.database;

    for (final post in postList) {
      await database!.insert(
        'post',
        post.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<UserModel?> getUserById(int userId) async {
    final database = await dbProvider!.database;
    final maps = await database!.query(
      'user',
      where: 'id = ?',
      whereArgs: [userId],
    );

    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    } else {
      return Future.value(null);
    }
  }
}
