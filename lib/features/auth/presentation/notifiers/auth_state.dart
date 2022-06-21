import 'package:appwrite_v1/core/res/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

// import '../../data/model/user.dart';

class AuthState extends ChangeNotifier {
  Client client = Client();
  late Account account;
  bool? _isLoggedIn;
  User? _user;
  String? _error;

  bool? get isLoggedIn => _isLoggedIn;
  User? get user => _user;
  String? get error => _error;

  AuthState() {
    _init();
  }

  _init() {
    _isLoggedIn = false;
    _user = null;
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);

    account = Account(client);
    _checkIsLoggedIn();
  }

  login(String email, String password) async {
    try {
      var result =
          await account.createSession(email: email, password: password);
      _checkIsLoggedIn();
      print(result);
    } catch (e) {
      print(e);
    }
  }

  createAccount(
      String name, String email, String password, String userId) async {
    try {
      var result = await account.create(
          email: email, password: password, userId: userId, name: name);
      print(result);
    } catch (e) {
      print(e);
    }
  }

  logout() async {
    try {
      await account.deleteSession(sessionId: 'current');

      _isLoggedIn = false;
      _user = null;
      _checkIsLoggedIn();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  _checkIsLoggedIn() async {
    try {
      _user = await _getAccount();
      _isLoggedIn = true;
      notifyListeners();
    } catch (e) {
      _isLoggedIn = false;
      print(e);
    }
  }

  Future _getAccount() async {
    try {
      User res = await account.get();

      _user = res;

      return User.fromMap(res.toMap());
    } on AppwriteException catch (e) {
      print(e);
      rethrow;
    }
  }
}
