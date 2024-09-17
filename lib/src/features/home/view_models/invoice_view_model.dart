import 'package:flutter/material.dart';
import 'package:task/src/core/data/repositories/invoice/invoice_repo.dart';
import 'package:task/src/features/home/models/invoice_model.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/models/table_model.dart';
import 'package:uuid/uuid.dart';

class InvoiceViewModel with ChangeNotifier {
  InvoiceViewModel({required InvoiceRepo invoiceRepo})
      : _invoiceRepo = invoiceRepo;

  final InvoiceRepo _invoiceRepo;

  Future<void> createInvoice(
      TableModel table, List<ItemModel> items, double totalPrice) async {
    String id = const Uuid().v4();
    DateTime date = DateTime.now();

    InvoiceModel newInvoice = InvoiceModel(
      id: id,
      table: table,
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
}
