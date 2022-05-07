import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/my_timetable_provider.dart';
import 'package:timetable/provider/todo_provider.dart';
import 'package:timetable/screen/home_screen/widget/greetings.dart';
import 'package:timetable/screen/home_screen/widget/todo_title.dart';
import 'package:timetable/screen/home_screen/widget/todays_timetable.dart';

// タスクカード
import 'package:timetable/screen/todo_list_screen/widget/task_card.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatelessWidget with WidgetsBindingObserver {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ja');
    final today = DateFormat('yyyy年MM月dd日(EEE)', 'ja').format(DateTime.now());
    //var time = DateTime.now();

    Provider.of<MyTimetableProvider>(context).getStore();
    Provider.of<TodoListProvider>(context).getStore();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          today,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: greetings(context),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: TodaysTimetable(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: todoTitle(context),
          ),
          TodoList(),
        ],
      ))),
    );
  }
}
