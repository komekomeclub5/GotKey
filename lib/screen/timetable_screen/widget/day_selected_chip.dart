import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/day_selected_provider.dart';

class ActorFilterEntry {
  const ActorFilterEntry(this.name, this.initials);
  final String name;
  final String initials;
}

class DaySelectChip extends StatefulWidget {
  const DaySelectChip({Key? key}) : super(key: key);

  @override
  State createState() => DaySelectChipState();
}

class DaySelectChipState extends State<DaySelectChip> {
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
    final selected = Provider.of<DaySelectedProvider>(context);
    return _cast.map((ActorFilterEntry actor) {
      return Padding(
        padding: const EdgeInsets.all(4.5),
        child: ChoiceChip(
          //avatar: CircleAvatar(child: Text(actor.initials)),
          label: Text(actor.name),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Color(0xff707070)),
              borderRadius: BorderRadius.circular(10)),
          backgroundColor: Colors.white,
          selectedColor: const Color(0xfff8d395),
          selected: selected.getDay().contains(actor.name),
          onSelected: (bool value) {
            setState(() {
              if (value) {
                selected.setDay(actor.name);
              }
            });
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DaySelectedProvider>(builder: ((context, filter, _) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Wrap(
            children: actorWidgets.toList(),
          ),
        ],
      );
    }));
  }
}
