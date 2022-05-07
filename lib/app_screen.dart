import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timetable/screen/home_screen/home_screen.dart';
import 'package:timetable/screen/timetable_screen/timetable.dart';
import 'package:timetable/screen/todo_list_screen/todo_list_screen.dart';

class AppScreen extends StatefulWidget {
  static const String routeName = '/app';

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _currentTab = <Widget>[
    const HomeScreen(),
    const TimeTableScreen(title: '時間割'),
    const TodoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _currentTab,
        navBarStyle: NavBarStyle.simple,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          PersistentBottomNavBarItem(
            title: 'ホーム',
            icon: const Icon(Icons.home),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xffff7447),
          ),
          PersistentBottomNavBarItem(
            title: '時間割',
            icon: const Icon(Icons.table_chart),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xffff7447),
          ),
          PersistentBottomNavBarItem(
            title: 'やること',
            icon: const Icon(Icons.list),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xffff7447),
          )
        ],
      ),
    );
  }
}
