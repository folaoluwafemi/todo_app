import 'package:shared_preferences/shared_preferences.dart';
import 'package:todoey/todo_model.dart';

class MySharedPrefs {
  static var sharedPrefs = SharedPreferences.getInstance();

  static void addTodo(TodoModel newTodo) async {
    String todoText = newTodo.todo!;
    String todoDone = TodoModel.boolToString(newTodo.todoDone!);

    await (await sharedPrefs).setString(todoText, todoDone);
  }

  static void addMultiple(List<TodoModel> todos) {
    for (var element in todos) {
      addTodo(element);
    }
  }


  static void updateTodo(TodoModel todo, bool newValue) async {
    await (await sharedPrefs).setString(todo.todo!, TodoModel.boolToString(newValue));
  }


  static void deleteAll() async {
    await (await sharedPrefs).clear();
  }
  static void deleteTodo(TodoModel todo) async {
    await (await sharedPrefs).remove(todo.todo!);
  }
  static Future<List<TodoModel>> getTodos() async {
    Set todoKeys = (await sharedPrefs).getKeys();
    List<TodoModel> newTodoList = [];

    for (var elements in todoKeys) {
      bool todoDone =
          TodoModel.stringToBool((await sharedPrefs).get(elements).toString());

      newTodoList.add(TodoModel(todo: elements, todoDone: todoDone));
    }

    return newTodoList;
  }
}
