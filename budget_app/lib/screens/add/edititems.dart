import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditItem extends StatefulWidget {
  EditItem(
    this.categoryChecker,
    this.itemEdit,
  );
  final CategoryData categoryChecker;
  final ItemData itemEdit;

  @override
  _EditItem createState() => _EditItem();
}

class _EditItem extends State<EditItem> {
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

  double storeValue() {
    if (_limitInput.text.isEmpty) {
      return widget.itemEdit.itemValue;
    } else
      return double.parse(_limitInput.text);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Text(
              "Edit Item",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _itemInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: widget.itemEdit.itemTitle,
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _limitInput,
              style: Theme.of(context).textTheme.bodyText2,
              decoration: InputDecoration(
                labelText: widget.itemEdit.itemValue.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                        _date == null
                            ? DateFormat.yMMMMd().format(widget.itemEdit.date)
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
                    'Edit',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    if (_itemInput.text.isEmpty) {
                      _itemInput.text = widget.itemEdit.itemTitle;
                    }
                    widget.itemEdit.itemTitle = _itemInput.text;
                    widget.itemEdit.itemValue = storeValue();
                    if (_date == null) {
                      widget.itemEdit.date = widget.itemEdit.date;
                    } else {
                      widget.itemEdit.date = _date;
                    }
                    Navigator.of(context).pop();
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
