import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:timetable/app_screen.dart';
import 'package:timetable/splash.dart';
import 'package:timetable/provider/bottom_navigation_bar_provider.dart';
import 'package:timetable/provider/search_filter.dart';
import 'package:timetable/provider/my_timetable_provider.dart';
import 'package:timetable/provider/day_selected_provider.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the generated file
import 'firebase_options.dart';

Future main() async {
  // main()の中で非同期処理を行う際には、下記を実行しなければならない
  WidgetsFlutterBinding.ensureInitialized();

  // firebase.initialize
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await _initializeFirebaseAuth();

  // iOS,Android共に縦向き固定
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => BottomNavigationBarProvider()),
        ChangeNotifierProvider(create: (context) => SearchFilterProvider()),
        ChangeNotifierProvider(create: (context) => MyTimetableProvider()),
        ChangeNotifierProvider(create: (context) => DaySelectedProvider()),
      ],
      child: MyApp(),
    ));
  });
}

Future<void> _initializeFirebaseAuth() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = _firebaseAuth.currentUser;
  if (user == null) {
// Firebase上にユーザがまだ作成されていない場合に匿名ログイン処理を実行する（すでに作成されている場合は新たにユーザ作成はしない））
    await _firebaseAuth.signInAnonymously();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      title: 'ホーム',
      home: AppScreen(),
      routes: {
        "/HomePage": (BuildContext context) => AppScreen(),
      },
    );
  }
}
