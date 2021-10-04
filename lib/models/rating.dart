import 'dart:convert';

class Rating {
  int one = 0;
  int two = 0;
  int three = 0;
  int four = 0;
  int five = 0;
  int ratingCount = 0;
  double average = 0;
  int reviewCount = 0;
  Rating();

  Map<String, dynamic> toMap() {
    return {
      'one': one,
      'two': two,
      'three': three,
      'four': four,
      'five': five,
      'ratingCount': ratingCount,
      'reviewCount': reviewCount,
      'average': average,
    };
  }

  Rating.fromMap(Map<String, dynamic> map)
      : one = int.tryParse(map['one'].toString()) ?? 0,
        two = int.tryParse(map['two'].toString()) ?? 0,
        three = int.tryParse(map['three'].toString()) ?? 0,
        four = int.tryParse(map['four'].toString()) ?? 0,
        five = int.tryParse(map['five'].toString()) ?? 0,
        ratingCount = int.tryParse(map['ratingCount'].toString()) ?? 0,
        reviewCount = int.tryParse(map['reviewCount'].toString()) ?? 0,
        average = double.tryParse(map['average'].toString()) ?? 0.0;

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) => Rating.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Rating(one: $one, two: $two, three: $three, four: $four, five: $five, average: $average)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Rating &&
        other.one == one &&
        other.two == two &&
        other.three == three &&
        other.four == four &&
        other.five == five &&
        other.ratingCount == ratingCount &&
        other.average == average &&
        other.reviewCount == reviewCount;
  }

  @override
  int get hashCode {
    return one.hashCode ^
        two.hashCode ^
        three.hashCode ^
        four.hashCode ^
        five.hashCode ^
        ratingCount.hashCode ^
        average.hashCode ^
        reviewCount.hashCode;
  }
}
