import 'package:flutter/material.dart';

class TodaysTimetable extends StatelessWidget {
  const TodaysTimetable({
    Key? key,
    required this.courseTitle,
    required this.teacher,
    required this.classroom,
    required this.time,
    required this.now,
  }) : super(key: key);

  final String courseTitle;
  final String teacher;
  final String classroom;
  final String time;
  final String now;

  @override
  Widget build(BuildContext context) {
    int timeInt = int.parse(time);
    List timesString = [
      '~ 9:00',
      '9:00\n10:30',
      '10:40\n12:10',
      '13:00\n14:30',
      '14:40\n16:10',
      '16:20\n17:50',
      '18:00\n19:30',
      '19:30 ~',
    ];

    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: now == time ? const Color(0xfff8d395) : Colors.white,
        border: Border.all(width: 2.0, color: const Color(0xff707070)),
      ),
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 20.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    timesString[timeInt],
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color(0xff4c4c4c),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      courseTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xff4c4c4c),
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '$teacher　$classroom',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xff4c4c4c),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
            // const Icon(IconData(0xe41d, fontFamily: 'MaterialIcons'))
          ],
        ),
      ),
    );
  }
}
