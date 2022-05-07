import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/todo_provider.dart';

class TodoAddPage extends StatefulWidget {
  @override
  _TodoAddPageState createState() => _TodoAddPageState();
}

class _TodoAddPageState extends State<TodoAddPage> {
  DateTime? _selectedDate;
  String todoValue = '';
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoList = Provider.of<TodoListProvider>(context);

    //bool textFieldNull = false;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'やることを追加する',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // 期限を入力
                TextField(
                  controller: _textEditingController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: '期限を選択',
                  ),
                  onTap: () {
                    _selectDate(context);
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 15)),
                // やることを入力
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    hintText: 'やることを入力',
                  ),
                  onChanged: (value) {
                    setState(() {
                      todoValue = value;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.only(top: 40)),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        // primary: const Color(0xff2b83b6),
                        primary: const Color(0xffff7447),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () async {
                        try {
                          todoList.setTodo(_selectedDate, todoValue);
                        } catch (e) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text('文字入れて'),
                          ));
                        }
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        '追加する',
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('キャンセル')),
                )
              ],
            )));
  }

  _selectDate(BuildContext context) async {
    //final newSelectedDate = await showDatePicker(
    //  context: context,
    //  initialDate: _selectedDate ?? DateTime.now(),
    //  firstDate: DateTime(0),
    //  lastDate: DateTime(2040),
    //);

    final newSelectedDate = await DatePicker.showDateTimePicker(context,
        showTitleActions: true,
        minTime: DateTime.now(),
        maxTime: DateTime(
            DateTime.now().year + 1, DateTime.now().month, DateTime.now().day),
        currentTime: DateTime.now(),
        locale: LocaleType.jp,
        theme: DatePickerTheme(
            backgroundColor: Theme.of(context).primaryColor,
            cancelStyle: Theme.of(context).textTheme.bodyMedium!,
            itemStyle: Theme.of(context).textTheme.bodyLarge!));

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      //_textEditingController.text = _selectedDate.toString();
      _textEditingController.text =
          DateFormat('yyyy年MM月dd日(E) HH:mm').format(_selectedDate!).toString();
    }
  }
}
