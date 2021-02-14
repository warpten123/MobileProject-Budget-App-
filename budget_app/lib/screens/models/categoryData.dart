class CategoryData {
  String categoryTitle;
  double categoryLimit;
  double categoryTotal;
  int id;

  CategoryData({
    this.id,
    this.categoryTitle,
    this.categoryLimit,
    this.categoryTotal = 0,
  });

  Map<String, dynamic> toMap() {
    return ({
      'category_id': id,
      'category_title': categoryTitle,
      'category_limit': categoryLimit,
      'category_total': categoryTotal,
    });
  }
}
