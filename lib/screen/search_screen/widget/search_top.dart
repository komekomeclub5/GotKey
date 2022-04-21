import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget top(BuildContext context) {
  return Container(
      margin: const EdgeInsets.only(bottom: 50.0),
      child: Column(
        children: const <Widget>[
          SizedBox(
            width: double.infinity,
            child: Text(
              '講義を探す',
              style: TextStyle(
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
              'お好みの条件で講義を見つけましょう！',
              style: TextStyle(
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
