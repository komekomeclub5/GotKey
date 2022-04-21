import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/my_timetable_provider.dart';
import 'package:timetable/screen/home_screen/widget/greetings.dart';
import 'package:timetable/screen/home_screen/widget/todays_timetable.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    Provider.of<MyTimetableProvider>(context).getStore();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 15, right: 15),
            child: greetings(context),
          ),
          const Padding(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 15,
              right: 15,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Text(
                '今日の時間割',
                style: TextStyle(
                  color: Color(0xff4c4c4c),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),
          todayTimetable(context),
        ],
      ))),
    );
  }
}

Widget todayTimetable(BuildContext context) {
  final myTimeTable = Provider.of<MyTimetableProvider>(context);
  final table = myTimeTable.getTimetable();

  initializeDateFormatting('ja');
  final dateFormatForDayOfWeek = DateFormat.E('ja');
  final formatStrForDayOfWeek = dateFormatForDayOfWeek.format(DateTime.now());

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

  var toDayList = table
      .where(
          (Map<String, String> value) => value['day'] == formatStrForDayOfWeek)
      .toList();

  if (toDayList.isNotEmpty) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: toDayList.length,
        itemBuilder: (BuildContext context, int index) {
          return TodaysTimetable(
            courseTitle: toDayList[index]['courseTitle'].toString(),
            teacher: toDayList[index]['teacher'].toString(),
            classroom: toDayList[index]['classroom'].toString(),
            time: toDayList[index]['time'].toString(),
            now: nowResult.toString(),
          );
        });
  } else if (table.isEmpty) {
    return const Text('講義検索から、取りたい講義を探してみよう!');
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
