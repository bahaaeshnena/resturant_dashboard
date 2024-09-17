import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/models/table_model.dart';

class InvoiceModel {
  final String? id;
  final TableModel table;
  final List<ItemModel> items;
  final DateTime? date;
  final double totalPrice;
  final bool paid;

  InvoiceModel({
    this.paid = false,
    this.id,
    required this.table,
    required this.items,
    required this.date,
    required this.totalPrice,
  });

  InvoiceModel copyWith({
    String? id,
    TableModel? table,
    List<ItemModel>? items,
    DateTime? date,
    double? totalPrice,
    bool? paid,
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      table: table ?? this.table,
      items: items ?? this.items,
      date: date ?? this.date,
      totalPrice: totalPrice ?? this.totalPrice,
      paid: paid ?? this.paid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'table': table.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'date': date?.toIso8601String(),
      'totalPrice': totalPrice,
      'paid': paid,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] != null ? map['id'] as String : null,
      table: TableModel.fromMap(map['table'] as Map<String, dynamic>),
      items: List<ItemModel>.from(
        (map['items'] as List<dynamic>).map<ItemModel>(
          (x) => ItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: map['date'] != null
          ? DateTime.parse(map['date'])
          : null, // Parse ISO 8601 string to DateTime
      totalPrice: map['totalPrice'] as double,
      paid: map['paid'] != null ? map['paid'] as bool : false,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(id: $id, table: $table, items: $items, date: $date, totalPrice: $totalPrice,paid: $paid)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.table == table &&
        listEquals(other.items, items) &&
        other.date == date &&
        other.totalPrice == totalPrice &&
        other.paid == paid;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        table.hashCode ^
        items.hashCode ^
        date.hashCode ^
        totalPrice.hashCode ^
        paid.hashCode;
  }
}
