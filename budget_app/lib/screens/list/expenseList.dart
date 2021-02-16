import 'package:budget_app/screens/add/edititems.dart';
import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:budget_app/services/item_services.dart';
import 'package:flutter/material.dart';

import '../displayCategory.dart';

class ItemList extends StatefulWidget {
  ItemList(this.itemList, this.categoryInfo);
  final List<ItemData> itemList;
  final CategoryData categoryInfo;
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  ItemService _itemService = ItemService();

  @override
  void initState() {
    super.initState();
    print(widget.categoryInfo.categoryTotal);
    widget.itemList.forEach((element) {
      print(element.itemID);
    });
  }

  void itemBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: EditItem(
                widget.categoryInfo,
                widget.itemList[index],
              ),
              height: 300,
            ),
          );
        });
  }

  void deleteItem(int id, int i) {
    _itemService.deleteItem(widget.itemList[i]);
    setState(
      () {
        widget.itemList.removeWhere(
          (index) {
            widget.categoryInfo.categoryTotal -= widget.itemList[i].itemValue;
            return index.itemID == id;
          },
        );
      },
    );
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => DisplayCategory(
        categoryInfo: widget.categoryInfo,
        itemInfoMaster: widget.itemList,
      ),
    ));
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
                    padding: const EdgeInsets.all(2.0),
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
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: IconButton(
                                  icon: Icon(Icons.build, color: Colors.blue),
                                  onPressed: () =>
                                      itemBottomSheet(context, index),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () => deleteItem(
                                    widget.itemList[index].itemID, index),
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
