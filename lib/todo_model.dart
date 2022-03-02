import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  // String _boolToString(bool boolean){
  //   return (boolean) ? "true" : "false";
  // }

  set(bool newValue){
    todoDone = newValue;
  }
}


class TodoListModel extends ChangeNotifier{
  List<TodoModel> todos = [TodoModel(todo: "new todo"), TodoModel(todo: "another todo"), TodoModel(todo: "another other todo")];
  TodoListModel();

  int get todoLength {
    return todos.length;
  }
  void addTodo(TodoModel newTodo){
    todos.add(newTodo);
    notifyListeners();
  }
  void clearTodos(){
    todos.clear();
    notifyListeners();
  }
  void updateTodo(TodoModel todo, bool newValue){
    todo.set(newValue);
    notifyListeners();
  }
  void deleteTodo(TodoModel todo, int index){
    todos.remove(todo);
    notifyListeners();
  }
}