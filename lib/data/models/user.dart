import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = "t_user";

class User {
  final int? userId;
  final String username;
  final String hashedPassword;
  final String? email;

  User({
    this.userId,
    required this.username,
    required this.hashedPassword,
    this.email,
  });

  Map<String, Object?> toMap() {
    return {
      "userId": userId,
      "username": username,
      "hashedPassword": hashedPassword,
      "email": email
    };
  }

  @override
  String toString() {
    return "User {userId: $userId, username: $username, hashedPassword: $hashedPassword,"
      "email: $email}";
  }


  static Future<List<User>> list(String whereConditions, List<Object>? whereArgs) async {
    final db = await getDb();

    final List<Map<String, Object?>> userMaps = await db.query(tableName, where: whereConditions, whereArgs: whereArgs);

    return [
      for (final {
      "userId": userId as int,
      "username": username as String,
      "hashedPassword": hashedPassword as String,
      "email": email as String,
      } in userMaps)
        User(
          userId: userId,
          username: username,
          hashedPassword: hashedPassword,
          email: email
        ),
    ];
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  Future<void> register() async {
    final db = await getDb();

    await db.insert(
      tableName,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> login() async {
    final db = await getDb();
    List<Map<String, Object?>> usersFound = [];

    usersFound = await db.query(
      tableName,
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword]
    );

    return usersFound.length == 1;
  }


  Future<void> update() async {
    final db = await getDb();

    await db.update(
      tableName,
      toMap(),
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteDog() async {
    final db = await getDb();

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}


Future<Database> getDb() async {
  return await openDatabase(join(await getDatabasesPath(), "artisdb.db"));
}
