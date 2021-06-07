import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required this.transaction,
    @required this.removeTransaction,
  }) : super(key: key);

  final Transaction transaction;
  final Function removeTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.blue,
      Colors.purple,
    ];

    _bgColor = availableColors[Random().nextInt(4)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Container(
              height: 20,
              child: FittedBox(
                child:
                    Text('\$${widget.transaction.amount.toStringAsFixed(2)}'),
              ),
            ),
          ),
        ),
        title: Text(widget.transaction.title),
        subtitle: Text(
          DateFormat.yMMMd().format(widget.transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text('Delete'),
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all(Theme.of(context).errorColor),
                ),
                onPressed: () =>
                    widget.removeTransaction(widget.transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    widget.removeTransaction(widget.transaction.id),
              ),
      ),
    );
  }
}
