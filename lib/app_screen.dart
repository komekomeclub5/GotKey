import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:timetable/screen/home_screen/home_screen.dart';
import 'package:timetable/screen/timetable_screen/timetable.dart';
import 'package:timetable/screen/search_screen/search_screen.dart';

class AppScreen extends StatefulWidget {
  static const String routeName = '/app';

  @override
  _AppScreenState createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  final _currentTab = <Widget>[
    const HomeScreen(title: 'ホーム'),
    const TimeTableScreen(title: '時間割'),
    const SearchScreen(title: '講義検索'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _currentTab,
        navBarStyle: NavBarStyle.style3,
        items: [
          PersistentBottomNavBarItem(
            title: 'ホーム',
            icon: const Icon(Icons.home),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xff707070),
          ),
          PersistentBottomNavBarItem(
            title: '時間割',
            icon: const Icon(Icons.table_chart),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xff707070),
          ),
          PersistentBottomNavBarItem(
            title: '講義検索',
            icon: const Icon(Icons.search),
            activeColorPrimary: const Color(0xff707070),
            activeColorSecondary: const Color(0xff707070),
          )
        ],
      ),
    );
  }
}
