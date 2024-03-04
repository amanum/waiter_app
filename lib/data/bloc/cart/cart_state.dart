part of 'cart_bloc.dart';

enum ECartStateStatus { loading, loaded }

final class CartState extends Equatable {
  final ECartStateStatus status;
  final Cart cart;

  const CartState({
    required this.cart,
    this.status = ECartStateStatus.loaded,
  });

  @override
  List<Object?> get props => [cart];
}
