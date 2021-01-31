import 'package:flutter/material.dart';

class AddCategory extends StatefulWidget {
  AddCategory(this.category);
  final Function category;

  @override
  _AddCategory createState() => _AddCategory();
}

class _AddCategory extends State<AddCategory> {
  final _categoryInput = TextEditingController(),
      _limitInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _categoryInput,
              style: TextStyle(fontFamily: 'Gotham'),
              decoration: InputDecoration(
                labelText: 'Category',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _limitInput,
              style: TextStyle(fontFamily: 'Gotham'),
              decoration: InputDecoration(
                labelText: 'Budget Limit',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  'Add Category',
                  style: TextStyle(
                    fontFamily: 'Gotham',
                  ),
                ),
                onPressed: () {
                  if (_categoryInput.text.isEmpty || _limitInput.text.isEmpty) {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Error',
                                style: TextStyle(fontFamily: 'Gotham')),
                            content: Text('Invalid Input',
                                style: TextStyle(fontFamily: 'Gotham')),
                            actions: [
                              FlatButton(
                                child: Text(
                                  'OK',
                                  style: TextStyle(fontFamily: 'Gotham'),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop('dialog');
                                },
                              ),
                            ],
                          );
                        });
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
