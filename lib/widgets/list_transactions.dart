import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'user_transactionitem.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function delExpense;
  TransactionList(this.transaction, this.delExpense);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: transaction.isEmpty
          ? LayoutBuilder(builder: (context, constrains) {
              return Column(
                children: [
                  Text(
                    'No transactions Yet...',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constrains.maxHeight * .7,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.cover),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  key: ValueKey(transaction[index].id),
                  transaction: transaction[index],
                  delExpense: delExpense,
                );
              },
              itemCount: transaction.length,
            ),
    );
  }
}
