import 'package:flutter/material.dart';

import 'package:timetable/screen/todo_list_screen/add_todo_screen.dart';
import 'package:timetable/screen/todo_list_screen/widget/task_card.dart';

class TodoScreen extends StatelessWidget {
  const TodoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('やることリスト',
              style: TextStyle(fontWeight: FontWeight.w600))),
      body: SingleChildScrollView(child: TodoList()),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return TodoAddPage();
          }));
        },
        label: const Text('追加'),
        icon: const Icon(Icons.add),
        backgroundColor: const Color(0xffff7447),
        foregroundColor: Colors.white,
      ),
    );
  }
}
