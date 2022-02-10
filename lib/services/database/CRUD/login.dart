import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/services/database/databasehelper.dart';

class Login {
  Future<User?> checkLogin(String userName, String password) async {
    final dbClient = await DatabaseHandler().initializeDB();
    var res = await dbClient.rawQuery(
        "SELECT * FROM users WHERE email = '$userName' and password = '$password'");

    if (res.length > 0) {
      return new User.fromMap(res.first);
    }

    return null;
  }
}
