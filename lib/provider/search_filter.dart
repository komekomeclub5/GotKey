import 'package:flutter/material.dart';

// 検索の条件を管理

class SearchFilterProvider with ChangeNotifier {
  // List<String> course = [];
  String course = "";
  String typeClass = "";
  List<String> days = [];
  List<String> times = [];
  String season = "前期通年";

  String? sort = "kamoku";

  // 学科
  void addCourse(String value) {
    course = value;
    notifyListeners(); // 変更を通知
  }

  String getCourse() {
    return course;
  }

  // 授業形態
  void setType(String value) {
    typeClass = value;
    notifyListeners();
  }

  void rmType() {
    typeClass = "";
    notifyListeners();
  }

  String getType() {
    return typeClass;
  }

  // 曜日
  void addDays(String value) {
    days.add(value);
    notifyListeners();
  }

  void rmDays(String value) {
    days.remove(value);
    notifyListeners();
  }

  List<String> getDays() {
    return days;
  }

  // 時間
  void addTimes(String value) {
    times.add(value);
    notifyListeners();
  }

  void rmTimes(value) {
    times.remove(value);
    notifyListeners();
  }

  List<String> getTimes() {
    return times;
  }

  // 学期
  void setSeason(String value) {
    season = value;
    notifyListeners();
  }

  void rmSeason() {
    season = "前期通年";
    notifyListeners();
  }

  String getSeason() {
    return season;
  }

  // ソート
  void setSort(String value) {
    sort = value;
    notifyListeners();
  }

  String? getSort() {
    return sort;
  }
}
