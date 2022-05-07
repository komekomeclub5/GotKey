import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/my_timetable_provider.dart';
import 'package:timetable/provider/day_selected_provider.dart';
import 'package:timetable/screen/timetable_screen/widget/my_timetable_list.dart';
import 'package:timetable/screen/syllabus_screen/syllabus_screen.dart';

import 'package:timetable/screen/timetable_screen/widget/my_timetable.dart';
import 'package:timetable/screen/search_screen/search_screen.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _TimeTableScreenState createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '時間割',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: MyTimetable(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (BuildContext context) {
            return const SearchScreen(title: '講義検索');
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

Widget todayTimetable(BuildContext context) {
  final myTimeTable = Provider.of<MyTimetableProvider>(context);
  final table = myTimeTable.getTimetable();
  final selected = Provider.of<DaySelectedProvider>(context);

  var selectedDayList = table
      .where((Map<String, String> value) => value['day'] == selected.getDay())
      .toList();

  if (selectedDayList.isNotEmpty) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: selectedDayList.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: MyTimeTableList(
              day: selectedDayList[index]['day'].toString(),
              time: selectedDayList[index]['time'].toString(),
              courseTitle: selectedDayList[index]['courseTitle'].toString(),
              teacher: selectedDayList[index]['teacher'].toString(),
              classroom: selectedDayList[index]['classroom'].toString(),
              duplicate:
                  myTimeTable.dupulicateTimetable(selectedDayList[index]),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SyllabusScreen(
                  day: selectedDayList[index]['day'].toString(),
                  time: selectedDayList[index]['time'].toString(),
                  season: selectedDayList[index]['season'].toString(),
                  courseTitle: selectedDayList[index]['courseTitle'].toString(),
                  teacher: selectedDayList[index]['teacher'].toString(),
                  classroom: selectedDayList[index]['classroom'].toString(),
                ),
              ),
            ),
          );
        });
  } else {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(50),
          height: 300,
          width: 300,
          child: Image.asset('assets/images/kodama.png', fit: BoxFit.contain),
        ),
        const Text('ぜんきゅーーーー！')
      ],
    );
  }
}
