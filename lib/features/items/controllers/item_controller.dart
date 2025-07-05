import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../services/item_api_service.dart';
import '../services/item_local_data_source.dart';

class ItemController extends ChangeNotifier {
  final ItemApiService _apiService = ItemApiService();
  final ItemLocalDataSource _localDataSource = ItemLocalDataSource();

  List<ItemModel> _items = [];
  List<ItemModel> get items => _items;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;
  final List<ItemModel> _selectedItems = [];
  List<ItemModel> get selectedItems => _selectedItems;

  Future<void> fetchItems() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final fetchedItems = await _apiService.fetchItems();

      await _localDataSource.insertItems(fetchedItems);

      _items = await _localDataSource.getItems();
    } catch (e) {
      _error = e.toString();

      try {
        _items = await _localDataSource.getItems();
      } catch (_) {}
    }

    _isLoading = false;
    notifyListeners();
  }

  void toggleItemSelection(ItemModel item) {
    if (selectedItems.contains(item)) {
      selectedItems.remove(item);
    } else {
      selectedItems.add(item);
    }
    notifyListeners();
  }

  void clearSelectedItems() {
    _selectedItems.clear();
    notifyListeners();
  }
}
