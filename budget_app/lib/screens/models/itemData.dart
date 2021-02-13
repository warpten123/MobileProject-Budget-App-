class ItemData {
  final int itemID;
  final int categoryID;
  final String itemTitle;
  final double itemValue;
  final DateTime date;

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
      'item_date': date,
    });
  }
}
