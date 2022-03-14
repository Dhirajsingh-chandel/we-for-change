import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:we_for_change/Constant/Constant.dart';

import 'Registration_Page.dart';

class ImageSplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<ImageSplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 4);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegistrationPage()));//    Navigator.of(context).pushReplacementNamed(HOME_PAGE);
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.white,
      body: new Center(
        child: Image.asset(
          'assets/images/plash.jpg',
          fit: BoxFit.fitWidth,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
//        fit: BoxFit.cover,
      ),
    );
  }
}
