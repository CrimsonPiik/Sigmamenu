import 'dart:convert';

class Staggerd {
  String image = 'assets/images/placeholder.jpg';
  String name = 'AdsName';
  String nameAr = 'AdsName';
  String id = 'id';
  String superCategory = 'superCategory';
  String route = 'route';
  bool isPublished = true;

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'nameAr': nameAr,
      'id': id,
      'superCategory': superCategory,
      'route': route,
      'isPublished': isPublished.toString() == 'true' ? true : false,
    };
  }

  Staggerd.fromMap(Map<String, dynamic> map)
      : image = map['image'] == null || map['image'] == 'image'
            ? 'assets/images/placeholder.jpg'
            : map['image'],
        name = map['name'] ?? '',
        nameAr = map['nameAr'] ?? '',
        id = map['id'] ?? '',
        superCategory = map['superCategory'] ?? '',
        route = map['route'] ?? '',
        isPublished = map['isPublished'].toString() == 'true' ? true : false;

  String toJson() => json.encode(toMap());

  factory Staggerd.fromJson(String source) =>
      Staggerd.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BannerModel( image: $image,id: $id,name: $name,nameAr: $nameAr,superCategory: $superCategory,route: $route)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Staggerd &&
        other.image == image &&
        other.name == name &&
        other.nameAr == nameAr &&
        other.id == id &&
        other.superCategory == superCategory &&
        other.route == route &&
        other.isPublished == isPublished;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        name.hashCode ^
        nameAr.hashCode ^
        id.hashCode ^
        superCategory.hashCode ^
        route.hashCode ^
        isPublished.hashCode;
  }
}
