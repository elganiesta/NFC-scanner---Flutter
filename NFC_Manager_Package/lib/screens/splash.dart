import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(
      duration,
      () {
        Navigator.pushReplacementNamed(context, '/');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xffF5F5F5),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background2.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/logo.png',
            height: 250,
          ),
        ),
      ),
    ));
  }
}
