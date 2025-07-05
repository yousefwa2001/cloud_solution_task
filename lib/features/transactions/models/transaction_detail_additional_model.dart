class TransactionDetailAdditionalModel {
  final int companyID;
  final int branchID;
  final int posid;
  final int transID;
  final int trType;
  final int itemID;
  final String lineSerial;
  final String barcode;
  final double qty;
  final double price;
  final int additionalID;
  final String additionalSerial;

  TransactionDetailAdditionalModel({
    required this.companyID,
    required this.branchID,
    required this.posid,
    required this.transID,
    required this.trType,
    required this.itemID,
    required this.lineSerial,
    required this.barcode,
    required this.qty,
    required this.price,
    required this.additionalID,
    required this.additionalSerial,
  });

  factory TransactionDetailAdditionalModel.fromJson(
    Map<String, dynamic> json,
  ) => TransactionDetailAdditionalModel(
    companyID: json['companyID'],
    branchID: json['branchID'],
    posid: json['posid'],
    transID: json['transID'],
    trType: json['trType'],
    itemID: json['itemID'],
    lineSerial: json['lineSerial'],
    barcode: json['barcode'],
    qty: json['qty'].toDouble(),
    price: json['price'].toDouble(),
    additionalID: json['additionalID'],
    additionalSerial: json['additionalSerial'],
  );

  Map<String, dynamic> toJson() => {
    'companyID': companyID,
    'branchID': branchID,
    'posid': posid,
    'transID': transID,
    'trType': trType,
    'itemID': itemID,
    'lineSerial': lineSerial,
    'barcode': barcode,
    'qty': qty,
    'price': price,
    'additionalID': additionalID,
    'additionalSerial': additionalSerial,
  };
}
