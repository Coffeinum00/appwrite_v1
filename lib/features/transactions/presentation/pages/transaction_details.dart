import 'package:appwrite_v1/features/transactions/presentation/notifiers/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/model/transaction.dart';

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({Key? key, required this.transaction})
      : super(key: key);
  final transaction;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details'),
        actions: [
          IconButton(
              onPressed: () async {
                await Provider.of<TransactionState>(context, listen: false)
                    .deleteTransaction(transaction);
                Navigator.pop(context);
              },
              icon: Icon(Icons.delete))
        ],
      ),
      body: transaction == null
          ? const Center(
              child: Text('Ups... Something went wrong'),
            )
          : ListView(
              children: [
                Text(
                  DateFormat.yMMMEd().format(transaction!.transactionDate),
                ),
                Text(transaction!.title),
                Text(
                  transaction!.amount.toString(),
                ),
                if (transaction.description != null &&
                    transaction.description.isNotEmpty)
                  Text(transaction.description),
              ],
            ),
    );
  }
}
