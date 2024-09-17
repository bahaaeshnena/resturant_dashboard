import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:task/src/features/home/models/item_model.dart';
import 'package:task/src/features/home/models/table_model.dart';

class InvoiceModel {
  final String? id;
  final TableModel table;
  final List<ItemModel> items;
  final DateTime date;
  final double totalPrice;
  InvoiceModel({
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
  }) {
    return InvoiceModel(
      id: id ?? this.id,
      table: table ?? this.table,
      items: items ?? this.items,
      date: date ?? this.date,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'table': table.toMap(),
      'items': items.map((x) => x.toMap()).toList(),
      'date': date.millisecondsSinceEpoch,
      'totalPrice': totalPrice,
    };
  }

  factory InvoiceModel.fromMap(Map<String, dynamic> map) {
    return InvoiceModel(
      id: map['id'] != null ? map['id'] as String : null,
      table: TableModel.fromMap(map['table'] as Map<String, dynamic>),
      items: List<ItemModel>.from(
        (map['items'] as List<int>).map<ItemModel>(
          (x) => ItemModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      totalPrice: map['totalPrice'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory InvoiceModel.fromJson(String source) =>
      InvoiceModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'InvoiceModel(id: $id, table: $table, items: $items, date: $date, totalPrice: $totalPrice)';
  }

  @override
  bool operator ==(covariant InvoiceModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.table == table &&
        listEquals(other.items, items) &&
        other.date == date &&
        other.totalPrice == totalPrice;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        table.hashCode ^
        items.hashCode ^
        date.hashCode ^
        totalPrice.hashCode;
  }
}
