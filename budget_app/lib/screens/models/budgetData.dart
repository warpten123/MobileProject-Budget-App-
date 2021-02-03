class BudgetData {
  final String budgetTitle;
  final double budgetLimit;
  final double budgetTotal;
  final int id;

  BudgetData({
    this.id,
    this.budgetTitle,
    this.budgetLimit,
    this.budgetTotal = 0,
  });
}
