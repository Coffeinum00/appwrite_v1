import 'package:appwrite_v1/core/presentation/routes.dart';
import 'package:appwrite_v1/features/transactions/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Budgeter'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              icon: Icon(Icons.person)),
        ],
      ),
      body: TransactionList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, AppRoutes.addTransaction),
      ),
    );
  }
}
