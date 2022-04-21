import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.value);
  final String name;
  final String value;
}

class SeasonFilter extends StatefulWidget {
  const SeasonFilter({Key? key}) : super(key: key);

  @override
  State createState() => SeasonFilterState();
}

class SeasonFilterState extends State<SeasonFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('前期', ''),
    // const ActorFilterEntry('後期', ''),
    const ActorFilterEntry('通年', ''),
  ];
  // final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    final filter = Provider.of<SearchFilterProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.only(right: 4.5),
        child: FilterChip(
          //avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xff707070)),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xfff8d395),
          selected: filter.getSeason() == actor.name,
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filter.setSeason(actor.name);
              } else {
                filter.rmSeason();
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
              '学期',
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
