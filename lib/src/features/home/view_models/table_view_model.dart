// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/tables/table_repo.dart';
import 'package:task/src/features/home/models/table_model.dart';
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

  GlobalKey<FormState> addTabelFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> updateTabelFormKey = GlobalKey<FormState>();

  final TextEditingController numberOfChairsController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController tablesSelectedController =
      TextEditingController();

  String? _selectedTable;

  String? get selectedTable => _selectedTable;

  void setSelectedTable(String? value) {
    _selectedTable = value;
    notifyListeners();
  }

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
      clearController();
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

  Future<void> updateStatus(String id, String status) async {
    try {
      await _tableRepo.updateStatus(id, status);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to update table status';
      notifyListeners();
    }
  }

  Future<void> updateTable(
      BuildContext context, String id, TableModel table) async {
    _setLoading(true);
    try {
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

      TableModel updatedTable = TableModel(
        id: id,
        status: statusController.text.isEmpty
            ? table.status
            : statusController.text,
        name: nameController.text.isEmpty ? table.name : nameController.text,
        numberOfChairs: numberOfChairsController.text.isEmpty
            ? table.numberOfChairs
            : numberOfChairsController.text,
      );

      await _tableRepo.updateTable(updatedTable);

      final index = _tables.indexWhere((t) => t.id == id);
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
    numberOfChairsController.clear();
    nameController.clear();
    statusController.clear();
    notifyListeners();
  }
}
