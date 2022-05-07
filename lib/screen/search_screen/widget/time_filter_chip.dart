import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.labels);
  final String name;
  final String labels;
}

class TimeFilter extends StatefulWidget {
  const TimeFilter({Key? key}) : super(key: key);

  @override
  State createState() => TimeFilterState();
}

class TimeFilterState extends State<TimeFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('1', ''),
    const ActorFilterEntry('2', ''),
    const ActorFilterEntry('3', ''),
    const ActorFilterEntry('4', ''),
    const ActorFilterEntry('5', ''),
    const ActorFilterEntry('6', ''),
    const ActorFilterEntry('7', ''),
  ];
  // final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    final filter = Provider.of<SearchFilterProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return FilterChip(
        label: Text(actor.name,
            style: TextStyle(
                color: filter.getTimes().contains(actor.name)
                    ? Colors.black
                    : null)),
        labelPadding:
            const EdgeInsets.only(left: 13, right: 13, top: 4, bottom: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: Theme.of(context).bottomAppBarColor,
        shadowColor: Colors.black45,
        elevation: filter.getTimes().contains(actor.name) ? 0 : 3,
        selectedColor: const Color(0xfff8d395),
        selected: filter.getTimes().contains(actor.name),
        showCheckmark: false,
        onSelected: (bool value) {
          setState(() {
            if (value) {
              filter.addTimes(actor.name);
            } else {
              filter.rmTimes(actor.name);
            }
          });
        },
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
              '時間',
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
