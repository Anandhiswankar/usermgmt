import 'package:userintegration/models/userModel.dart';
import 'package:userintegration/services/database/databasehelper.dart';

class UpdateUser {
  Future<void> update(int? id, User user) async {
    final db = await DatabaseHandler().initializeDB();
    await db.update(
      'users',
      user.toMap(),
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
