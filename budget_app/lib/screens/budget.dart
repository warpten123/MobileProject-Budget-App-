import 'package:budget_app/screens/addCategoryAndItems.dart';
import 'package:budget_app/screens/data.dart';
import 'package:budget_app/screens/chart.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  List<UserData> _userTransactions = [];
  List<BudgetData> _category = [];

  void categoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: AddCategory(addCategory),
            height: 250,
          );
        });
  }

  void addCategory(String text, double amount) {
    final BudgetData category = BudgetData(
      budgetTitle: text,
      budgetLimit: amount,
    );
    setState(() {
      _category.add(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => categoryBottomSheet(context),
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
            onPressed: () => categoryBottomSheet(context),
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
