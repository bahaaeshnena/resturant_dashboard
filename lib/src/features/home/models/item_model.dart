// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ItemModel {
  final String id;
  final String name;
  final String price;

  ItemModel({
    required this.id,
    required this.name,
    required this.price,
  });

  ItemModel copyWith({
    String? name,
    String? id,
    String? price,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'price': price,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> map) {
    return ItemModel(
      id: map['id'] as String,
      name: map['name'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemModel.fromJson(String source) =>
      ItemModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant ItemModel other) {
    if (identical(this, other)) return true;

    return other.name == name && other.price == price && other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode ^ id.hashCode;
}
