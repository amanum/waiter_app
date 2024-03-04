import 'package:decimal/decimal.dart';
import 'package:waiter_app/data/entity/catalog_item.entity.dart';

class CartItem {
  final CatalogItem catalogItem;
  final int quantity;
  final Decimal? _sellingPrice;

  int get id => catalogItem.id;

  String get title => catalogItem.title;

  Decimal get sellingPrice => _sellingPrice ?? catalogItem.price;

  Decimal get calculatedPrice => sellingPrice * Decimal.fromInt(quantity);

  CartItem({
    required this.catalogItem,
    this.quantity = 1,
    Decimal? sellingPrice,
    String? key,
  }) : _sellingPrice = sellingPrice;

  CartItem copyWith({
    CatalogItem? catalogItem,
    int? quantity,
    Decimal? sellingPrice,
  }) {
    return CartItem(
      catalogItem: catalogItem ?? this.catalogItem,
      quantity: quantity ?? this.quantity,
      sellingPrice: sellingPrice ?? this.sellingPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'catalog_item': catalogItem.toJson(),
      'quantity': quantity,
      'selling_price': sellingPrice,
    };
  }

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      catalogItem: CatalogItem.fromJson(json['catalog_item']),
      quantity: json['quantity'] as int,
      sellingPrice: Decimal.parse(json['selling_price']),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is CartItem && runtimeType == other.runtimeType && catalogItem == other.catalogItem;

  @override
  int get hashCode => catalogItem.hashCode;

  @override
  String toString() {
    return 'CartItem{ catalogItem: ${catalogItem.toString()}, quantity: $quantity, sellingPrice: $_sellingPrice, }';
  }
}
