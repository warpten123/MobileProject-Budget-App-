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
}
