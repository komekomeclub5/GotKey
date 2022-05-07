import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

Widget greetings(BuildContext context) {
  initializeDateFormatting('ja');
  var time = DateTime.now();

  return Column(
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
            // color: Color(0xff4c4c4c),
            fontSize: 25,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
