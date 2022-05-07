import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/my_timetable_provider.dart';

import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TodaysTimetable extends StatelessWidget {
  const TodaysTimetable({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        .where((Map<String, String> value) =>
            value['day'] == formatStrForDayOfWeek)
        .toList();

    if (toDayList.isNotEmpty) {
      return SizedBox(
          height: 140,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: toDayList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return timetableCard(
                          context,
                          courseTitle:
                              toDayList[index]['courseTitle'].toString(),
                          teacher: toDayList[index]['teacher'].toString(),
                          classroom: toDayList[index]['classroom'].toString(),
                          time: toDayList[index]['time'].toString(),
                          now: nowResult.toString(),
                        );
                      }))));
    } else if (table.isEmpty) {
      return const Text('講義検索から、取りたい講義を探してみよう!');
    } else {
      return const Align(
        alignment: Alignment.center,
        child: Text(
          'ぜんきゅ〜 🎉 🏕 🏖 🚗 🚐 🎳 🎰 🍣 🍩 🐔 🐴',
        ),
      );
    }
  }
}

Widget timetableCard(BuildContext context,
    {String? courseTitle,
    String? teacher,
    String? classroom,
    String? time,
    String? now}) {
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
    alignment: Alignment.centerLeft,
    child: Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 10, bottom: 10),
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
        color: now == time
            ? const Color(0xfff8d395)
            : Theme.of(context).bottomAppBarColor,
      ),
      child: Container(
          margin: const EdgeInsets.all(12.0),
          width: 130,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      timesString[timeInt],
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: now == time
                            ? Colors.black87
                            : Theme.of(context).textTheme.bodyMedium!.color,
                      ),
                    ),
                  ),
                  Text(
                    classroom!,
                    style: TextStyle(
                      fontSize: 12,
                      color: now == time
                          ? Colors.black87
                          : Theme.of(context).textTheme.bodyMedium!.color,
                    ),
                  ),
                ],
              ),
              Container(
                height: 55,
                alignment: Alignment.bottomLeft,
                child: Text(
                  courseTitle!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: now == time
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
                    fontSize: 12,
                    color: now == time
                        ? Colors.black87
                        : Theme.of(context).textTheme.bodyMedium!.color,
                  ),
                ),
              )
            ],
          )),
    ),
  );
}
