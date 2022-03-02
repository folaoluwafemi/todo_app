import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/home_screen.dart';
import 'package:todoey/todo_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TodoListModel(),
      child: const HomeScreen(),
    );
  }
}
