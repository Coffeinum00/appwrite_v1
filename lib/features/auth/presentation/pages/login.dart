import 'package:appwrite_v1/core/presentation/routes.dart';
import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            const Text(
              'Login',
              // style: Theme.of(context.textTheme.headline5,),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextField(
              controller: _email,
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextField(
              controller: _password,
              obscureText: true,
              decoration: const InputDecoration(hintText: 'Password'),
            ),
            const SizedBox(
              height: 10.0,
            ),
            ElevatedButton(
              onPressed: () {
                AuthState state =
                    Provider.of<AuthState>(context, listen: false);
                state.login(_email.text, _password.text);
              },
              child: const Text('Login'),
            ),
            const SizedBox(
              height: 20.0,
            ),
            OutlinedButton(
              onPressed: () => Navigator.pushNamed(context, AppRoutes.signup),
              child: const Text('Create account'),
            ),
          ],
        ),
      ),
    );
  }
}
