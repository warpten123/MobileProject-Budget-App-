import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  AddItem(this.item);
  final Function item;

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  final _itemInput = TextEditingController(),
      _limitInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _itemInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Item',
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _limitInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: 'Cost',
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: FlatButton(
                child: Text(
                  'Add Item',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                onPressed: () {
                  if (_itemInput.text.isEmpty || _limitInput.text.isEmpty) {
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
                    widget.item(
                        _itemInput.text, double.parse(_limitInput.text));
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
