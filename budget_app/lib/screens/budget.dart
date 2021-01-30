import 'package:budget_app/screens/chart.dart';
import 'package:budget_app/screens/userdata.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  List<UserData> _userTransactions = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => null,
      ),
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Gotham',
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => null,
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            ChartList(_userTransactions),
          ],
        ),
      ),
    );
  }
}
