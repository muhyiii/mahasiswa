// ignore_for_file: use_key_in_widget_constructors, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mahasiswa/main.dart';
import 'package:mahasiswa/user/User.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    controller.forward();
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 4);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return UserPage();
      }));
    });
  }

  late AnimationController controller;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: (MediaQuery.of(context).size.height),
          width: (MediaQuery.of(context).size.width),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blueAccent.shade100, Colors.blue.shade400])),
          child: FadeTransition(
            opacity: CurvedAnimation(parent: controller, curve: Curves.easeIn),
            child: Center(
              child: Text("UniveApp",
                  style: TextStyle(
                      fontFamily: 'fredoka',
                      fontSize: 70,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                            color: Colors.black.withOpacity(0.3),
                            offset: const Offset(15, 15),
                            blurRadius: 15),
                      ])),
            ),
          ),
        ),
      ),
    );
  }
}
