import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/invoice/invoice_repo.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/models/table_model.dart';

class InvoiceViewModel with ChangeNotifier {
  InvoiceViewModel({required InvoiceRepo invoiceRepo})
      : _invoiceRepo = invoiceRepo;

  // ignore: unused_field
  final InvoiceRepo _invoiceRepo;

  TableModel? _selectedTable;
  // ignore: prefer_final_fields
  List<ItemModel> _items = [];
  double _totalPrice = 0.0;

  TableModel? get selectedTable => _selectedTable;
  List<ItemModel> get items => _items;
  double get totalPrice => _totalPrice;
}
