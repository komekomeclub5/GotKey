import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:timetable/json/timetable_json_struct.dart';
import 'package:timetable/provider/search_filter.dart';

import 'package:timetable/screen/syllabus_screen/syllabus_screen.dart';
import 'package:timetable/screen/search_result_screen/widget/result_list.dart';
import 'package:timetable/screen/search_result_screen/widget/select_sort.dart';

class SearchResultScreen extends StatefulWidget {
  const SearchResultScreen({
    Key? key,
    required this.title,
    required this.days,
    required this.times,
    required this.course,
    required this.season,
    required this.type,
  }) : super(key: key);

  final String title;
  final String days;
  final String times;
  final String course;
  final String season;
  final String type;

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  List<Timetable> timetable = [];

  void fetchSentence() async {
    var uri = Uri(
        scheme: 'https',
        host: 'shining-axis-326714.an.r.appspot.com',
        path: '/search',
        queryParameters: {
          'days': widget.days,
          'times': widget.times,
          'form': widget.type,
          'value': widget.course,
          'season': widget.season,
        });

    final response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      try {
        var timetableList = jsonDecode(data)['timetable'] as List;
        setState(() {
          timetable =
              timetableList.map((model) => Timetable.fromJson(model)).toList();
          timetable.sort((a, b) => a.kamoku!.compareTo(b.kamoku!));
        });
      } catch (e) {
        const snackBar = SnackBar(
          content: Text('条件に合う講義が見つかりませんでした...🥺'),
        );
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(widget.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700)),
        iconTheme: const IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: const [SelectSort()],
      ),
      body: Center(
        child: Column(children: <Widget>[
          Expanded(child: result(timetable)),
        ]),
      ),
    );
  }

  Widget result(List<Timetable> timetable) {
    final filter = Provider.of<SearchFilterProvider>(context);

    if (filter.getSort() == 'kamoku') {
      timetable.sort((a, b) => a.kamoku!.compareTo(b.kamoku!));
    } else if (filter.getSort() == 'tantou') {
      timetable.sort((a, b) => a.tantou!.compareTo(b.tantou!));
    } else if (filter.getSort() == 'niti') {
      timetable.sort((a, b) => a.niti!.compareTo(b.niti!));
    } else if (filter.getSort() == 'gen') {
      timetable.sort((a, b) => a.gen!.compareTo(b.gen!));
    }

    if (timetable.isEmpty) {
      return const Text("読み込み中・・・", textAlign: TextAlign.center);
    } else {
      return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: ResultList(
                day: timetable[index].niti.toString(),
                time: timetable[index].gen.toString(),
                season: timetable[index].gakki.toString(),
                courseTitle: timetable[index].kamoku.toString(),
                teacher: timetable[index].tantou.toString(),
                classroom: timetable[index].kyoushitsu.toString(),
                additionalInformation: timetable[index].bikou.toString(),
              ),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SyllabusScreen(
                    day: timetable[index].niti.toString(),
                    time: timetable[index].gen.toString(),
                    season: timetable[index].gakki.toString(),
                    courseTitle: timetable[index].kamoku.toString(),
                    teacher: timetable[index].tantou.toString(),
                    classroom: timetable[index].kyoushitsu.toString(),
                  ),
                ),
              ),
            );
          },
          itemCount: timetable.length);
    }
  }
}
