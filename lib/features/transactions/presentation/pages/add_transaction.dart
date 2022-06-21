import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:appwrite_v1/features/transactions/data/model/transaction.dart';
import 'package:appwrite_v1/features/transactions/presentation/notifiers/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddTransactionPage extends StatefulWidget {
  final transaction;
  const AddTransactionPage({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  int? _transactionType;
  TextEditingController? _titleController;
  TextEditingController? _amountController;
  TextEditingController? _descriptionController;
  DateTime? _tDate;
  DateTime? today;
  bool? _isEdit;

  @override
  void initState() {
    super.initState();
    _isEdit = widget.transaction != null;
    _transactionType = _isEdit! ? widget.transaction.transactionType : 2;
    _titleController =
        TextEditingController(text: _isEdit! ? widget.transaction.title : null);
    _amountController = TextEditingController(
        text: _isEdit! ? widget.transaction.amount.toString() : null);
    _descriptionController = TextEditingController(
        text: _isEdit! ? widget.transaction.description : null);
    _tDate = (_isEdit! ? widget.transaction.transactionDate : DateTime.now)
        as DateTime?;
    today = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add transaction'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: RadioListTile(
                    title: const Text('Expense'),
                    value: 2,
                    groupValue: _transactionType,
                    onChanged: (val) {
                      setState(() {
                        _transactionType = val as int?;
                      });
                    }),
              ),
              Expanded(
                child: RadioListTile(
                    title: const Text('Income'),
                    value: 1,
                    groupValue: _transactionType,
                    onChanged: (val) {
                      setState(() {
                        _transactionType = val as int?;
                      });
                    }),
              ),
            ],
          ),
          TextField(
            controller: _titleController,
            decoration: InputDecoration(hintText: 'title'),
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(hintText: 'amount'),
          ),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(hintText: 'description'),
          ),
          CalendarDatePicker(
              initialDate: _tDate!,
              firstDate: DateTime(today!.year - 5),
              lastDate: today!,
              onDateChanged: (date) {
                setState(() {
                  _tDate = date;
                });
              }),
          Center(
            child: ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                String userId =
                    Provider.of<AuthState>(context, listen: false).user!.$id;
                Transaction transaction = Transaction(
                  id: _isEdit! ? widget.transaction.id : null,
                  title: _titleController!.text,
                  amount: int.parse(_amountController!.text),
                  description: _descriptionController!.text,
                  transactionDate: _tDate,
                  transactionType: _transactionType,
                  userId: userId,
                  createdAt: DateTime.now(),
                  updatedAt: DateTime.now(),
                );
                TransactionState ts =
                    Provider.of<TransactionState>(context, listen: false);

                if (_isEdit!) {
                  ts.updateTransaction(transaction);
                } else {
                  ts.addTransaction(transaction);
                }

                Navigator.pop(context);
              },
            ),
          )
        ],
      ),
    );
  }
}
