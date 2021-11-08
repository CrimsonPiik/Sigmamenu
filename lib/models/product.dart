import 'dart:convert';
import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';
import 'package:sigmamenu/models/rating.dart';

class Product {
  String id = generateId();
  double price = 0.00;
  String image = 'assets/images/placeholder.jpg';
  String nameEn = 'productNameEn';
  String nameAr = 'productNameAr';
  String category = 'categoryId';
  String descriptionEn = 'descriptionEn';
  String descriptionAr = 'descriptionAr';
  bool isPublished = true;
  bool isOnSale = false;
  Rating rating = Rating();
  int weight = 0;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'weight': weight,
      'price': double.tryParse(price.toString()) ?? 0.00,
      'image': image,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'category': category,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'isPublished': isPublished,
      'isOnSale': isOnSale,
    };
  }

  Map<String, dynamic> createNewProduct() {
    return {
      'id': id,
      'weight': weight,
      'quantity': double.tryParse(price.toString()) ?? 0.00,
      'price': double.tryParse(price.toString()) ?? 0.00,
      'image': image,
      'nameEn': nameEn,
      'nameAr': nameAr,
      'category': category,
      'descriptionEn': descriptionEn,
      'descriptionAr': descriptionAr,
      'isPublished': isPublished,
      'isOnSale': isOnSale,
      'rating': rating.toMap(),
    };
  }

  Product.fromMap(Map<String, dynamic> map)
      : id = map['id'] ?? '',
        weight = map['weight'] ?? 0,
        price = double.tryParse(map['price'].toString()) ?? 0.00,
        image = map['image'] ?? '',
        nameEn = map['nameEn'] ?? '',
        nameAr = map['nameAr'] ?? '',
        category = map['category'] ?? '',
        descriptionEn = map['descriptionEn'] ?? '',
        descriptionAr = map['descriptionAr'] ?? '',
        isPublished = map['isPublished'] ?? true,
        isOnSale = map['isOnSale'] ?? false,
        rating =
            map['rating'] != null ? Rating.fromMap(map['rating']) : Rating();

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Product(price: $price, image: $image, nameEn: $nameEn, nameAr: $nameAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.price == price &&
        other.image == image &&
        other.weight == weight &&
        other.nameEn == nameEn &&
        other.nameAr == nameAr &&
        other.descriptionEn == descriptionEn &&
        other.descriptionAr == descriptionAr &&
        other.isPublished == isPublished &&
        other.isOnSale == isOnSale;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        weight.hashCode ^
        image.hashCode ^
        nameEn.hashCode ^
        nameAr.hashCode ^
        descriptionEn.hashCode ^
        descriptionAr.hashCode ^
        isPublished.hashCode ^
        isOnSale.hashCode;
  }
}
