import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'todo_model.dart';
import 'utils.dart';

String taskNumber = '12 tasks';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key) {
    TodoListModel().getSavedTodos();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LayoutBuilder(
        builder: (context, constraints) {
          return SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.lightBlueAccent
                ),
                backgroundColor: Colors.lightBlueAccent,
                actions: [
                  IconButton(
                      onPressed: () {
                        Provider.of<TodoListModel>(context, listen: false)
                            .clearTodos();
                      },
                      icon: const Icon(Icons.delete))
                ],
                shadowColor: Colors.transparent,
              ),
              backgroundColor: Colors.lightBlueAccent,
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 20, top: 30),
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
                            '${Provider.of<TodoListModel>(context).todoLength} Todos',
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
                        ),
                      ),
                      child: Scrollable(
                        physics: const BouncingScrollPhysics(),
                        viewportBuilder: (context, viewPortOffset) {
                          return const TodoeyList();
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
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return const TodoBottomSheet();
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
