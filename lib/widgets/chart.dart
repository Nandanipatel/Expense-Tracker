import 'package:expense_manager/models/transaction.dart';
import 'package:expense_manager/widgets/chartbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transaction;
  Chart(this.transaction);

  List<Map<String, Object>> get recentTransactoins {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double total = 0;

      for (var i = 0; i < transaction.length; i++) {
        if (transaction[i].date.day == weekDay.day &&
            transaction[i].date.month == weekDay.month &&
            transaction[i].date.year == weekDay.year) {
          total += transaction[i].amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': total,
      };
    }).reversed.toList();
  }

  double get totalamount {
    return recentTransactoins.fold(0.0, (sum, element) {
      return sum + element['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    print(recentTransactoins);
    print("total amount = " + totalamount.toString());
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          children: recentTransactoins.map((e) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                e['day'],
                e['amount'],
                (e['amount'] as double) / totalamount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
