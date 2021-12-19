import 'dart:convert';

class BannerModel {
  String image = 'assets/images/placeholder.jpg';
  String id = 'id';
  bool isPublished = true;

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'id': id,
      'isPublished': isPublished.toString() == 'true' ? true : false,
    };
  }

  BannerModel.fromMap(Map<String, dynamic> map)
      : image = map['image'] == null || map['image'] == 'image'
            ? 'assets/images/placeholder.jpg'
            : map['image'],
        id = map['id'] ?? '',
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
        other.id == id &&
        other.isPublished == isPublished;
  }

  @override
  int get hashCode {
    return image.hashCode ^ id.hashCode ^ isPublished.hashCode;
  }
}
