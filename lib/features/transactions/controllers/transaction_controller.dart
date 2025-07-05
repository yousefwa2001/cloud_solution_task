import 'package:cloud_solutions_task/features/items/models/item_model.dart';
import 'package:cloud_solutions_task/features/transactions/models/payment_detail_model.dart';
import 'package:cloud_solutions_task/features/transactions/models/transaction_detail_model.dart';
import 'package:cloud_solutions_task/features/transactions/services/transaction_api_service.dart';
import 'package:cloud_solutions_task/features/transactions/services/transaction_local_service.dart';
import 'package:flutter/material.dart';
import '../models/transaction_model.dart';

class TransactionController extends ChangeNotifier {
  final TransactionLocalDataSource localDataSource;

  TransactionController(this.localDataSource);

  final List<TransactionModel> _transactions = [];
  List<TransactionModel> get transactions => _transactions;

  final List<TransactionModel> _selectedTransactions = [];
  List<TransactionModel> get selectedTransactions => _selectedTransactions;
  final TransactionApiService _apiService = TransactionApiService();

  Future<void> loadTransactionsFromDb() async {
    _transactions.clear();
    final data = await localDataSource.getAllTransactions();
    _transactions.addAll(data);
    notifyListeners();
  }

  Future<void> addTransaction(TransactionModel transaction) async {
    await localDataSource.insertTransaction(transaction);
    _transactions.add(transaction);
    notifyListeners();
  }

  void removeTransaction(TransactionModel transaction) {
    _transactions.remove(transaction);
    notifyListeners();
  }

  void clearTransactions() {
    _transactions.clear();
    notifyListeners();
  }

  void toggleTransactionSelection(TransactionModel transaction) {
    if (_selectedTransactions.contains(transaction)) {
      _selectedTransactions.remove(transaction);
    } else {
      _selectedTransactions.add(transaction);
    }
    notifyListeners();
  }

  void clearSelectedTransactions() {
    _selectedTransactions.clear();
    notifyListeners();
  }

  Future<void> uploadSelectedTransactions() async {
    if (_selectedTransactions.isEmpty) return;

    final transactionsToUpload = List<TransactionModel>.from(
      _selectedTransactions,
    );

    final success = await _apiService.uploadTransactions(transactionsToUpload);

    if (success) {
      for (var txn in transactionsToUpload) {
        _transactions.remove(txn);
      }
      _selectedTransactions.clear();
      notifyListeners();
    } else {
      print("error");
    }
  }

  Future<void> createAndSaveTransactionFromItems(List<ItemModel> items) async {
    if (items.isEmpty) return;

    final transactionDetails = convertItemsToTransactionDetails(items);

    final total = transactionDetails.fold<double>(
      0,
      (sum, item) => sum + (item.price * item.qty),
    );

    final transaction = TransactionModel(
      id: null,
      companyID: 1,
      branchID: 1,
      posid: 1,
      trType: 1,
      customerID: 1,
      customerName: 'Customer1',
      userID: '1',
      paymentType: 1,
      priceListID: 1,
      trDate: DateTime.now().toIso8601String(),
      poSsysID: 'POS001',
      note: 'done',
      transactionDetails: transactionDetails,

      paymentDetails: [
        PaymentDetailModel(
          transID: null,
          trType: 1,
          companyID: 1,
          branchID: 1,
          posid: 1,
          paymentType: 7,
          currencyID: 1,
          exRate: 1,
          amount: total,
        ),
      ],
    );

    await addTransaction(transaction);
    items.clear();
  }

  List<TransactionDetailModel> convertItemsToTransactionDetails(
    List<ItemModel> items,
  ) {
    return items.map((item) {
      return TransactionDetailModel(
        transID: null,
        companyID: 1,
        branchID: 1,
        posid: 1,
        itemID: item.id,
        trType: 1,
        lineSerial: '1',
        barcode: item.barcode,
        qty: 1,
        price: item.price.toDouble(),
        uPrice: item.price.toDouble(),
        discountAmount: 0,
        discountPer: 0,
        customerDiscount: 0,
        vouDiscount: 0,
        taxType: 0,
        taxAmount_1: 0,
        taxAmount_2: 0,
        taxPer_1: 0,
        taxPer_2: 0,
        note: '',
      );
    }).toList();
  }
}
