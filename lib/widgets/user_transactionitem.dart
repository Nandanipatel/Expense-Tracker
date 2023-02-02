import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.delExpense,
  }) : super(key: key);

  final Transaction transaction;
  final Function delExpense;
  // final DateTime date;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: CircleAvatar(
          radius: 35,
          child: Padding(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text('\$${transaction.amount}'),
            ),
          ),
        ),
        title: Text(transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? TextButton.icon(
                onPressed: () => delExpense(transaction.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor),
                ),
                // textColor: Theme.of(context).primaryColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).primaryColor,
                onPressed: () => delExpense(transaction.id),
              ),
      ),
    );
  }
}
