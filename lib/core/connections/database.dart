import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider _db = DBProvider._();

  static DBProvider get instance => _db;

  static Database? _database;

  Future<Database?> get database async => _database ??= await _init();

  _init() async {
    String usersTable = '''
          CREATE TABLE user(
            id INTEGER PRIMARY KEY,
            name TEXT,
            email TEXT,
            phone TEXT
          );
          ''';

    String postsTable = '''
          CREATE TABLE post(
            id INTEGER PRIMARY KEY,
            userId INTEGER,
            title TEXT,
            body TEXT,
            FOREIGN KEY (userId) REFERENCES user(id)
          );
          ''';

    return await openDatabase(
      join(await getDatabasesPath(), 'ceiba_database.db'),
      onCreate: (db, _) async {
        await db.execute(usersTable);
        await db.execute(postsTable);
      },
      version: 1,
    );
  }
}
