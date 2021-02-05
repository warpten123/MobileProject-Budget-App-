import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:flutter/material.dart';

class ItemList extends StatefulWidget {
  ItemList(this.itemList, this.categoryInfo);
  final List<ItemData> itemList;
  final CategoryData categoryInfo;
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  void deleteUser(int id) {
    setState(() {
      widget.itemList.removeWhere((index) {
        return index.itemID == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return widget.itemList.isEmpty
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
              itemCount: widget.itemList.length,
              itemBuilder: (context, index) {
                if (widget.itemList[index].categoryID ==
                    widget.categoryInfo.id) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      elevation: 3,
                      child: ListTile(
                        title: Text(
                          widget.itemList[index].itemTitle,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        trailing: FittedBox(
                          child: Row(
                            children: <Widget>[
                              Text(
                                '- ₱ ' + '${widget.itemList[index].itemValue}',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Gotham',
                                  color: Colors.red,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () =>
                                    deleteUser(widget.itemList[index].itemID),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
          );
  }
}
