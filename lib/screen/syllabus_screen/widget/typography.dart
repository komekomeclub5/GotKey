import 'package:flutter/material.dart';

class SyllabusTitle extends StatelessWidget {
  const SyllabusTitle({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        value,
        style: const TextStyle(
          color: Color(0xff4c4c4c),
          fontSize: 25,
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.left,
      ),
    );
  }
}

class Heading extends StatelessWidget {
  const Heading({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 40.0,
      ),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          value,
          style: const TextStyle(
            color: Color(0xff4c4c4c),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class HeadingSub extends StatelessWidget {
  const HeadingSub({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25.0, bottom: 2.0),
      child: SizedBox(
        width: double.infinity,
        child: Text(
          value,
          style: const TextStyle(
            color: Color(0xffff7447),
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({
    Key? key,
    required this.value,
  }) : super(key: key);

  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        value,
        textAlign: TextAlign.left,
      ),
    );
  }
}
