import 'dart:convert';

class TableModel {
  final String? id;
  final String name;
  final String status;
  final String numberOfChairs;

  TableModel({
    this.id,
    required this.status,
    required this.name,
    required this.numberOfChairs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'condition': status,
      'numberOfChairs': numberOfChairs,
    };
  }

  factory TableModel.fromMap(Map<String, dynamic> map) {
    return TableModel(
      id: map['id'] as String,
      name: map['name'] as String,
      status: map['condition'] as String,
      numberOfChairs: map['numberOfChairs'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TableModel.fromJson(String source) =>
      TableModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TableModel copyWith({
    String? id,
    String? name,
    String? condition,
    String? numberOfChairs,
    required String status,
  }) {
    return TableModel(
      id: id ?? this.id,
      name: name ?? this.name,
      // ignore: unnecessary_this
      status: condition ?? this.status,
      numberOfChairs: numberOfChairs ?? this.numberOfChairs,
    );
  }
}
