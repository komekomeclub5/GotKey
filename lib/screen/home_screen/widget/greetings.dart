import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

Widget greetings(BuildContext context) {
  initializeDateFormatting('ja');
  final today = DateFormat('yyyy年MM月dd日(EEEE)', 'ja').format(DateTime.now());
  var time = DateTime.now();

  return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              (time.hour < 5)
                  ? 'こんばんは🌚'
                  : (time.hour < 11)
                      ? 'おはよう🌞'
                      : (time.hour < 18)
                          ? 'こんにちは🌞'
                          : 'こんばんは🌝',
              style: const TextStyle(
                color: Color(0xff4c4c4c),
                fontSize: 25,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              today,
              style: const TextStyle(
                color: Color(0xff4c4c4c),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ));
}
