import 'dart:convert';

class CategoryModel {
  String nameAr = ';ppp';

  Map<String, dynamic> toMap() {
    return {
      'nameAr': nameAr,
    };
  }

  CategoryModel.fromMap(Map<String, dynamic> map)
      : nameAr = map['nameAr'] ?? '';

  String toJson() => json.encode(toMap());

  factory CategoryModel.fromJson(String source) =>
      CategoryModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CategoryModel ( nameAr: $nameAr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CategoryModel && other.nameAr == nameAr;
  }

  @override
  int get hashCode {
    return nameAr.hashCode;
  }
}
