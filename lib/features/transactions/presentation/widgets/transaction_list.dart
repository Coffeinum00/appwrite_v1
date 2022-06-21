import 'package:appwrite_v1/core/presentation/routes.dart';
import 'package:appwrite_v1/features/transactions/presentation/notifiers/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../data/model/transaction.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _transactionList = Provider.of<TransactionState>(context);
    return Container(
      child: Center(
        child: _transactionList.isLoading
            ? const CircularProgressIndicator()
            : _transactionList.transactionList.isEmpty
                ? const Text('No transactions')
                : ListView.builder(
                    itemCount: _transactionList.transactionList.length,
                    itemBuilder: (context, index) {
                      Transaction transaction =
                          _transactionList.transactionList[index];
                      return Container(
                        child: ListTile(
                          title: Text(transaction.title!),
                          subtitle: Text(
                            DateFormat.yMMMEd()
                                .format(transaction.transactionDate!),
                          ),
                          leading: Icon(transaction.transactionType == 1
                              ? Icons.account_balance_wallet
                              : Icons.view_list),
                          trailing: Text(transaction.amount.toString()),
                          onTap: () => Navigator.pushNamed(
                              context, AppRoutes.transactionDetails,
                              arguments: transaction),
                          onLongPress: () {
                            Navigator.pushNamed(
                                context, AppRoutes.editTransaction,
                                arguments: transaction);
                          },
                        ),
                      );
                    }),
      ),
    );
    // return FutureBuilder(
    //   future: Provider.of<TransactionState>(context).transactions(),
    //   builder: (BuildContext context, AsyncSnapshot snapshot) {
    //     if (snapshot.hasData) {
    //       List<Transaction> transactions = snapshot.data;
    //       return ListView.builder(
    //         itemCount: transactions.length,
    //         itemBuilder: (BuildContext context, int index) {
    //           Transaction transaction = transactions[index];
    //           return ListTile(
    //             title: Text(transaction.title),
    //             subtitle: Text(
    //               DateFormat.yMMMEd().format(transaction.transactionDate),
    //             ),
    //             leading: Icon(transaction.transactionType == 1
    //                 ? Icons.account_balance_wallet
    //                 : Icons.view_list),
    //             trailing: Text(transaction.amount.toString()),
    //             onTap: () => Navigator.pushNamed(
    //                 context, AppRoutes.transactionDetails,
    //                 arguments: transaction),
    //           );
    //         },
    //       );
    //     }
    //     return CircularProgressIndicator();
    //   },
    // );
  }
}
