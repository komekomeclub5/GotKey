import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetable/provider/search_filter.dart';

// import 'package:multi_select_flutter/multi_select_flutter.dart';

class SelectSort extends StatefulWidget {
  const SelectSort({Key? key}) : super(key: key);

  @override
  State createState() => SelectSortState();
}

class SelectSortState extends State<SelectSort> {
  String? isSelectedItem;
  @override
  Widget build(BuildContext context) {
    final selected = Provider.of<SearchFilterProvider>(context);
    return Column(
      children: <Widget>[
        DropdownButton(
            underline: DropdownButtonHideUnderline(child: Container()),
            itemHeight: 56,
            items: const [
              DropdownMenuItem(
                child: Text('科目名順'),
                value: 'kamoku',
              ),
              DropdownMenuItem(
                child: Text('教員名順'),
                value: 'tantou',
              ),
              DropdownMenuItem(
                child: Text('曜日順'),
                value: 'niti',
              ),
              DropdownMenuItem(
                child: Text('時間順'),
                value: 'gen',
              ),
            ],
            value: selected.getSort(),
            onChanged: (String? value) {
              setState(() {
                selected.setSort(value!);
              });
            }),
      ],
    );
  }
}
