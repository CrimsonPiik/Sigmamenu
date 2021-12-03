import 'dart:convert';

import 'package:sigmamenu/GeneralFunction/random_id_generator.dart';

class AppUser {
  String id = generateId();
  String uid = 'warning';
  String role = 'user';
  String phone = 'phone';
  String name = 'name';
  String email = 'email';
  String image = 'assets/images/user.png';
  String orderId = 'orderId';
  bool isBlocked = false;
  List<String> favorites = [];
  List<String> fcmToken = [];
  // Address address = Address();

  AppUser();

  Map<String, dynamic> toMap() {
    return {
      'id': id.toString(),
      'uid': uid.toString(),
      'role': role.toString(),
      'phone': phone.toString(),
      'name': name.toString(),
      'image': image.toString(),
      'email': email.toString(),
      // 'address': address.toMap(),
      'fcmToken': fcmToken,
      'favorites': favorites,
      'isBlocked': isBlocked.toString() == 'true' ? true : false,
      'orderId': orderId.toString(),
    };
  }

  AppUser.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        uid = map['uid'] ?? 'warning',
        email = map['email'] ?? 'email',
        phone = map['phone'] ?? 'phone',
        name = map['name'] ?? 'name',
        image = map['image'] ?? 'image',
        isBlocked = map['isBlocked'].toString() == 'true' ? true : false,
        fcmToken = map['fcmToken'] != null
            ? map['fcmToken'] is String
                ? [map['fcmToken']]
                : List<String>.from(map['fcmToken'])
            : [],
        favorites = map['favorites'] != null
            ? map['favorites'] is String
                ? [map['favorites']]
                : List<String>.from(map['favorites'])
            : [],
        role = map['role'] ?? 'role',
        // address = map['address'] != null
        //     ? Address.fromMap(map['address'])
        //     : Address(),
        orderId = map['orderId'];

  String toJson() => json.encode(toMap());

  factory AppUser.fromJson(String source) =>
      AppUser.fromMap(json.decode(source));

  @override
  String toString() => 'Name: $name orderId: $orderId';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppUser &&
        other.id == id &&
        other.uid == uid &&
        other.role == role &&
        other.phone == phone &&
        other.name == name &&
        other.email == email &&
        other.image == image &&
        other.isBlocked == isBlocked &&
        other.orderId == orderId &&
        other.fcmToken == fcmToken &&
        other.favorites == favorites;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        uid.hashCode ^
        role.hashCode ^
        phone.hashCode ^
        name.hashCode ^
        email.hashCode ^
        image.hashCode ^
        isBlocked.hashCode ^
        favorites.hashCode ^
        orderId.hashCode ^
        fcmToken.hashCode;
  }
}
