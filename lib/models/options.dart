import 'dart:convert';

import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';

class OptionsModel {
  String id = generateId();

  Map<String, dynamic> options = {};

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'options': options,
    };
  }

  Map<String, dynamic> createNewProduct() {
    return {
      'id': id,
      'options': options,
    };
  }

  OptionsModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        options = map['options'];

  String toJson() => json.encode(toMap());

  factory OptionsModel.fromJson(String source) =>
      OptionsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Options: $options';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OptionsModel && other.id == id && other.options == options;
  }

  @override
  int get hashCode {
    return id.hashCode ^ options.hashCode;
  }
}
