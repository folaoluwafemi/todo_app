import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'utils.dart';

List<TodoModel> todos = [TodoModel(todo: 'this is a todo', todoDone: false)];
String taskNumber = '${todos.length} tasks';
bool todosAdded = false;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    taskNumber = '${todos.length} tasks';
    super.didUpdateWidget(oldWidget);
  }

  dynamic parentSetStateCallBack() {
    setState(() {
      taskNumber = '${todos.length} tasks';
    });
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
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: Scrollable(
                        physics: const BouncingScrollPhysics(),
                        viewportBuilder: (context, viewPortOffset) {
                          return ListView.builder(
                            itemCount: todos.length,
                            itemBuilder: (context, index) {
                              return TodoListTile(todos[index]);
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
                      return TodoBottomSheet(() {
                        setState(() {
                          taskNumber = '${todos.length} tasks';
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
}
