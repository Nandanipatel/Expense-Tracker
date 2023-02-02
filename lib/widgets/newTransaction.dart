import '../models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTransaction extends StatefulWidget {
  final Function add_transaction;
  // // List<Transaction> transaction;
  AddTransaction(this.add_transaction);

  @override
  State<AddTransaction> createState() => _AddTransactionState();
}

class _AddTransactionState extends State<AddTransaction> {
  final title = TextEditingController();
  final amount = TextEditingController();
  DateTime date;
  _submit() {
    if (amount.text.isEmpty) {
      return;
    }
    final titleText = title.text;
    final amountText = double.parse(amount.text);

    if (titleText.isEmpty || amountText < 0 || date == null) {
      return;
    }
    widget.add_transaction(amountText, titleText, date);
    Navigator.of(context).pop();
  }

  _chooseDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickeddate) {
      if (pickeddate == null) {
        return;
      }
      setState(() {
        date = pickeddate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        margin: EdgeInsets.all(10),
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: title,
                onSubmitted: (_) => _submit(),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
                keyboardType: TextInputType.number,
                controller: amount,
                onSubmitted: (_) => _submit(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(date == null
                          ? 'No date Selected'
                          : 'Picked Date : ${DateFormat.yMd().format(date)}'),
                    ),
                    TextButton(
                      onPressed: _chooseDate,
                      child: Text(
                        'Add Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                      ),
                      // TextButtonTheme: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                  onPrimary: Colors.white,
                ),
                // color: Theme.of(context).primaryColor,
                // textColor: Colors.white,
                onPressed: _submit,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
