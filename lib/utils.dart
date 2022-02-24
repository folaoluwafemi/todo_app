import 'package:flutter/material.dart';
import 'todo_model.dart';
import 'home_screen.dart';


class TodoBottomSheet extends StatefulWidget{
  final Function fromParent;
  const TodoBottomSheet(this.fromParent, {Key? key}) : super(key: key);

  @override
  _TodoBottomSheetState createState() => _TodoBottomSheetState();
}

class _TodoBottomSheetState extends State<TodoBottomSheet> {

  String todo = '';
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {
      },
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
            child: Column(
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
                  onChanged: (value){
                    todo = value;
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    todos.add(TodoModel(todo: todo, todoDone: false));
                    widget.fromParent();
                    Navigator.of(context).pop();
                  },
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TodoListTile extends StatefulWidget {
  final TodoModel todo;
  const TodoListTile(this.todo, {Key? key}) : super(key: key); //constructor
  @override
  _TodoListTileState createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {

  _TodoListTileState();

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.todo.todo!,
        style:
        TextStyle(decoration: widget.todo.todoDone! ? TextDecoration.lineThrough : null),
      ),
      trailing:
      TodoCheckedBox(widget.todo.todoDone!, (newValue) => updateCheckedBox(newValue!)),
    );
  }

  void updateCheckedBox(bool newChecked) {
    setState(() {
      taskNumber = '${todos.length} tasks';
      widget.todo.set(newChecked);
    });
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
