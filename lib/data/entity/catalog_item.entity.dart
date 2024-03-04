import 'package:decimal/decimal.dart';

class CatalogItem {
  final int id;
  final String title;
  final Decimal price;
  final int categoryId;

  const CatalogItem({
    required this.id,
    required this.title,
    required this.price,
    required this.categoryId,
  });

  CatalogItem copyWith({
    int? id,
    String? title,
    Decimal? price,
    int? categoryId,
  }) {
    return CatalogItem(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price.toString(),
      'category_id': categoryId,
    };
  }

  factory CatalogItem.fromJson(Map<String, dynamic> json) {
    return CatalogItem(
      id: json['id'] as int,
      title: json['title'] as String,
      price: Decimal.parse(json['price']),
      categoryId: json['category_id'],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CatalogItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          price == other.price &&
          categoryId == other.categoryId);

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ price.hashCode;

  @override
  String toString() {
    return 'CatalogItem{ id: $id, title: $title, price: $price, }';
  }
}
