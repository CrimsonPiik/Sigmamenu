import 'dart:convert';


class BannerModel {
  String image = 'assets/images/placeholder.jpg';
  String nameEn = 'AdsNameEn';
  String nameAr = 'AdsNameAr';
  // String vendorId = 'KertenHospitality';
  String subCategoryId = 'subCategoryId';
  String categoryId = 'categoryId';
  String descriptionEn = 'descriptionEn';
  String descriptionAr = 'descriptionAr';
  bool isPublished = true;

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'nameEn': nameEn,
      'nameAr': nameAr,
      // 'vendorId': vendorId,
      'subCategoryId': subCategoryId,
      'categoryId': categoryId,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'isPublished': isPublished.toString() == 'true' ? true : false,
    };
  }

  BannerModel.fromMap(Map<String, dynamic> map)
      : image = map['image'] == null || map['image'] == 'image' ? 'assets/images/placeholder.jpg' : map['image'],
        nameEn = map['nameEn'] ?? '',
        nameAr = map['nameAr'] ?? '',
        // vendorId = map['vendorId'] ?? '',
        subCategoryId = map['subCategoryId'] ?? '',
        categoryId = map['categoryId'] ?? '',
        descriptionEn = map['descriptionEn'] ?? '',
        descriptionAr = map['descriptionAr'] ?? '',
        isPublished = map['isPublished'].toString() == 'true' ? true : false;

  String toJson() => json.encode(toMap());

  factory BannerModel.fromJson(String source) => BannerModel.fromMap(json.decode(source));

  @override
  String toString() {
    /*vendorId: $vendorId,*/
    return 'BannerModel(  image: $image, nameEn: $nameEn, nameAr: $nameAr, subCategoryId: $subCategoryId, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BannerModel &&
        other.image == image &&
        other.nameEn == nameEn &&
        other.nameAr == nameAr &&
        // other.vendorId == vendorId &&
        other.subCategoryId == subCategoryId &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.isPublished == isPublished;
  }

  @override
  int get hashCode {
    return image.hashCode ^
        nameEn.hashCode ^
        nameAr.hashCode ^
        // vendorId.hashCode ^
        subCategoryId.hashCode ^
        descriptionEn.hashCode ^
        descriptionAr.hashCode ^
        isPublished.hashCode;
  }
}
