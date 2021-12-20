import 'package:moodamay/Models/user_mood.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'moodamay.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE user_mood(id INTEGER PRIMARY KEY AUTOINCREMENT, mood_name TEXT NOT NULL, mood_image TEXT NOT NULL, date TEXT NOT NULL, note TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<int> insertMood(UserMood mood) async {
    int result = 0;
    final Database db = await initializeDB();
    result = await db.insert('user_moods', mood.toMap());

    return result;
  }

  Future<List<UserMood>> getMoods() async {
    final Database db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query('user_moods');
    return queryResult.map((e) => UserMood.fromMap(e)).toList();
  }

  Future<void> deleteMood(int id) async {
    final db = await initializeDB();
    await db.delete(
      'user_moods',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
