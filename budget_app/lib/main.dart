import 'package:flutter/material.dart';
import 'package:budget_app/screens/budget.dart';

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
      ),
    );
  }
}