import 'package:flutter/material.dart';

import 'db_helper.dart' as db_helper;
import 'todo_model.dart';
import 'utils.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);
  List<TodoModel> todos = [TodoModel(todo: 'this is a todo', todoDone: false)];

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String taskNumber = '';

  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // taskNumber = '${todos.length} tasks';
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    taskNumber = '${widget.todos.length} tasks';
    initializeState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
              backgroundColor: Colors.lightBlueAccent,
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 60),
                    color: Colors.lightBlueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth - 20.0,
                        ),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Icon(
                            Icons.list,
                            size: 40,
                            color: Colors.lightBlueAccent,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Todoey',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            taskNumber,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.only(top: 18),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Scrollable(
                        physics: const BouncingScrollPhysics(),
                        viewportBuilder: (context, viewPortOffset) {
                          return TodoeyList(
                            widget.todos,
                            intializeList: (newTodos) {
                              widget.todos = newTodos;
                              initializeStateAsync(newTodos);
                            },
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.add),
                backgroundColor: Colors.lightBlueAccent,
                onPressed: () {
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) {
                  //   return const TodoBottomSheet();
                  // }));
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return TodoBottomSheet((newTodo) async {
                        setState(() {
                          widget.todos.add(newTodo);
                          initializeStateAsync(widget.todos);
                          taskNumber = '${widget.todos.length} tasks';
                        });
                      });
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void initializeStateAsync(List<TodoModel> newTodosList) async {
    widget.todos = await db_helper.DbHelper.instance.queryDatabase();
    List<Map<String, Object?>> newList = [];
    for (var element in newTodosList) {
      newList.add(element.toMap());
    }
    (await db_helper.DbHelper.instance.insertMultipleIntoDatabase(newList));
  }

  void initializeState() {
    setState(() {
      initializeStateAsync(widget.todos);
    });
  }
}

class TodoeyList extends StatelessWidget {
  final Function(List<TodoModel> todos)? intializeList;
  final List<TodoModel> todos;

  const TodoeyList(this.todos, {Key? key, this.intializeList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        intializeList!(todos);
        return TodoListTile(
          todos[index],
          updateTodo: (newTodo) {
            for (var element in todos) {
              if (element.todo == newTodo.todo) {
                element = newTodo;
              }
            }
          },
        );
      },
    );
  }
}
