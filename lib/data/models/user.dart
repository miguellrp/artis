import 'dart:async';
import 'dart:convert';

import 'package:artis/src/settings/database_helper.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

final String tableName = "t_user";

class User {
  final int? userId;
  final String username;
  final String hashedPassword;
  final String? email;
  final DateTime? birthDate;

  User({
    this.userId,
    required this.username,
    required this.hashedPassword,
    this.email,
    this.birthDate
  });

  Map<String, Object?> toMap() {
    return {
      "userId": userId,
      "username": username,
      "password": hashedPassword,
      "email": email,
      "birthDate": birthDate
    };
  }

  @override
  String toString() {
    return "User {userId: $userId, username: $username, hashedPassword: $hashedPassword,"
      "email: $email, birthDate: $birthDate}";
  }


  static Future<List<User>> list({String? whereConditions, List<Object>? whereArgs}) async {
    final db = await DatabaseHelper.getDb();

    final List<Map<String, Object?>> userMaps = await db.query(tableName, where: whereConditions, whereArgs: whereArgs);

    return [
      for (final {
      "a_user_id": userId as int,
      "a_username": username as String,
      "a_password": hashedPassword as String,
      "a_email": email as String,
      "a_birth_date": birthDate as String
      } in userMaps)
        User(
          userId: userId,
          username: username,
          hashedPassword: hashedPassword,
          email: email,
          birthDate: DateTime.parse(birthDate)
        ),
    ];
  }

  static String hashPassword(String password) {
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static ClipRRect getUserPic({int? presetUserPicNumber, String? username}) {
    String userPicPath = "assets/images/user_pic/";
    if (presetUserPicNumber != null) {
      final String presetNumber = presetUserPicNumber.toString().padLeft(2, "0");
      userPicPath += "presets/preset_user_pic_$presetNumber.png";
    } else {
      userPicPath += "${username}_avatar.png";
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(60),
      child: Image(
        image: AssetImage(userPicPath),
        width: 120,
      ),
    );
  }

  Future<void> register() async {
    final db = await DatabaseHelper.getDb();

    await db.insert(
      tableName,
      toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> login() async {
    final db = await DatabaseHelper.getDb();
    List<Map<String, Object?>> usersFound = [];

    usersFound = await db.query(
      tableName,
      where: 'a_username = ? AND a_password = ?',
      whereArgs: [username, hashedPassword]
    );

    return usersFound.length == 1;
  }


  Future<void> update() async {
    final db = await DatabaseHelper.getDb();

    await db.update(
      tableName,
      toMap(),
      where: 'id = ?',
      whereArgs: [userId],
    );
  }

  Future<void> deleteDog() async {
    final db = await DatabaseHelper.getDb();

    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}

