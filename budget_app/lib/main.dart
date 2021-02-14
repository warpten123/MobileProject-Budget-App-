import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:budget_app/screens/budget.dart';
import 'package:path/path.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:sqflite/sqflite.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Budget(
        title: 'Simple Budget',
      ),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.blue,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.bold,
              ),
              bodyText2: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Gotham',
              ),
              headline4: TextStyle(
                fontSize: 19.0,
                fontFamily: 'Gotham',
                color: Colors.white,
              ),
              headline5: TextStyle(
                fontSize: 16.0,
                fontFamily: 'Gotham',
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontSize: 14.0,
                fontFamily: 'Gotham',
              ),
            ),
      ),
    );
  }
}
