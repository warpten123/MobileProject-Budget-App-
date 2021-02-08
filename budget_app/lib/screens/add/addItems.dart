import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddItem extends StatefulWidget {
  AddItem(
    this.item,
  );
  final Function item;

  @override
  _AddItem createState() => _AddItem();
}

class _AddItem extends State<AddItem> {
  final _itemInput = TextEditingController(),
      _limitInput = TextEditingController();
  DateTime _date;

  void _datePicked() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _date = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              "Add Item",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        _date == null
                            ? 'No Date Chosen'
                            : DateFormat.yMMMMd().format(_date),
                        style: Theme.of(context).textTheme.bodyText2),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose Date',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    onPressed: _datePicked,
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
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
                  if (_itemInput.text.isEmpty ||
                      _limitInput.text.isEmpty ||
                      _date == null) {
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
                        _itemInput.text, double.parse(_limitInput.text), _date);
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
