import 'dart:convert';
import 'package:cloud_solutions_task/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/transaction_model.dart';

class TransactionApiService {
  Future<bool> uploadTransactions(List<TransactionModel> transactions) async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/api/POSTransaction/AddPOSTransaction',
    );
    final body = jsonEncode(transactions.map((e) => e.toJson()).toList());

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      print('done');
      return true;
    } else {
      print('error ${response.statusCode}');
      return false;
    }
  }
}
