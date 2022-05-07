import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget todoTitle(BuildContext context) {
  return Column(
    children: const <Widget>[
      SizedBox(
        width: double.infinity,
        child: Text(
          'あなたのやること',
          style: TextStyle(
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
