import 'package:flutter/cupertino.dart';
import 'db_helper.dart' as db_helper;

class TodoModel{
  final String? todo;
  bool? todoDone;

  TodoModel({@required this.todo, @required this.todoDone});

  Map<String, Object?> toMap(){
    return {
      db_helper.colTodos: todo!,
      db_helper.colFinished: _boolToString(todoDone!)
    };
  }
  String _boolToString(bool boolean){
    return (boolean) ? "true" : "false";
  }

  set(bool newValue){
    todoDone = newValue;
  }
}