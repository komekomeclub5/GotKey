import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:timetable/provider/my_timetable_provider.dart';

import 'package:timetable/screen/syllabus_screen/widget/syllabus_A.dart';
import 'package:timetable/screen/syllabus_screen/widget/syllabus_B.dart';

class SyllabusScreen extends StatefulWidget {
  const SyllabusScreen({
    Key? key,
    required this.day,
    required this.time,
    required this.season,
    required this.courseTitle,
    required this.teacher,
    required this.classroom,
  }) : super(key: key);

  final String day;
  final String time;
  final String season;
  final String courseTitle;
  final String teacher;
  final String classroom;

  @override
  _SyllabusScreenState createState() => _SyllabusScreenState();
}

class _SyllabusScreenState extends State<SyllabusScreen> {
  List<dynamic> syllabus = [];

  void fetchSentence() async {
    var uri = Uri(
        scheme: 'https',
        host: 'shining-axis-326714.an.r.appspot.com',
        path: '/syllabus',
        queryParameters: {
          'day': widget.day,
          'time': widget.time,
          'season': widget.season,
          'courseTitle': widget.courseTitle,
          'teacher': widget.teacher,
        });

    //print(uri);

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      try {
        Map<String, dynamic> syllabusList = jsonDecode(data);

        setState(() {
          syllabus = syllabusList['syllabus'] as List;
        });
      } catch (e) {
        Navigator.of(context).pop();
        loaderror(context);
      }
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSentence();
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> loaderror(
      BuildContext context) {
    final myTimeTable =
        Provider.of<MyTimetableProvider>(context, listen: false);
    final course = <String, String>{
      'day': widget.day,
      'time': widget.time,
      'season': widget.season,
      'courseTitle': widget.courseTitle,
      'teacher': widget.teacher,
      'classroom': widget.classroom,
    };
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(
      children: [
        const Expanded(child: Text('シラバスが\n見つかりませんでした🙏')),
        TextButton(
            onPressed: (() {
              if (myTimeTable.onTheTimetable(course)) {
                myTimeTable.removeTimetable(course);
              } else if (myTimeTable.dupulicateTimetable(course) == false) {
                myTimeTable.addTimetable(course);
              }
            }),
            child: myTimeTable.onTheTimetable(course)
                ? const Text(
                    '- 時間割から削除',
                    style: TextStyle(color: Colors.red),
                  )
                : myTimeTable.dupulicateTimetable(course)
                    ? const Text('重複してます',
                        style: TextStyle(color: Colors.black54))
                    : const Text('+ 時間割に追加',
                        style: TextStyle(color: Colors.blue))),
      ],
    )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('シラバス', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: result(syllabus),
      ),
    );
  }

  Widget result(List<dynamic> syllabus) {
    final myTimeTable = Provider.of<MyTimetableProvider>(context);
    final course = <String, String>{
      'day': widget.day,
      'time': widget.time,
      'season': widget.season,
      'courseTitle': widget.courseTitle,
      'teacher': widget.teacher,
      'classroom': widget.classroom,
    };

    if (syllabus.isEmpty) {
      return const Text("読み込み中・・・", textAlign: TextAlign.center);
    } else {
      return SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: SyllabusContentsA(contents: syllabus),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: const TextStyle(fontSize: 15),
              ),
              onPressed: () {
                if (myTimeTable.onTheTimetable(course)) {
                  myTimeTable.removeTimetable(course);
                } else if (myTimeTable.dupulicateTimetable(course) == false) {
                  myTimeTable.addTimetable(course);
                }
              },
              child: myTimeTable.onTheTimetable(course)
                  ? const Text(
                      '- 時間割から削除',
                      style: TextStyle(color: Colors.red),
                    )
                  : myTimeTable.dupulicateTimetable(course)
                      ? Text(
                          '${course['day']}${course['time']}と重複してます...🥺\n削除してから追加してください。',
                          style: const TextStyle(color: Colors.black54))
                      : const Text('+ 時間割に追加',
                          style: TextStyle(color: Colors.blue)),
            ),
          ),
          SyllabusContentsB(contents: syllabus),
        ]),
      );
    }
  }
}
