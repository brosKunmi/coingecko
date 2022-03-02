import 'dart:convert';

class GeckoCoin {
  String id;
  String name;
  String image;
  double price;
  int marketRank;
  GeckoCoin({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.marketRank,
  });

  GeckoCoin copyWith({
    String? id,
    String? name,
    String? image,
    double? price,
    int? marketRank,
  }) {
    return GeckoCoin(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      marketRank: marketRank ?? this.marketRank,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'current_price': price,
      'market_cap_rank': marketRank,
    };
  }

  factory GeckoCoin.fromMap(Map<String, dynamic> map) {
    return GeckoCoin(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      image: map['image'] ?? '',
      price: map['current_price']?.toDouble() ?? 0.0,
      marketRank: map['market_cap_rank']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory GeckoCoin.fromJson(String source) =>
      GeckoCoin.fromMap(json.decode(source));

  @override
  String toString() {
    return 'GeckoCoin(id: $id, name: $name, image: $image, price: $price, marketRank: $marketRank)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeckoCoin &&
        other.id == id &&
        other.name == name &&
        other.image == image &&
        other.price == price &&
        other.marketRank == marketRank;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        price.hashCode ^
        marketRank.hashCode;
  }
}
