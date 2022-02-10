import 'package:sqflite/sqflite.dart';
import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/services/database/databasehelper.dart';

class Userop {
  Future<int> insertUser(User user) async {
    int result = 0;
    final Database db = await DatabaseHandler().initializeDB();

    result = await db.insert('users', user.toMap());

    print(result);
    return result;
  }
}
