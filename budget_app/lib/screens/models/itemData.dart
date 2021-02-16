class ItemData {
  int itemID;
  int categoryID;
  String itemTitle;
  double itemValue;
  DateTime date;

  ItemData({
    this.itemID,
    this.itemTitle,
    this.itemValue,
    this.categoryID,
    this.date,
  });

  Map<String, dynamic> toMap() {
    return ({
      'item_id': itemID,
      'category_id': categoryID,
      'item_title': itemTitle,
      'item_value': itemValue,
      'item_date': date.toIso8601String(),
    });
  }
}
