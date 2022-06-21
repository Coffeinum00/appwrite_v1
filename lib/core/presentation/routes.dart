import 'package:appwrite_v1/features/auth/presentation/pages/login.dart';
import 'package:appwrite_v1/features/auth/presentation/pages/profile.dart';
import 'package:appwrite_v1/features/auth/presentation/pages/signup.dart';
import 'package:appwrite_v1/features/general/presentation/pages/home.dart';
import 'package:appwrite_v1/features/transactions/presentation/pages/add_transaction.dart';
import 'package:appwrite_v1/features/transactions/presentation/pages/transaction_details.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class AppRoutes {
  static const String login = 'login';
  static const String signup = 'signup';
  static const String profile = 'profile';
  static const String home = 'home';
  static const String transactionDetails = 'transaction_details';
  static const String root = '/';
  static const String addTransaction = 'add_transaction';
  static const String editTransaction = 'edit_transaction';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final arguments = settings.arguments;
    return MaterialPageRoute(
        settings: settings,
        builder: (context) {
          switch (settings.name) {
            case root:
              return MyApp();
            case profile:
              return ProfilePage();
            case home:
              return HomePage();
            case signup:
              return SignUpPage();
            case transactionDetails:
              return TransactionDetails(transaction: arguments);
            case addTransaction:
              return AddTransactionPage(transaction: arguments);
            case editTransaction:
              return AddTransactionPage(transaction: arguments);
            case login:
            default:
              return LoginPage();
          }
        });
  }
}
