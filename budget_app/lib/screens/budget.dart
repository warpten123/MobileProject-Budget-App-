import 'package:budget_app/screens/add/addCategory.dart';
import 'package:budget_app/screens/chart.dart';
import 'package:budget_app/screens/list/categoryList.dart';
import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:budget_app/services/category_services.dart';
import 'package:flutter/material.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  List<ItemData> _userTransactions = [];
  List<CategoryData> _categoryList = [];
  CategoryService _categoryService;

  @override
  void initState() {
    super.initState();
  }

  void getCategories() async {
    setState(() {
      _categoryList.clear();
    });
    var categories = await _categoryService.readCategories();
    categories.forEach(
      (category) {
        setState(
          () {
            _categoryList.add(
              CategoryData(
                categoryTitle: category['category_title'],
                categoryLimit: category['category_limit'],
              ),
            );
          },
        );
      },
    );
  }

  void categoryBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: AddCategory(getCategories),
              height: 250,
            ),
          );
        });
  }

//To be removed
  void addCategory(String text, double amount) {
    final CategoryData category = CategoryData(
        categoryTitle: text, categoryLimit: amount, id: _categoryList.length);
    setState(() {
      _categoryList.add(category);
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
            ChartList(_userTransactions),
            CategoryList(_categoryList, _userTransactions),
          ],
        ),
      ),
    );
  }
}
