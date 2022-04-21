import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class DayFilter extends StatefulWidget {
  const DayFilter({Key? key}) : super(key: key);

  @override
  State createState() => DayFilterState();
}

class DayFilterState extends State<DayFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('月', ' '),
    const ActorFilterEntry('火', ' '),
    const ActorFilterEntry('水', ' '),
    const ActorFilterEntry('木', ' '),
    const ActorFilterEntry('金', ' '),
    const ActorFilterEntry('土', ' '),
  ];
  // final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    final filter = Provider.of<SearchFilterProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.only(right: 4.5),
        child: FilterChip(
          //avatar: CircleAvatar(child: Text(actor.initials)),
          padding: const EdgeInsets.only(left: 9, right: 9),
          label: Text(actor.name),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xff707070)),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xfff8d395),
          selected: filter.getDays().contains(actor.name),
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filter.addDays(actor.name);
              } else {
                filter.rmDays(actor.name);
              }
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchFilterProvider>(builder: ((context, filter, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(top: 20),
            alignment: Alignment.centerLeft, //任意のプロパティ
            width: double.infinity,
            child: const Text(
              '曜日',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xffff7447),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            child: Wrap(
              children: actorWidgets.toList(),
            ),
          ),
        ],
      );
    }));
  }
}
