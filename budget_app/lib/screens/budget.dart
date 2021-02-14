import 'package:budget_app/screens/add/addCategory.dart';
import 'package:budget_app/screens/chart.dart';
import 'package:budget_app/screens/list/categoryList.dart';
import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:budget_app/services/category_services.dart';
import 'package:budget_app/services/item_services.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class Budget extends StatefulWidget {
  Budget({this.title});
  final String title;

  @override
  _Budget createState() => _Budget();
}

class _Budget extends State<Budget> {
  List<ItemData> _userTransactions = [];
  List<CategoryData> _categoryList = [];
  CategoryService _categoryService = CategoryService();
  ItemService _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    getCategories();
    getItems();
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
                id: category['category_id'],
                categoryTotal: category['category_total'],
                categoryTitle: category['category_title'],
                categoryLimit: category['category_limit'],
              ),
            );
          },
        );
      },
    );
  }

  void getItems() async {
    setState(() {
      _userTransactions.clear();
    });
    var items = await _itemService.readItems();
    items.forEach(
      (item) {
        setState(
          () {
            _userTransactions.add(
              ItemData(
                itemID: item['item_id'],
                itemTitle: item['item_title'],
                itemValue: item['item_value'],
                categoryID: item['category_id'],
                date: DateTime.tryParse(item['item_date']),
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

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      backgroundColor: Colors.white,
      image: Image.network(
          'https://i.pinimg.com/originals/2b/77/7a/2b777a13d2df20a20342e24b1fef7ff7.gif'),
      loaderColor: Colors.white,
      photoSize: 150.0,
      navigateAfterSeconds: Scaffold(
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
      ),
    );
  }
}
