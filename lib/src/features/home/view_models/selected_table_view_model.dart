import 'package:flutter/material.dart';
import 'package:task/src/features/home/models/table_model.dart';

class SelectedTableViewModel extends ChangeNotifier {
  TableModel? _selectedTable;

  TableModel? get selectedTable => _selectedTable;

  void selectTable(TableModel table) {
    _selectedTable = table;
    notifyListeners();
  }
}
