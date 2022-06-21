import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _name = TextEditingController();
  String _userId = 'unique()';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
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
              controller: _name,
              decoration: const InputDecoration(hintText: 'Name'),
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
                  state.createAccount(
                      _name.text, _email.text, _password.text, _userId);
                },
                child: const Text('Sign up'))
          ],
        ),
      ),
    );
  }
}
