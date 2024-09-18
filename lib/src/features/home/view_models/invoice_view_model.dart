import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/invoice/invoice_repo.dart';
import 'package:task/src/features/home/models/invoice_model.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:uuid/uuid.dart';

import 'package:intl/intl.dart';

class InvoiceViewModel with ChangeNotifier {
  InvoiceViewModel({required InvoiceRepo invoiceRepo})
      : _invoiceRepo = invoiceRepo;

  final InvoiceRepo _invoiceRepo;
  final List<TableModel> _invoices = [];

  String? _errorMessage;
  String? get errorMessage => _errorMessage;
  List<TableModel> get invoices => _invoices;
  Future<void> createInvoice(
      TableModel tableName, List<ItemModel> items, double totalPrice) async {
    String id = const Uuid().v4();
    DateTime date = DateTime.now();

    InvoiceModel newInvoice = InvoiceModel(
      id: id,
      table: TableModel(
        name: tableName.name,
        id: tableName.id,
        status: tableName.status,
        numberOfChairs: tableName.numberOfChairs,
      ),
      items: items,
      date: date,
      totalPrice: totalPrice,
    );

    try {
      await _invoiceRepo.addInvoice(newInvoice);
    } catch (e) {
      throw Exception('Failed to create invoice: $e');
    }
  }

  Future<void> deleteInvoice(String id) async {
    try {
      await _invoiceRepo.deleteInvoice(id);
      _invoices.removeWhere((table) => table.id == id);
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to delete table';
      notifyListeners();
    }
  }

  String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
}
