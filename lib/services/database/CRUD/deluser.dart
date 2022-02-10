import 'package:userintegration/services/database/databasehelper.dart';

class DeleteUser {
  Future<void> delete(int? id) async {
    final db = await DatabaseHandler().initializeDB();
    await db.delete(
      'users',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
