import 'package:flutter/material.dart';

class ResultList extends StatelessWidget {
  const ResultList({
    Key? key,
    required this.day,
    required this.time,
    required this.season,
    required this.courseTitle,
    required this.teacher,
    required this.classroom,
    required this.additionalInformation,
  }) : super(key: key);

  final String day;
  final String time;
  final String season;
  final String courseTitle;
  final String teacher;
  final String classroom;
  final String additionalInformation;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
        border: Border.all(width: 2.0, color: const Color(0xff707070)),
      ),
      child: Container(
        margin: const EdgeInsets.all(12.0),
        child: Row(
          children: <Widget>[
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
                      '$day$time　$teacher　$classroom　$additionalInformation',
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
            const Icon(IconData(0xe41d, fontFamily: 'MaterialIcons'))
          ],
        ),
      ),
    );
  }
}
