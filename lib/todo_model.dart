import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoey/shared_preference.dart';

class TodoModel{
  final String? todo;
  bool? todoDone;

  TodoModel({@required this.todo, this.todoDone = false});

  // Map<String, Object?> toMap(){
  //   return {
  //     db_helper.colTodos: todo!,
  //     db_helper.colFinished: _boolToString(todoDone!)
  //   };
  // }
  static String boolToString(bool boolean){
    return (boolean) ? "true" : "false";
  }

  static bool stringToBool(String boolean){
    if(boolean == "true"){
      return true;
    } else if(boolean == "false"){
      return false;
    }
    else{
      return false;
    }
  }

  set(bool newValue){
    todoDone = newValue;
  }
}


class TodoListModel extends ChangeNotifier{

  var _myTodos = [TodoModel(todo: "new todo"), TodoModel(todo: "another todo"), TodoModel(todo: "another other todo")];
  TodoListModel(){
    getSavedTodos();
  }

  List<TodoModel> get todos {
    getSavedTodos();
    return _myTodos;
  }
  int get todoLength {
    return todos.length;
  }
  void addTodo(TodoModel newTodo){
    MySharedPrefs.addTodo(newTodo);
    getSavedTodos();
    notifyListeners();
  }
  void clearTodos(){
    todos.clear();
    MySharedPrefs.deleteAll();
    notifyListeners();
  }
  void updateTodo(TodoModel todo, bool newValue){
    MySharedPrefs.updateTodo(todo, newValue);
    getSavedTodos();
    notifyListeners();
  }
  void deleteTodo(TodoModel todo, int index) async {
    MySharedPrefs.deleteTodo(todo);
    getSavedTodos();
    notifyListeners();
  }

  void getSavedTodos() async {
    _myTodos = await MySharedPrefs.getTodos();
  }
}