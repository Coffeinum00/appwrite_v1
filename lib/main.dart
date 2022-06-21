import 'package:appwrite_v1/core/presentation/notifiers/providers.dart';
import 'package:appwrite_v1/core/presentation/routes.dart';
import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:appwrite_v1/features/auth/presentation/pages/login.dart';
import 'package:appwrite_v1/features/auth/presentation/pages/signup.dart';
import 'package:appwrite_v1/features/general/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<AuthState>(
          builder: (context, state, child) {
            return state.user != null ? HomePage() : LoginPage();
          },
        ),
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
