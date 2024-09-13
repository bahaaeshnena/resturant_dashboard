import 'dart:convert';

class TabelModel {
  final String? id;
  final String? condition;
  final String numberOfChairs;

  TabelModel({
    this.id,
    this.condition = "Available",
    required this.numberOfChairs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'condition': condition,
      'numberOfChairs': numberOfChairs,
    };
  }

  factory TabelModel.fromMap(Map<String, dynamic> map) {
    return TabelModel(
      id: map['id'] as String,
      condition: map['condition'] as String,
      numberOfChairs: map['numberOfChairs'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TabelModel.fromJson(String source) =>
      TabelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TabelModel copyWith({
    String? id,
    String? condition,
    String? numberOfChairs,
  }) {
    return TabelModel(
      id: id ?? this.id,
      condition: condition ?? this.condition,
      numberOfChairs: numberOfChairs ?? this.numberOfChairs,
    );
  }
}
