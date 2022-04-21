import 'package:flutter/material.dart';

import 'package:timetable/screen/syllabus_screen/widget/typography.dart';

class SyllabusContentsA extends StatelessWidget {
  const SyllabusContentsA({
    Key? key,
    required this.contents,
  }) : super(key: key);

  final List<dynamic> contents;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SyllabusTitle(value: contents[0]['courseTitle']),
        SizedBox(
          width: double.infinity,
          child: Text(
            contents[0]['teacher'],
            style: const TextStyle(
              color: Color(0xffff7447),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Body(value: '${contents[0]['title'] + ' ' + contents[0]['folder']}'),
        Body(
            value:
                '${contents[0]['semester'] + '  ' + contents[0]['weekdayPeriod'] + '  単位数 ' + contents[0]['credits']}'),
      ],
    );
  }
}
