import 'package:budget_app/screens/displayCategory.dart';
import 'package:budget_app/screens/models/budgetData.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatelessWidget {
  CategoryList(this.categoryList);
  final List<BudgetData> categoryList;

  @override
  Widget build(BuildContext context) {
    return categoryList.isEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('No Category added yet!',
                    style: Theme.of(context).textTheme.headline5),
              ),
            ],
          )
        : Container(
            height: 390,
            child: ListView.builder(
              itemCount: categoryList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DisplayCategory(
                                categoryInfo: categoryList[index],
                              )));
                    },
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          categoryList[index].budgetTitle,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FittedBox(
                            child: Text(
                              '₱ ' +
                                  "0 " +
                                  '/ ${categoryList[index].budgetLimit}',
                              style: TextStyle(
                                  fontSize: 15.0, fontFamily: 'Gotham'),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
