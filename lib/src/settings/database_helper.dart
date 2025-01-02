import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 2;
  static const String _dbName = "artis.db";

  static Future<Database> getDb() async {
    return await openDatabase(join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) async => await db.execute(
        "CREATE TABLE t_user("
          "a_user_id INTEGER PRIMARY KEY,"
          "a_username VARCHAR(150),"
          "a_password VARCHAR(300),"
          "a_email VARCHAR(300),"
          "a_birth_date VARCHAR(25)"
        ");"
        "INSERT INTO t_user (a_username, a_password, a_email, a_birth_date) VALUES("
          "'miguellrp',"
          "'13d249f2cb4127b40cfa757866850278793f814ded3c587fe5889e889a7a9f6c',"
          "'miguellrp@test.test',"
          "'1997-12-17 00:00:00'"
        ");"
      ),
      version: _version
    );
  }
}