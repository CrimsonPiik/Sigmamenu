import 'dart:convert';

class OptionsModel {
  Map<String, dynamic> options = {};

  Map<String, dynamic> toMap() {
    return {
      'options': options,
    };
  }

  Map<String, dynamic> createNewProduct() {
    return {
      'options': options,
    };
  }

  OptionsModel.fromMap(Map<String, dynamic> map) : options = map['options'];

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

    return other is OptionsModel && other.options == options;
  }

  @override
  int get hashCode {
    return options.hashCode;
  }
}
