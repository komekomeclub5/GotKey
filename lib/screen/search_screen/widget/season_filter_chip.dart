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
    const ActorFilterEntry('前期', '前期'),
    // const ActorFilterEntry('後期', ''),
    const ActorFilterEntry('通年', '通年'),
  ];
  // final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    final filter = Provider.of<SearchFilterProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.only(right: 4.5),
        child: FilterChip(
          label: Text(actor.name,
              style: TextStyle(
                  color:
                      filter.getSeason() == actor.value ? Colors.black : null)),
          labelPadding:
              const EdgeInsets.only(left: 30, right: 30, top: 4, bottom: 4),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: Theme.of(context).bottomAppBarColor,
          shadowColor: Colors.black45,
          elevation: filter.getSeason() == actor.value ? 0 : 3,
          selectedColor: const Color(0xfff8d395),
          selected: filter.getSeason() == actor.value,
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filter.setSeason(actor.value);
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
