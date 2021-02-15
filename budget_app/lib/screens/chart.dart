import 'package:budget_app/screens/models/itemData.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'budget.dart';

class BarChartWidget extends StatefulWidget {
  BarChartWidget({this.day, this.amount, this.percentage});
  final String day;
  final double amount;
  final double percentage;

  @override
  _BarChartWidget createState() => _BarChartWidget();
}

class _BarChartWidget extends State<BarChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FittedBox(
          child: Text(
            '₱ ${widget.amount}',
            style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Gotham',
            ),
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Container(
          width: 10.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: FractionallySizedBox(
                  heightFactor: widget.percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          '${widget.day}',
          style: TextStyle(
              fontSize: 14.0,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class ChartList extends StatefulWidget {
  ChartList(this.userTransactions);
  final List<ItemData> userTransactions;

  @override
  _ChartList createState() => _ChartList();
}

class _ChartList extends State<ChartList> {
  DateTime now = new DateTime.now();

  int weekDayDate(String day) {
    int n = 0;
    switch (day) {
      case 'Monday':
        return n - 1;
        break;
      case 'Tuesday':
        return n - 2;
        break;
      case 'Wednesday':
        return n - 3;
        break;
      case 'Thursday':
        return n - 4;
        break;
      case 'Friday':
        return n - 5;
        break;
      case 'Saturday':
        return n - 6;
        break;
    }
    return n;
  }

  List<Map<String, Object>> get daysList {
    return List.generate(7, (count) {
      String day = DateFormat('EEEE').format(DateTime.now());
      DateTime days =
          DateTime.now().add(Duration(days: count - weekDayDate(day) - 2));
      // DateTime days = DateTime.now().subtract(Duration(days: count));
      double total = 0.0;

      for (int counter = 0;
          counter < widget.userTransactions.length;
          counter++) {
        if (days.year == widget.userTransactions[counter].date.year &&
            days.month == widget.userTransactions[counter].date.month &&
            days.day == widget.userTransactions[counter].date.day) {
          total += widget.userTransactions[counter].itemValue;
        }
      }

      return {
        'day': DateFormat.E().format(days),
        'amount': total,
      };
    }).toList();
  }

  double get expense {
    return daysList.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime week = now.add(Duration(days: 7));
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Text(
              'Weekly Spendings',
              style: Theme.of(context).textTheme.headline5,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: (){
                    setState(() {
                      now = now.subtract(Duration(days: 7));
                      week = week.subtract(Duration(days: 7));
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => new Budget(),
                      //   ));
                    });
                  },
                ),
                Text(
                  DateFormat.yMMMd().format(now.add(Duration(days: -1))) +
                      ' - ' +
                      DateFormat.yMMMd().format(week.add(Duration(days: -2))),
                  style: Theme.of(context).textTheme.headline6,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: (){
                    setState(() {
                      now = now.add(Duration(days: 7));
                      week = week.add(Duration(days: 7));
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (context) => new ChartList(widget.userTransactions),
                      //   ));
                    });
                  },
                ),
              ],
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: daysList.map((exp) {
                return BarChartWidget(
                  day: exp['day'],
                  amount: exp['amount'],
                  percentage:
                      expense != 0 ? (exp['amount'] as double) / expense : 0.0,
                );
              }).toList(),
            ),
            SizedBox(
              height: 5.0,
            ),
          ],
        ),
      ),
    );
  }
}
