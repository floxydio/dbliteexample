import 'package:dblitetesting/models/todos_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();

    return openDatabase(
      join(path, 'database.db'),
      onCreate: (database, version) async {
        await database.execute(
            "CREATE TABLE todos(id TEXT NOT NULL,title TEXT NOT NULL)");
      },
      version: 1,
    );
  }

  Future<int> createTodo(Todos todosModel) async {
    print(todosModel.toMap());
    final Database db = await initializeDB();
    final id = await db.insert(
        "todos", {'id': todosModel.id, 'title': todosModel.title},
        conflictAlgorithm: ConflictAlgorithm.replace);
    getItem();
    return id;
  }

  Future<List<Todos>> getItem() async {
    final db = await initializeDB();
    final List<Map<String, Object?>> queryResult = await db.query("todos");
    print(queryResult);
    return queryResult.map((e) => Todos.fromMap(e)).toList();
  }
}
