import 'package:budget_app/screens/displayCategory.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  ItemList(this.itemList);
  final List<ItemData> itemList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return itemList.isEmpty
        ? Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Text('No item added yet!',
                    style: Theme.of(context).textTheme.headline5),
              ),
            ],
          )
        : Container(
            height: 390,
            width: size.width - 40.0,
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: ListTile(
                      title: Text(
                        itemList[index].itemTitle,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FittedBox(
                          child: Text(
                            '- ₱ ' + '${itemList[index].itemValue}',
                            style: TextStyle(
                              fontSize: 15.0,
                              fontFamily: 'Gotham',
                              color: Colors.red,
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
