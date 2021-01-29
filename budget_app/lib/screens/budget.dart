import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Gotham',
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello',
              style: TextStyle(
                fontFamily: 'Gotham',
                fontSize: 36.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}
