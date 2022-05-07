import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:timetable/screen/search_result_screen/search_result_screen.dart';
import 'package:timetable/screen/search_screen/widget/course_filter_chip.dart'; // フィルターWidget
import 'package:timetable/screen/search_screen/widget/day_filter_chip.dart';
import 'package:timetable/screen/search_screen/widget/time_filter_chip.dart';
import 'package:timetable/screen/search_screen/widget/search_top.dart';
// import 'package:timetable/screen/search_screen/widget/type_class_chip.dart';
import 'package:timetable/screen/search_screen/widget/season_filter_chip.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _version = "";

  void _fetchSentence() async {
    var url = Uri.parse('https://shining-axis-326714.an.r.appspot.com/version');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> versionJson = jsonDecode(response.body);
      TimetableVersion versionData = TimetableVersion.fromJson(versionJson);
      //print(versionData.version);
      setState(() {
        _version = versionData.version.toString();
      });
    } else {
      throw Exception('Failed to load');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSentence();
  }

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<SearchFilterProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('講義を追加する',
              style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                top(context),
                const CourseFilter(),
                // const TypeFilter(), // 特例授業がある場合に使用する
                const SeasonFilter(),
                const DayFilter(),
                const TimeFilter(),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchResultScreen(
                          title: '検索結果',
                          days: filter.getDays().join(),
                          times: filter.getTimes().join(),
                          type: filter.getType(),
                          course: filter.getCourse(),
                          season: filter.getSeason(),
                        ),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Text('検索結果を見る'),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: const Color(0xffff7447),
                      onPrimary: Colors.white,
                      shape: const StadiumBorder(),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: Text(
                    '時間割データ: $_version',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 10),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    '曜日・時間・教室の変更、または閉講・休講の可能性があります！\n随時沖国大ポータルまたは学内の掲示板で最新の情報を確認して下さい。',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 10),
                  ),
                ),
              ],
            ),
          ),
        )));
  }
}

class TimetableVersion {
  String? version;

  TimetableVersion({this.version});

  TimetableVersion.fromJson(Map<String, dynamic> json) {
    version = json['version'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['version'] = version;
    return data;
  }
}
