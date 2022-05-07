import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

class CourseFilter extends StatefulWidget {
  const CourseFilter({Key? key}) : super(key: key);

  @override
  State createState() => CourseFilterState();
}

class CourseFilterState extends State<CourseFilter> {
  String dropdownValue = 'すべての学科・科目';

  @override
  Widget build(BuildContext context) {
    final selected = Provider.of<SearchFilterProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft, //任意のプロパティ
          width: double.infinity,
          child: const Text(
            '学科・科目',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Color(0xffff7447),
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Theme(
          data: ThemeData(
              unselectedWidgetColor: const Color(0xfff8d395),
              toggleableActiveColor: const Color(0xffff7447)),
          child: Container(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).bottomAppBarColor,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 0.1,
                    blurRadius: 2.0,
                    offset: Offset(0, 3),
                  )
                ],
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              child: SizedBox(
                  height: 45,
                  width: double.infinity,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(Icons.expand_more),
                    elevation: 16,
                    style: Theme.of(context).primaryTextTheme.titleSmall,
                    underline: Container(
                      height: 0,
                    ),
                    dropdownColor: Theme.of(context).primaryColor,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        if (dropdownValue == 'すべての学科・科目') {
                          selected.addCourse('');
                        } else {
                          selected.addCourse(dropdownValue);
                        }
                      });
                    },
                    items: <String>[
                      'すべての学科・科目',
                      '共通科目',
                      '法律学科',
                      '地域行政学科',
                      '経済学科',
                      '地域環境政策学科',
                      '産業情報学科',
                      '企業システム学科',
                      '日本文化学科',
                      '英米言語文化学科',
                      '社会文化学科',
                      '人間福祉学科'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ))),
        )
      ],
    );
  }
}
