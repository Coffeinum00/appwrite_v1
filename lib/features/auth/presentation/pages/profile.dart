import 'package:appwrite_v1/core/presentation/routes.dart';
import 'package:appwrite_v1/features/auth/presentation/notifiers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Consumer<AuthState>(builder: (context, state, child) {
        if (!state.isLoggedIn!) return Container();
        return ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            Center(
              child: Text(state.user!.name),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(state.user!.email),
            ),
            const SizedBox(
              height: 30.0,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await state.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.root, (Route<dynamic> route) => false);
                },
                child: Text('Logout'),
              ),
            )
          ],
        );
      }),
    );
  }
}
