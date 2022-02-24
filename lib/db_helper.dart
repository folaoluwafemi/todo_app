import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart' as sqlite;
import 'package:todoey/todo_model.dart' as todo_model;

const String todoTableName = 'TodosTable';
const String colTodos = 'Todos';
const String colFinished = 'DoneTodo';

class DbHelper {
  DbHelper._singletonConstructor();

  static var instance = DbHelper._singletonConstructor();

  static sqlite.Database? _database;

  Future<sqlite.Database> get database async {
    if (_database == null) {
      _database = await createDatabase();
      return _database!;
    }
    return _database!;
  }

  Future<sqlite.Database> createDatabase() async {
    var dbPath = path.join(await _getLocalPath(), 'TodoDatabase.db');

    return await sqlite.openDatabase(dbPath, version: 1,
        onCreate: (db, version) async {
      await db.execute('''
            CREATE TABLE IF NOT EXISTS $todoTableName(
              $colTodos TEXT NOT NULL,
              $colFinished TEXT NOT NULL)
          ''');
    });
  }

  dynamic insertIntoDatabase(Map<String, Object?> values) async {
    (await instance.database).transaction((txn) async {
      await txn.insert(
        todoTableName,
        values,
      );
    });
  }

  dynamic insertMultipleIntoDatabase(List<Map<String, Object?>> values) async {
    for (var element in values) {
      (await instance.database).transaction((txn) async {
        await txn.insert(
          todoTableName,
          element,
        );
      });
    }
  }

  Future<List<todo_model.TodoModel>> queryDatabase() async {
    List<Map<String, Object?>> output = [];
    output = await (await instance.database).transaction((txn) async {
      return await txn.query(todoTableName);
    });
    return List.generate(output.length, (i) {
      return todo_model.TodoModel(
        todo: output[i][colTodos].toString(),
        todoDone: stringToBool(output[i][colFinished].toString()),
      );
    });
  }
}

Future<String> _getLocalPath() async {
  return (await path_provider.getApplicationDocumentsDirectory()).path;
}

bool stringToBool(String boolString) {
  if (boolString == 'true') {
    return true;
  } else {
    return false;
  }
}
