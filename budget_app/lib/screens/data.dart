class UserData {
  final String title;
  final double amount;
  final DateTime date;

  final int id;

  UserData({this.title, this.amount, this.date, this.id});
}

class BudgetData{
  final String budgetTitle;
  final double budgetLimit;

  BudgetData({this.budgetTitle, this.budgetLimit});
}