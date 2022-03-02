import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'todo_model.dart';

class TodoBottomSheet extends StatelessWidget {
  const TodoBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (context) {
        return Container(
          color: const Color(0xff757575),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Scrollable(
              viewportBuilder: (context, _) {
                String todo = '';
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Add Todo',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                    ),
                    TextField(
                      autofocus: true,
                      autocorrect: true,
                      style: const TextStyle(
                        fontSize: 25,
                      ),
                      onChanged: (value) {
                        todo = value;
                        print(todo);
                      },
                      onSubmitted: (value) {
                        Provider.of<TodoListModel>(context, listen: false)
                            .addTodo(TodoModel(todo: todo));
                      },
                    ),
                    ElevatedButton(
                      onPressed: () {
                        print(todo);
                        // Provider.of<TodoListModel>(context, listen: false)
                        //     .addTodo(TodoModel(todo: todo));
                        Navigator.of(context).pop();
                      },
                      child: const Text('Done'),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class TodoeyList extends StatelessWidget {
  const TodoeyList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListModel>(
      builder: (context, todoListModel, child) {
        return ListView.builder(
          itemCount: todoListModel.todos.length,
          itemBuilder: (context, index) {
            var todos = todoListModel.todos;
            return TodoListTile(
              (newCheckedValue) {
                todoListModel.updateTodo(
                  todos[index],
                  newCheckedValue,
                );
              },
              todos[index],
              deleteTodo: (){
                todoListModel.deleteTodo(todos[index], index);
              },
            );
          },
        );
      },
    );
  }
}

class TodoListTile extends StatelessWidget {
  final TodoModel todo;
  final Function(bool newChecked) updateCheckedBox;
  final VoidCallback? deleteTodo;

  const TodoListTile(this.updateCheckedBox, this.todo,
      {Key? key, this.deleteTodo})
      : super(key: key); //constructor

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: (todo.todoDone!) ? IconButton(
        onPressed: deleteTodo!,
        icon: const Icon(Icons.delete),
      ): null,
      title: Text(
        todo.todo!,
        style: TextStyle(
            decoration: todo.todoDone! ? TextDecoration.lineThrough : null),
      ),
      trailing: TodoCheckedBox(
          todo.todoDone!, (newValue) => updateCheckedBox(newValue!)),
    );
  }
}

class TodoCheckedBox extends StatelessWidget {
  final bool _value;
  final Function(bool? newValue) checkedCallback;

  const TodoCheckedBox(this._value, this.checkedCallback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: _value,
      onChanged: checkedCallback,
    );
  }
}
