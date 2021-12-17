import 'dart:convert';

class BannerModel {
  String image = 'assets/images/placeholder.jpg';
  // String name = 'AdsName';
  String id = 'id';
  // String nameAr = 'AdsNameAr';
  // String subCategoryId = 'subCategoryId';
  // String category = 'category';
  // String descriptionEn = 'descriptionEn';
  // String descriptionAr = 'descriptionAr';
  bool isPublished = true;

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      // 'name': name,

      'id': id,

      // 'nameAr': nameAr/,
      // 'subCategoryId': subCategoryId,
      // 'category': category,
      // 'descriptionEn': descriptionEn,
      // 'descriptionAr': descriptionAr,
      'isPublished': isPublished.toString() == 'true' ? true : false,
    };
  }

  BannerModel.fromMap(Map<String, dynamic> map)
      : image = map['image'] == null || map['image'] == 'image'
            ? 'assets/images/placeholder.jpg'
            : map['image'],
        // name = map['name'] ?? '',
        id = map['id'] ?? '',
        // subCategoryId = map['subCategoryId'] ?? '',
        // category = map['category'] ?? '',
        // descriptionEn = map['descriptionEn'] ?? '',
        // descriptionAr = map['descriptionAr'] ?? '',
        isPublished = map['isPublished'].toString() == 'true' ? true : false;

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) =>
      BannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BannerModel( image: $image,id: $id)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.image == image &&
        // other.name == name &&
        other.id == id &&
        // other.subCategoryId == subCategoryId &&
        // other.category == category &&

        // other.descriptionEn == descriptionEn &&
        // other.descriptionAr == descriptionAr &&
        other.isPublished == isPublished;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        // name.hashCode ^
        id.hashCode ^
        // subCategoryId.hashCode ^
        // category.hashCode ^

        // descriptionEn.hashCode ^
        // descriptionAr.hashCode ^
        isPublished.hashCode;
  }
}
