import 'package:budget_app/screens/models/budgetData.dart';
import 'package:flutter/material.dart';

class DisplayCategory extends StatefulWidget {
  DisplayCategory({this.categoryInfo});
  final BudgetData categoryInfo;

  @override
  _DisplayCategory createState() => _DisplayCategory();
}

class _DisplayCategory extends State<DisplayCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => null,
      ),
      appBar: AppBar(
        title: Text(
          widget.categoryInfo.budgetTitle,
          style: Theme.of(context).textTheme.headline4,
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Hello Category',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
