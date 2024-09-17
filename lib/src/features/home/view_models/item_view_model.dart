// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/items/items_repo.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:uuid/uuid.dart';

class ItemViewModel with ChangeNotifier {
  ItemViewModel({required ItemsRepo itemRepo}) : _itemRepo = itemRepo;

  final ItemsRepo _itemRepo;

  final List<ItemModel> _tables = [];
  List<ItemModel> get tables => _tables;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  GlobalKey<FormState> addItemFormKey = GlobalKey<FormState>();
  final TextEditingController nameItemController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  Stream<List<ItemModel>> get tablesStream => _itemRepo.streamItems();

  Future<void> addTable(BuildContext context) async {
    if (!addItemFormKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);
    try {
      var querySnapshot =
          await _itemRepo.getItemsByName(nameItemController.text);

      if (querySnapshot.docs.isNotEmpty) {
        _errorMessage = 'Table name is already in use';
        _successMessage = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
          ),
        );

        notifyListeners();
        _setLoading(false);
        return;
      }

      String id = const Uuid().v4();
      ItemModel newItem = ItemModel(
        id: id,
        name: nameItemController.text,
        price: int.parse(priceController.text),
      );

      await _itemRepo.addItem(newItem);
      _tables.add(newItem);
      _errorMessage = null;
      _successMessage = 'Item added successfully';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_successMessage!),
        ),
      );
    } catch (e) {
      _errorMessage = 'Failed to add table';
      _successMessage = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _setLoading(false);
      clearController();
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearMessages() {
    _errorMessage = null;
    _successMessage = null;
    notifyListeners();
  }

  void clearController() {
    nameItemController.clear();
    priceController.clear();
    notifyListeners();
  }
}
