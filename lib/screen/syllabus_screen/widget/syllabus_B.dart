//import 'dart:html';

import 'package:flutter/material.dart';

import 'package:timetable/screen/syllabus_screen/widget/typography.dart';

//class SyllabusContentsB extends StatefulWidget {
// List<dynamic> contents;
// const SyllabusContentsB({
//   Key? key,
//   required this.contents,
// }) : super(key: key);

// @override
// _SyllabusContentsBState createState() => _SyllabusContentsBState();
//}

class SyllabusContentsB extends StatelessWidget {
  final List<dynamic> contents;
  const SyllabusContentsB({
    Key? key,
    required this.contents,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<DataRow> _list = List.generate(16, (index) {
      return DataRow(
        cells: [
          DataCell(Text('${index + 1}')),
          DataCell(Text('${contents[0]['theme'][index]}')),
          DataCell(Text('${contents[0]['homework'][index]}')),
        ],
      );
    });

    return Container(
        margin: const EdgeInsets.only(bottom: 50.0),
        child: Column(children: <Widget>[
          //学びの準備
          const Heading(value: '学びの準備'),
          const HeadingSub(value: 'ねらい'),
          Body(value: contents[0]['aimLecture']),
          const HeadingSub(value: 'メッセージ'),
          Body(value: contents[0]['forStudents']),
          const HeadingSub(value: '到達目標'),
          Body(value: contents[0]['courseGoals']),

          //学びの実践
          const Heading(value: '学びの実践'),
          const HeadingSub(value: '授業計画'),
          Center(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: const [
                    DataColumn(
                      label: Text('回'),
                    ),
                    DataColumn(
                      label: Text('テーマ'),
                    ),
                    DataColumn(
                      label: Text('時間外学習の内容'),
                    ),
                  ],
                  rows: _list,
                )),
          ),

          const HeadingSub(value: 'テキスト・参考文献・資料など'),
          Body(value: contents[0]['references']),
          const HeadingSub(value: '学びの手立て'),
          Body(value: contents[0]['meansOfLearning']),
          const HeadingSub(value: '評価'),
          Body(value: contents[0]['evaluation']),

          //学びの継続
          const Heading(value: '学びの継続'),
          const HeadingSub(value: '次のステージ・関連科目'),
          Body(value: contents[0]['relatedSubjects'])
        ]));
  }
}
