part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {}

final class CartReadFromDatabase extends CartEvent {
  final int? tableId;

  CartReadFromDatabase({this.tableId});

  @override
  List<Object?> get props => [tableId];
}

final class CartAddItem extends CartEvent {
  final CartItem item;

  CartAddItem(this.item);

  @override
  List<Object?> get props => [item];
}

final class CartDecrementItemQuantity extends CartEvent {
  final CartItem item;

  CartDecrementItemQuantity(this.item);

  @override
  List<Object?> get props => [item];
}

final class CartRemoveItem extends CartEvent {
  final CartItem item;

  CartRemoveItem(this.item);

  @override
  List<Object?> get props => [item];
}
