import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/my_timetable_provider.dart';
import 'package:timetable/screen/syllabus_screen/syllabus_screen.dart';

class MyTimetable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      constrained: false,
      minScale: 0.001,
      maxScale: 10,
      boundaryMargin: const EdgeInsets.all(2),
      child: buildPlaid(context),
    );
  }
}

Widget buildPlaid(BuildContext context) {
  final myTimeTable = Provider.of<MyTimetableProvider>(context);
  final table = myTimeTable.getTimetable();

  final dateFormatForDayOfWeek = DateFormat.E('ja');
  final formatStrForDayOfWeek = dateFormatForDayOfWeek.format(DateTime.now());

  var dayString = ['月', '火', '水', '木', '金', '土'];

  var nowTime = DateTime.now();

  List<TimeOfDay> times = const [
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 10, minute: 30),
    TimeOfDay(hour: 12, minute: 10),
    TimeOfDay(hour: 14, minute: 30),
    TimeOfDay(hour: 16, minute: 10),
    TimeOfDay(hour: 17, minute: 50),
    TimeOfDay(hour: 19, minute: 30),
    TimeOfDay(hour: 21, minute: 00),
    TimeOfDay(hour: 23, minute: 59),
  ];

  var nowResult = 0;
  for (int i = 0; i < 8; i++) {
    if (nowTime.isBefore(DateTime(nowTime.year, nowTime.month, nowTime.day,
        times[i].hour, times[i].minute))) {
      nowResult = i;
      break;
    }
  }

  List<Widget> _list = [];
  List<Widget> _listCache = [];

  for (int i = 1; i < 8; i++) {
    for (int j = 0; j < 6; j++) {
      var setTable = table
          .where((element) =>
              element['day'] == dayString[j] && element['time'] == i.toString())
          .toList();

      _listCache.add(Container(
          width: 20,
          height: 17,
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              border: Border.all(width: 0.1, color: Colors.black12)),
          child: setTable.isNotEmpty
              ? GestureDetector(
                  child: boxText(context,
                      courseTitle: setTable[0]['courseTitle'],
                      teacher: setTable[0]['teacher'],
                      classroom: setTable[0]['classroom'],
                      time: setTable[0]['time'],
                      now: setTable[0]['day'] == formatStrForDayOfWeek &&
                              setTable[0]['time'] == nowResult.toString()
                          ? true
                          : false),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SyllabusScreen(
                        day: setTable[0]['day'].toString(),
                        time: setTable[0]['time'].toString(),
                        season: setTable[0]['season'].toString(),
                        courseTitle: setTable[0]['courseTitle'].toString(),
                        teacher: setTable[0]['teacher'].toString(),
                        classroom: setTable[0]['classroom'].toString(),
                      ),
                    ),
                  ),
                )
              : const Text('')));
    }
    _list.add(Row(
      children: _listCache,
    ));
    _listCache = [];
  }

  return Column(
    children: _list,
  );
}

Widget boxText(BuildContext context,
    {String? courseTitle,
    String? teacher,
    String? classroom,
    String? time,
    bool? now}) {
  int timeInt = int.parse(time!);
  List timesString = [
    ' ',
    '9:00',
    '10:40',
    '13:00',
    '14:40',
    '16:20',
    '18:00',
    '20:10',
  ];

  return Container(
    margin: const EdgeInsets.all(1.0),
    padding: const EdgeInsets.all(1.5),
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          spreadRadius: 0.1,
          blurRadius: 0.05,
          offset: Offset(0, 0.3),
        )
      ],
      borderRadius: BorderRadius.circular(1.0),
      color: now == true
          ? const Color(0xfff8d395)
          : Theme.of(context).bottomAppBarColor,
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                timesString[timeInt],
                style: TextStyle(
                  fontSize: 2,
                  fontWeight: FontWeight.w600,
                  color: now == true
                      ? Colors.black87
                      : Theme.of(context).textTheme.bodyMedium!.color,
                ),
              ),
            ),
            Text(
              classroom!,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 1.5,
                height: 1.45,
                color: now == true
                    ? Colors.black87
                    : Theme.of(context).textTheme.bodyMedium!.color,
              ),
            ),
          ],
        ),
        Container(
          height: 7.5,
          alignment: Alignment.bottomLeft,
          child: Text(
            courseTitle!,
            style: TextStyle(
              fontSize: 2,
              fontWeight: FontWeight.w600,
              color: now == true
                  ? Colors.black87
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            teacher!,
            style: TextStyle(
              fontSize: 1.4,
              color: now == true
                  ? Colors.black87
                  : Theme.of(context).textTheme.bodyMedium!.color,
            ),
          ),
        )
      ],
    ),
  );
}
