class CategoryData {
  final String categoryTitle;
  final double categoryLimit;
  final double categoryTotal;
  final int id;

  CategoryData({
    this.id,
    this.categoryTitle,
    this.categoryLimit,
    this.categoryTotal = 0,
  });

  Map<String, dynamic> toMap() {
    return ({
      'item_id': id,
      'category_title': categoryTitle,
      'category_limit': categoryLimit,
      'category_total': categoryTotal,
    });
  }
}
