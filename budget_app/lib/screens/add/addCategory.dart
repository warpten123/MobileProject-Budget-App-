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
                onPressed: () {
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
                    widget.category(
                        _categoryInput.text, double.parse(_limitInput.text));
                    Navigator.of(context).pop();
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
