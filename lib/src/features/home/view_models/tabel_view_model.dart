// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/tabeles/tabel_repo.dart';
import 'package:task/src/features/home/models/tabel_model.dart';
import 'package:uuid/uuid.dart';

class TableViewModel extends ChangeNotifier {
  TableViewModel({required TableRepo tableRepo}) : _tableRepo = tableRepo;

  final TableRepo _tableRepo;
  final List<TableModel> _tables = [];
  List<TableModel> get tables => _tables;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  String _status = 'Available';
  String get status => _status;
  String tableId = '';

  set status(String value) {
    _status = value;
    notifyListeners();
  }

  GlobalKey<FormState> addTabelFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateTabelFormKey = GlobalKey<FormState>();

  final TextEditingController numberOfChairsController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();

  // final TextEditingController updateNumberOfChairsController =
  //     TextEditingController();
  // final TextEditingController updateNameController = TextEditingController();
  // final TextEditingController updateStatusController = TextEditingController();

  Stream<List<TableModel>> get tablesStream => _tableRepo.streamTables();

  Future<void> addTable(BuildContext context) async {
    if (!addTabelFormKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);
    try {
      var querySnapshot = await _tableRepo.getTablesByName(nameController.text);

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
      TableModel newTable = TableModel(
        id: id,
        status: statusController.text,
        name: nameController.text,
        numberOfChairs: numberOfChairsController.text,
      );

      await _tableRepo.addTable(newTable);
      _tables.add(newTable);
      _errorMessage = null;
      _successMessage = 'Table added successfully';
      numberOfChairsController.clear();
      nameController.clear();

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
      notifyListeners();
    }
  }

  Future<void> deleteTable(String id) async {
    try {
      await _tableRepo.deleteTable(id);
      _tables.removeWhere((table) => table.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete table';
      notifyListeners();
    }
  }

  Future<void> updateTable(BuildContext context, String id) async {
    if (!updateTabelFormKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);
    try {
      // Fetch tables by name to check for name conflicts
      var querySnapshot = await _tableRepo.getTablesByName(nameController.text);

      if (querySnapshot.docs.isNotEmpty && querySnapshot.docs.first.id != id) {
        _errorMessage = 'Table name is already in use';
        _successMessage = null;

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_errorMessage!),
            backgroundColor: Colors.red,
          ),
        );

        notifyListeners();
        return;
      }

      // Create the updated table model
      TableModel updatedTable = TableModel(
        id: id,
        status: statusController.text,
        name: nameController.text,
        numberOfChairs: numberOfChairsController.text,
      );

      // Update the table in the repository
      await _tableRepo.updateTable(updatedTable);

      // Update the local table list
      final index = _tables.indexWhere((table) => table.id == id);
      if (index != -1) {
        _tables[index] = updatedTable;
      }

      _errorMessage = null;
      _successMessage = 'Table updated successfully';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_successMessage!),
        ),
      );
    } catch (e) {
      _errorMessage = 'Failed to update table';
      _successMessage = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      _setLoading(false);
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
}
