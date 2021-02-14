import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/services/category_services.dart';
import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  AddCategory(this.refreshList);
  final Function refreshList;

  @override
  _AddCategory createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory> {
  final _categoryInput = TextEditingController(),
      _limitInput = TextEditingController(),
      _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              "Add Category",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _categoryInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _limitInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Budget Limit',
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.black)),
                child: Text(
                  'Add',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onPressed: () async {
                  if (_categoryInput.text.isEmpty || _limitInput.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error',
                                style: Theme.of(context).textTheme.bodyText2),
                            content: Text('Invalid Input',
                                style: Theme.of(context).textTheme.bodyText2),
                            actions: [
                              FlatButton(
                                child: Text(
                                  'OK',
                                  style: Theme.of(context).textTheme.bodyText2,
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop('dialog');
                                },
                              ),
                            ],
                          );
                        });
                  } else {
                    await _categoryService.saveCategory(
                      CategoryData(
                        categoryTitle: _categoryInput.text,
                        categoryLimit: double.parse(_limitInput.text),
                      ),
                    );
                    widget.refreshList();
                    Navigator.of(context).pop();
                    // widget.category(
                    //     _categoryInput.text, double.parse(_limitInput.text));
                    // Navigator.of(context).pop();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
