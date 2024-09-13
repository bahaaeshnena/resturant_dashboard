import 'dart:convert';

class TabelModel {
  final String condition;
  final String numberOfChairs;

  TabelModel({
    required this.condition,
    required this.numberOfChairs,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'condition': condition,
      'numberOfChairs': numberOfChairs,
    };
  }

  factory TabelModel.fromMap(Map<String, dynamic> map) {
    return TabelModel(
      condition: map['condition'] as String,
      numberOfChairs: map['numberOfChairs'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TabelModel.fromJson(String source) =>
      TabelModel.fromMap(json.decode(source) as Map<String, dynamic>);

  TabelModel copyWith({
    String? condition,
    String? numberOfChairs,
  }) {
    return TabelModel(
      condition: condition ?? this.condition,
      numberOfChairs: numberOfChairs ?? this.numberOfChairs,
    );
  }
}
