import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:appwrite_v1/features/transactions/presentation/notifiers/transaction_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => AuthState(),
    lazy: false,
  ),
  ChangeNotifierProvider(
    create: (context) => TransactionState(),
  )
];
