import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.value);
  final String name;
  final String value;
}

class TypeFilter extends StatefulWidget {
  const TypeFilter({Key? key}) : super(key: key);

  @override
  State createState() => TypeFilterState();
}

class TypeFilterState extends State<TypeFilter> {
  final List<ActorFilterEntry> _cast = <ActorFilterEntry>[
    const ActorFilterEntry('対面授業', 'real'),
    const ActorFilterEntry('ｵﾝﾗｲﾝ授業', 'online'),
  ];
  // final List<String> _filters = <String>[];

  Iterable<Widget> get actorWidgets {
    final filter = Provider.of<SearchFilterProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.all(4.5),
        child: FilterChip(
          //avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xff707070)),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xfff8d395),
          selected: filter.getType().contains(actor.value),
          showCheckmark: false,
          onSelected: (bool value) {
            setState(() {
              if (value) {
                filter.setType(actor.value);
              } else {
                filter.rmType();
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
              '授業形態',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Color(0xffff7447),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Wrap(
            children: actorWidgets.toList(),
          ),
        ],
      );
    }));
  }
}
