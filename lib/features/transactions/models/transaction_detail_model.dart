class TransactionDetailModel {
  final int? transID;
  final int companyID;
  final int branchID;
  final int posid;
  final int itemID;
  final int trType;
  final String lineSerial;
  final String barcode;
  final double qty;
  final double price;
  final double uPrice;
  final double discountAmount;
  final double discountPer;
  final double customerDiscount;
  final double vouDiscount;
  final int taxType;
  final double taxAmount_1;
  final double taxAmount_2;
  final double taxPer_1;
  final double taxPer_2;
  final String note;

  TransactionDetailModel({
    this.transID,
    required this.companyID,
    required this.branchID,
    required this.posid,
    required this.itemID,
    required this.trType,
    required this.lineSerial,
    required this.barcode,
    required this.qty,
    required this.price,
    required this.uPrice,
    required this.discountAmount,
    required this.discountPer,
    required this.customerDiscount,
    required this.vouDiscount,
    required this.taxType,
    required this.taxAmount_1,
    required this.taxAmount_2,
    required this.taxPer_1,
    required this.taxPer_2,
    required this.note,
  });

  Map<String, dynamic> toJson() {
    return {
      'transID': transID,
      'companyID': companyID,
      'branchID': branchID,
      'posid': posid,
      'itemID': itemID,
      'trType': trType,
      'lineSerial': lineSerial,
      'barcode': barcode,
      'qty': qty,
      'price': price,
      'uPrice': uPrice,
      'discountAmount': discountAmount,
      'discountPer': discountPer,
      'customerDiscount': customerDiscount,
      'vouDiscount': vouDiscount,
      'taxType': taxType,
      'taxAmount_1': taxAmount_1,
      'taxAmount_2': taxAmount_2,
      'taxPer_1': taxPer_1,
      'taxPer_2': taxPer_2,
      'note': note,
    };
  }

  factory TransactionDetailModel.fromJson(Map<String, dynamic> json) {
    return TransactionDetailModel(
      transID: json['transID'],
      companyID: json['companyID'],
      branchID: json['branchID'],
      posid: json['posid'],
      itemID: json['itemID'],
      trType: json['trType'],
      lineSerial: json['lineSerial'],
      barcode: json['barcode'],
      qty: json['qty'],
      price: json['price'],
      uPrice: json['uPrice'],
      discountAmount: json['discountAmount'],
      discountPer: json['discountPer'],
      customerDiscount: json['customerDiscount'],
      vouDiscount: json['vouDiscount'],
      taxType: json['taxType'],
      taxAmount_1: json['taxAmount_1'],
      taxAmount_2: json['taxAmount_2'],
      taxPer_1: json['taxPer_1'],
      taxPer_2: json['taxPer_2'],
      note: json['note'],
    );
  }
}
