import 'dart:convert';
import 'package:cloud_solutions_task/core/constants/api_constants.dart';
import 'package:http/http.dart' as http;
import '../models/item_model.dart';

class ItemApiService {
  Future<List<ItemModel>> fetchItems() async {
    final url = Uri.parse(
      '${ApiConstants.baseUrl}/api/Item/GetItems?CompanyID=1&BranchID=1&POSID=1',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['isSuccess'] == true) {
          final List<dynamic> itemsJson = data['lst'];
          return itemsJson.map((json) => ItemModel.fromJson(json)).toList();
        } else {
          throw Exception('API error: ${data['errorMessage']}');
        }
      } else {
        throw Exception('HTTP error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Fetch failed: $e');
    }
  }
}
