import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class TodoListProvider with ChangeNotifier {
  List<Map<String, String>> todolist = [];

  // FireStoreから取得
  Future getStore() async {
    List<Map<String, String>> storeTable = [];

    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');
    User? user = _auth.currentUser;
    if (user != null) {
      users
          .doc(user.uid)
          .collection('todolist')
          .doc('value')
          .get()
          .then((DocumentSnapshot snapshot) {
        snapshot.get('value').forEach((f) =>

                //Map<String, dynamic> toDate = {
                //  'term' : f['term'].toDate(),
                //  'todoValue' : f['value'],
                // }

                storeTable.add(f.cast<String, String>())
            //storeTable.add(toDate)
            );

        todolist = storeTable;
        notifyListeners();
      });
    }
  }

  // Todoを追加
  void setTodo(DateTime? term, String value) {
    initializeDateFormatting("ja_JP");
    var display = DateFormat('yyyy/MM/dd(E) HH:mm', "ja_JP");
    var stringTerm = display.format(term!);

    Map<String, String> todo = {'term': stringTerm, 'value': value};

    todolist.add(todo);

    // firestoreに保存
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');
    User? user = _auth.currentUser;
    if (user != null) {
      users
          .doc(user.uid)
          .collection('todolist')
          .doc('value')
          .set({'value': todolist});
    }

    notifyListeners();
  }

  // Todoを削除（タスク完了）
  void rmTodo(String term, String value) {
    Map<String, String> todo = {'term': term, 'value': value};

    todolist.removeWhere((Map<String, String> value) =>
        value['term'] == todo['term'] && value['value'] == todo['value']);

    // firestoreに保存 (削除後のリスト)
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final users = FirebaseFirestore.instance.collection('users');
    User? user = _auth.currentUser;
    if (user != null) {
      users
          .doc(user.uid)
          .collection('todolist')
          .doc('value')
          .set({'value': todolist});
    }

    notifyListeners();
  }

  // Todoを全て取得
  List<Map<String, String>> getTodo() {
    return todolist;
  }
}
