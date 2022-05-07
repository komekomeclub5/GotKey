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
            Expanded(
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      courseTitle,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
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
