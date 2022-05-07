import 'package:flutter/material.dart';
import "dart:async";

import 'package:provider/provider.dart';
import 'package:timetable/provider/todo_provider.dart';

class TodoList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final todoListProvider = Provider.of<TodoListProvider>(context);
    List<Map<String, String>> todoList = todoListProvider.getTodo();

    if (todoList.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 10),
        child: Align(alignment: Alignment.center, child: Text('Nothing 😎')),
      );
    } else if (todoList.isNotEmpty) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return TodoCard(
              term: todoList[index]['term'],
              taskValue: todoList[index]['value']);
        },
        itemCount: todoList.length,
      );
    } else {
      return const Text('?');
    }
  }
}

// タスクカード
class TodoCard extends StatefulWidget {
  TodoCard({
    Key? key,
    required this.term,
    required this.taskValue,
  }) : super(key: key);

  final String? term;
  final String? taskValue;

  @override
  _TodoCardState createState() => _TodoCardState();
}

class _TodoCardState extends State<TodoCard> {
  bool isChecked = false;

  Widget build(BuildContext context) {
    final todoListProvider = Provider.of<TodoListProvider>(context);

    return Container(
      margin: const EdgeInsets.only(top: 12, left: 15, right: 15),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 0.1,
            blurRadius: 2.0,
            offset: Offset(0, 3),
          )
        ],
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).bottomAppBarColor,
      ),
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Checkbox(
                value: isChecked,
                onChanged: (bool? value) async {
                  setState(() {
                    isChecked = value!;
                  });
                  await Future.delayed(const Duration(seconds: 1));
                  isChecked = false;
                  todoListProvider.rmTodo(widget.term!, widget.taskValue!);
                }),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.term!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.taskValue!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
