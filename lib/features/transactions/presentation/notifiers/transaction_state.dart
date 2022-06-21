import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:appwrite_v1/core/res/app_constants.dart';
import 'package:appwrite_v1/features/transactions/data/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TransactionState extends ChangeNotifier {
  final String collectionId = '62555c28328cbad88034';
  Client client = Client();
  late Database db;
  late String _error;
  List<Transaction>? _transactionList;
  bool isLoading = true;

  List<Transaction> get transactionList => _transactionList!;

  String get error => _error;

  TransactionState() {
    _init();
  }

  _init() {
    client
        .setEndpoint(AppConstants.endpoint)
        .setProject(AppConstants.projectId);
    db = Database(client);
    _transactionList = [];
    transactions();
  }

  Future transactions() async {
    try {
      DocumentList res = await db.listDocuments(collectionId: collectionId);

      _transactionList = List<Transaction>.from(
          res.documents.map((tr) => Transaction.fromJson(tr.data)));
      isLoading = false;
      notifyListeners();
    } on AppwriteException catch (e) {
      print(e.message);
    }
  }

  Future addTransaction(Transaction transaction) async {
    try {
      Document res = await db.createDocument(
          collectionId: collectionId,
          documentId: 'unique()',
          data: transaction.toJson(),
          read: ['user:${transaction.userId}'],
          write: ['user:${transaction.userId}']);
      _transactionList!.add(Transaction.fromJson(res.data));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future updateTransaction(Transaction transaction) async {
    try {
      Document res = await db.updateDocument(
          collectionId: collectionId,
          documentId: transaction.id!,
          data: transaction.toJson(),
          read: ['user:${transaction.userId}'],
          write: ['user:${transaction.userId}']);
      Transaction updated = Transaction.fromJson(res.data);
      _transactionList = List<Transaction>.from(_transactionList!
          .map((tran) => tran.id == updated.id ? updated : tran));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future deleteTransaction(Transaction transaction) async {
    try {
      await db.deleteDocument(
          collectionId: collectionId, documentId: transaction.id!);
      _transactionList = List<Transaction>.from(
          _transactionList!.where((trans) => trans.id != transaction.id));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
