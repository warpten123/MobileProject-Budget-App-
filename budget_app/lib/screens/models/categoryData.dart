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
}
