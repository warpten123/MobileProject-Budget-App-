import 'package:budget_app/screens/add/addItems.dart';
import 'package:budget_app/screens/models/categoryData.dart';
import 'package:budget_app/screens/models/itemData.dart';
import 'package:budget_app/services/item_services.dart';
import 'package:flutter/material.dart';
import 'list/expenseList.dart';

const TWO_PI = 3.14 * 2;

class DisplayCategory extends StatefulWidget {
  DisplayCategory({this.categoryInfo, this.itemInfoMaster, this.notifyParent});
  final CategoryData categoryInfo;
  final List<ItemData> itemInfoMaster;
  final Function() notifyParent;

  @override
  _DisplayCategory createState() => _DisplayCategory();
}

class _DisplayCategory extends State<DisplayCategory> {
  ItemService _itemService = ItemService();
  double _total = 0;
  @override
  initState() {
    super.initState();
    _getCategoryTotal();
  }

  void _getCategoryTotal() async {
    var total = (await _itemService
        .returnCategoryTotal(widget.categoryInfo.id))[0]["SUM(item_value)"];

    setState(() {
      total != null ? _total = total : _total = 0;
    });
  }

  void itemBottomSheet(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: AddItem(addItem, widget.categoryInfo),
              height: 300,
            ),
          );
        });
  }

  void addItem(String text, double amount, DateTime date) {
    final ItemData item = ItemData(
      itemID: widget.itemInfoMaster.length,
      itemTitle: text,
      itemValue: amount,
      date: date,
      categoryID: widget.categoryInfo.id,
    );
    setState(() {
      widget.itemInfoMaster.add(item);
      widget.categoryInfo.categoryTotal += amount;
      widget.notifyParent();
    });
  }

  double totalItems() {
    double totalValue = 0;
    for (int i = 0; i < widget.itemInfoMaster.length; i++) {
      if (widget.itemInfoMaster[i].categoryID == widget.categoryInfo.id)
        totalValue += widget.itemInfoMaster[i].itemValue;
    }
    return totalValue;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final circleSize = 200.0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => itemBottomSheet(context),
      ),
      appBar: AppBar(
        title: Text(
          widget.categoryInfo.categoryTitle,
          style: Theme.of(context).textTheme.headline4,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => itemBottomSheet(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(15.0)),
              Container(
                height: 250.0,
                width: size.width - 60.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                    bottomLeft: Radius.circular(20.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Center(
                    child: TweenAnimationBuilder(
                  tween: Tween(
                      begin: 0.0,
                      end: _total / widget.categoryInfo.categoryLimit),
                  duration: Duration(seconds: 1),
                  builder: (context, value, child) {
                    return Container(
                      width: circleSize,
                      height: circleSize,
                      child: Stack(
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return SweepGradient(
                                  startAngle: 0.0,
                                  endAngle: TWO_PI,
                                  stops: [value, value],
                                  center: Alignment.center,
                                  colors: [
                                    Colors.blue,
                                    Colors.grey.withAlpha(55)
                                  ]).createShader(rect);
                            },
                            child: Container(
                              width: circleSize,
                              height: circleSize,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ),
                          Center(
                            child: Container(
                              width: circleSize - 40.0,
                              height: circleSize - 40.0,
                              child: Center(
                                child: Text(
                                  "₱ " +
                                      _total.toString() +
                                      " / ₱ ${widget.categoryInfo.categoryLimit}",
                                  style: TextStyle(
                                    fontSize: 12.0,
                                  ),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )),
              ),
              Padding(padding: EdgeInsets.all(15.0)),
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    ItemList(widget.itemInfoMaster, widget.categoryInfo),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
