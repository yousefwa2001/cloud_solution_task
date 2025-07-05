import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/transaction_model.dart';
import '../models/transaction_detail_model.dart';
import '../models/payment_detail_model.dart';

class TransactionLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDb();
    return _database!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'transactions.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE transactions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        companyID INTEGER,
        branchID INTEGER,
        posid INTEGER,
        trType INTEGER,
        customerID INTEGER,
        customerName TEXT,
        userID TEXT,
        paymentType INTEGER,
        priceListID INTEGER,
        trDate TEXT,
        poSsysID TEXT,
        note TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE transaction_details (
        transID INTEGER,
        companyID INTEGER,
        branchID INTEGER,
        posid INTEGER,
        itemID INTEGER,
        trType INTEGER,
        lineSerial TEXT,
        barcode TEXT,
        qty REAL,
        price REAL,
        uPrice REAL,
        discountAmount REAL,
        discountPer REAL,
        customerDiscount REAL,
        vouDiscount REAL,
        taxType INTEGER,
        taxAmount_1 REAL,
        taxAmount_2 REAL,
        taxPer_1 REAL,
        taxPer_2 REAL,
        note TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE payment_details (
        transID INTEGER,
        trType INTEGER,
        companyID INTEGER,
        branchID INTEGER,
        posid INTEGER,
        paymentType INTEGER,
        currencyID INTEGER,
        exRate REAL,
        amount REAL
      )
    ''');
    await db.insert('sqlite_sequence', {'name': 'transactions', 'seq': 10});
  }

  Future<void> insertTransaction(TransactionModel transaction) async {
    final db = await database;

    final newId = await db.insert('transactions', {
      'companyID': transaction.companyID,
      'branchID': transaction.branchID,
      'posid': transaction.posid,
      'trType': transaction.trType,
      'customerID': transaction.customerID,
      'customerName': transaction.customerName,
      'userID': transaction.userID,
      'paymentType': transaction.paymentType,
      'priceListID': transaction.priceListID,
      'trDate': transaction.trDate,
      'poSsysID': transaction.poSsysID,
      'note': transaction.note,
    });

    for (var detail in transaction.transactionDetails) {
      final data = detail.toJson();
      data['transID'] = newId;
      await db.insert('transaction_details', data);
    }

    for (var payment in transaction.paymentDetails) {
      final data = payment.toJson();
      data['transID'] = newId;
      await db.insert('payment_details', data);
    }
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    final db = await database;
    final maps = await db.query('transactions');

    List<TransactionModel> transactions = [];
    for (var map in maps) {
      final id = map['id'] as int;

      final details = await db.query(
        'transaction_details',
        where: 'transID = ?',
        whereArgs: [id],
      );
      final payments = await db.query(
        'payment_details',
        where: 'transID = ?',
        whereArgs: [id],
      );

      transactions.add(
        TransactionModel(
          id: id,
          companyID: map['companyID'] as int,
          branchID: map['branchID'] as int,
          posid: map['posid'] as int,
          trType: map['trType'] as int,
          customerID: map['customerID'] as int,
          customerName: map['customerName'] as String,
          userID: map['userID'] as String,
          paymentType: map['paymentType'] as int,
          priceListID: map['priceListID'] as int,
          trDate: map['trDate'] as String,
          poSsysID: map['poSsysID'] as String,
          note: map['note'] as String,

          transactionDetails: details
              .map((e) => TransactionDetailModel.fromJson(e))
              .toList(),
          paymentDetails: payments
              .map((e) => PaymentDetailModel.fromJson(e))
              .toList(),
        ),
      );
    }

    return transactions;
  }
}
