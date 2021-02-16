import 'package:budget_app/screens/budget.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
        seconds: 3,
        backgroundColor: Colors.white,
        image: Image.asset('images/loading.gif'),
        loaderColor: Colors.white,
        photoSize: 150.0,
        navigateAfterSeconds: Budget(
          title: 'Simple Budget',
        ));
  }
}
