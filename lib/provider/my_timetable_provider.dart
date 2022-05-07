import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyTimetableProvider with ChangeNotifier {
  List<Map<String, String>> timetable = [];

  // FireStoreから取得
  Future getStore() async {
    List<Map<String, String>> storeTable = [];
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');
    User? user = _auth.currentUser;
    if (user != null) {
      users.doc(user.uid).get().then((DocumentSnapshot snapshot) {
        snapshot
            .get('timetable')
            .forEach((f) => storeTable.add(f.cast<String, String>()));
        timetable = storeTable;
        notifyListeners();
      });
    }
  }

  // FireStoreに保存
  Future setStore() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');
    User? user = _auth.currentUser;
    if (user != null) {
      users
          .doc(user.uid)
          .set({'timestamp': DateTime.now(), 'timetable': timetable});
    }
  }

  // 時間割を追加
  void addTimetable(Map<String, String> value) {
    timetable.add(value);
    timetable.sort((a, b) => a['time']!.compareTo(b['time']!));
    notifyListeners();

    setStore();
  }

  // 時間割を削除
  void removeTimetable(Map<String, String> course) {
    int count = 0;
    for (var value in timetable) {
      if (value['day'] == course['day'] &&
          value['time'] == course['time'] &&
          value['season'] == course['season'] &&
          value['courseTitle'] == course['courseTitle'] &&
          value['teacher'] == course['teacher']) {
        timetable.removeAt(count);
        break;
      }
      count++;
    }
    notifyListeners();

    setStore();
  }

  // 追加しているか
  bool onTheTimetable(Map<String, String> course) {
    bool result = false;
    for (var value in timetable) {
      if (value['day'] == course['day'] &&
          value['time'] == course['time'] &&
          value['season'] == course['season'] &&
          value['courseTitle'] == course['courseTitle'] &&
          value['teacher'] == course['teacher']) {
        result = true;
      }
    }
    return result;
  }

  // 重複しているか
  bool dupulicateTimetable(Map<String, String> course) {
    int count = 0;
    for (var value in timetable) {
      if (value['day'] == course['day'] && value['time'] == course['time']) {
        count++;
      }
    }
    return count > 0 ? true : false;
  }

  List<Map<String, String>> getTimetable() {
    return timetable;
  }
}
