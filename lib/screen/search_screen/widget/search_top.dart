import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget top(BuildContext context) {
  return Container(
    margin: const EdgeInsets.only(bottom: 20, top: 20),
    child: const SizedBox(
      width: double.infinity,
      child: Text(
        '好みの条件を組み合わせて講義を見つけましょう！',
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        textAlign: TextAlign.left,
      ),
    ),
  );
}
