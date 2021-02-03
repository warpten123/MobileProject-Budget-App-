import 'package:budget_app/screens/add/addCategory.dart';
import 'package:budget_app/screens/chart.dart';
import 'package:budget_app/screens/list/categoryList.dart';
import 'package:budget_app/screens/models/budgetData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  List<ItemData> _userTransactions = [];
  List<BudgetData> _category = [];

  void categoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: AddCategory(addCategory),
              height: 250,
            ),
          );
        });
  }

  void addCategory(String text, double amount) {
    final BudgetData category = BudgetData(
        budgetTitle: text, budgetLimit: amount, id: _category.length);
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
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => categoryBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // ChartList(_userTransactions),
            CategoryList(_category, _userTransactions),
          ],
        ),
      ),
    );
  }
}
