import 'package:flutter/material.dart';

// 時間割の日付選択状態管理

class DaySelectedProvider with ChangeNotifier {
  // var dt = DateTime.now();
  // var dayString = ['', '月', '火', '水', '木', '金', '土'];

  String day = "月";

  void setDay(String value) {
    day = value;
    notifyListeners();
  }

  String getDay() {
    return day;
  }
}
