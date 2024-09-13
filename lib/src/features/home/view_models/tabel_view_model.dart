import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/tabeles/tabel_repo.dart';
import 'package:task/src/features/home/models/tabel_model.dart';
import 'package:uuid/uuid.dart';

class TableViewModel extends ChangeNotifier {
  TableViewModel({required TableRepo tableRepo}) : _tableRepo = tableRepo;

  final TableRepo _tableRepo;
  List<TabelModel> _tables = [];
  List<TabelModel> get tables => _tables;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  String? _successMessage;
  String? get successMessage => _successMessage;

  GlobalKey<FormState> addTabelFormKey = GlobalKey<FormState>();
  final TextEditingController numberOfChairsController =
      TextEditingController();

  Future<void> fetchTables() async {
    _setLoading(true);
    try {
      _tables = await _tableRepo.getTables();
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Failed to fetch tables';
    } finally {
      _setLoading(false);
    }
  }

  Future<void> addTable() async {
    if (!addTabelFormKey.currentState!.validate()) {
      return;
    }

    _setLoading(true);
    try {
      String id = const Uuid().v4();
      TabelModel newTable = TabelModel(
        id: id,
        numberOfChairs: numberOfChairsController.text,
      );

      await _tableRepo.addTable(newTable);
      _tables.add(newTable);
      _errorMessage = null;
      _successMessage = 'Table added successfully';
      numberOfChairsController.clear();
    } catch (e) {
      _errorMessage = 'Failed to add table';
      _successMessage = null;
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
