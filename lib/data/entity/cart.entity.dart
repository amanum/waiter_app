import 'dart:convert';

import 'package:decimal/decimal.dart';
import 'package:uuid/uuid.dart';
import 'package:waiter_app/data/entity/cart_item.entity.dart';

class Cart {
  final _uuid = const Uuid();

  late final String key;

  final int tableId;
  final List<CartItem> items;

  Decimal get totalSum => items.fold(
        Decimal.zero,
        (previousValue, element) => previousValue + element.calculatedPrice,
      );

  Cart({
    required this.tableId,
    this.items = const [],
    String? key,
  }) {
    this.key = key ?? _uuid.v4();
  }

  Cart copyWith({
    String? key,
    int? tableId,
    List<CartItem>? items,
  }) {
    return Cart(
      key: key ?? this.key,
      tableId: tableId ?? this.tableId,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'table_id': tableId,
      'items': jsonEncode(items.map((e) => e.toJson()).toList()),
    };
  }

  factory Cart.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> items = List.from(jsonDecode(json['items']) as List);
    return Cart(
      key: json['key'] as String,
      tableId: json['table_id'] as int,
      items: items.map((e) => CartItem.fromJson(e)).toList(),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cart &&
          runtimeType == other.runtimeType &&
          key == other.key &&
          tableId == other.tableId &&
          items == other.items);

  @override
  int get hashCode => key.hashCode ^ tableId.hashCode ^ items.hashCode;

  @override
  String toString() {
    return 'Cart{ key: $key, tableNumber: $tableId, items: $items,}';
  }
}
