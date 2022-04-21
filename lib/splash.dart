import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:timetable/app_screen.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 1500)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AppScreen())));
    _controller = AnimationController(
        duration: const Duration(milliseconds: 800), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.91, -0.89),
            end: Alignment(0.92, 0.89),
            colors: [Color(0xffff7447), Color(0xffffa408)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _animation,
            child: Image.asset('assets/images/logo.png'),
          ),
        ),
      ),
    );
  }
}
