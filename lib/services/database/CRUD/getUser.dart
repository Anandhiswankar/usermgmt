import 'package:sqflite/sqflite.dart';
import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/services/database/databasehelper.dart';

class getUsers {
  Future<List<User>> retrieveUsers() async {
    final Database db = await DatabaseHandler().initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('users');
    return queryResult.map((e) => User.fromMap(e)).toList();
  }
}
