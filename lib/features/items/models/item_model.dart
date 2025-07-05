class ItemModel {
  final int id;
  final int companyID;
  final int categoryID;
  final String itemCode;
  final String name;
  final double price;
  final int taxPercent;
  final int discountPercent;
  final String barcode;

  ItemModel({
    required this.id,
    required this.companyID,
    required this.categoryID,
    required this.itemCode,
    required this.name,
    required this.price,
    required this.taxPercent,
    required this.discountPercent,
    required this.barcode,
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      companyID: json['companyID'],
      categoryID: json['categoryID'],
      itemCode: json['itemCode'],
      name: json['name'],
      price: (json['price'] as num).toDouble(),
      taxPercent: json['taxPercent'],
      discountPercent: json['discountPercent'],
      barcode: json['barcode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyID': companyID,
      'categoryID': categoryID,
      'itemCode': itemCode,
      'name': name,
      'price': price,
      'taxPercent': taxPercent,
      'discountPercent': discountPercent,
      'barcode': barcode,
    };
  }
}
