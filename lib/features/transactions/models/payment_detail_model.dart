class PaymentDetailModel {
  final int companyID;
  final int branchID;
  final int posid;
  final int trType;
  final int? transID;
  final int paymentType;
  final int currencyID;
  final double exRate;
  final double amount;

  PaymentDetailModel({
    required this.companyID,
    required this.branchID,
    required this.posid,
    required this.trType,
    this.transID,
    required this.paymentType,
    required this.currencyID,
    required this.exRate,
    required this.amount,
  });

  factory PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailModel(
      companyID: json['companyID'],
      branchID: json['branchID'],
      posid: json['posid'],
      trType: json['trType'],
      transID: json['transID'],
      paymentType: json['paymentType'],
      currencyID: json['currencyID'],
      exRate: (json['exRate'] as num).toDouble(),
      amount: (json['amount'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'branchID': branchID,
      'posid': posid,
      'trType': trType,
      'transID': transID,
      'paymentType': paymentType,
      'currencyID': currencyID,
      'exRate': exRate,
      'amount': amount,
    };
  }
}
