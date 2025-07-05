import 'package:cloud_solutions_task/features/transactions/models/transaction_detail_additional_model.dart';

import 'transaction_detail_model.dart';
import 'payment_detail_model.dart';

class TransactionModel {
  final int companyID;
  final int branchID;
  final int posid;
  final int? id;
  final int trType;
  final int customerID;
  final String customerName;
  final String userID;
  final int paymentType;
  final int priceListID;
  final String trDate;
  final String poSsysID;
  final String note;
  final List<TransactionDetailModel> transactionDetails;
  final List<TransactionDetailAdditionalModel> transactionDetailsAdditional;
  final List<PaymentDetailModel> paymentDetails;

  TransactionModel({
    required this.companyID,
    required this.branchID,
    required this.posid,
    this.id,
    required this.trType,
    required this.customerID,
    required this.customerName,
    required this.userID,
    required this.paymentType,
    required this.priceListID,
    required this.trDate,
    required this.poSsysID,
    required this.note,
    required this.transactionDetails,
    this.transactionDetailsAdditional = const [],
    required this.paymentDetails,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      companyID: json['companyID'],
      branchID: json['branchID'],
      posid: json['posid'],
      id: json['id'],
      trType: json['trType'],
      customerID: json['customerID'],
      customerName: json['customerName'],
      userID: json['userID'],
      paymentType: json['paymentType'],
      priceListID: json['priceListID'],
      trDate: json['trDate'],
      poSsysID: json['poSsysID'],
      note: json['note'],
      transactionDetails: (json['transactionDetails'] as List)
          .map((e) => TransactionDetailModel.fromJson(e))
          .toList(),
      transactionDetailsAdditional:
          (json['transactionDetailsAdditional'] as List<dynamic>?)
              ?.map((e) => TransactionDetailAdditionalModel.fromJson(e))
              .toList() ??
          [],
      paymentDetails: (json['paymentDetails'] as List)
          .map((e) => PaymentDetailModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'branchID': branchID,
      'posid': posid,
      'id': id,
      'trType': trType,
      'customerID': customerID,
      'customerName': customerName,
      'userID': userID,
      'paymentType': paymentType,
      'priceListID': priceListID,
      'trDate': trDate,
      'poSsysID': poSsysID,
      'note': note,
      'transactionDetails': transactionDetails.map((e) => e.toJson()).toList(),
      'transactionDetailsAdditional': transactionDetailsAdditional
          .map((e) => e.toJson())
          .toList(),
      'paymentDetails': paymentDetails.map((e) => e.toJson()).toList(),
    };
  }

  TransactionModel copyWith({
    int? companyID,
    int? branchID,
    int? posid,
    int? id,
    int? trType,
    int? customerID,
    String? customerName,
    String? userID,
    int? paymentType,
    int? priceListID,
    String? trDate,
    String? poSsysID,
    String? note,
    List<TransactionDetailModel>? transactionDetails,
    List<TransactionDetailAdditionalModel>? transactionDetailsAdditional,
    List<PaymentDetailModel>? paymentDetails,
  }) {
    return TransactionModel(
      companyID: companyID ?? this.companyID,
      branchID: branchID ?? this.branchID,
      posid: posid ?? this.posid,
      id: id ?? this.id,
      trType: trType ?? this.trType,
      customerID: customerID ?? this.customerID,
      customerName: customerName ?? this.customerName,
      userID: userID ?? this.userID,
      paymentType: paymentType ?? this.paymentType,
      priceListID: priceListID ?? this.priceListID,
      trDate: trDate ?? this.trDate,
      poSsysID: poSsysID ?? this.poSsysID,
      note: note ?? this.note,
      transactionDetails: transactionDetails ?? this.transactionDetails,
      transactionDetailsAdditional:
          transactionDetailsAdditional ?? this.transactionDetailsAdditional,
      paymentDetails: paymentDetails ?? this.paymentDetails,
    );
  }
}
