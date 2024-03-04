import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waiter_app/data/database/cart.database.dart';
import 'package:waiter_app/data/entity/cart.entity.dart';
import 'package:waiter_app/data/entity/cart_item.entity.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartDatabase _cartDatabase;

  CartBloc({
    required CartDatabase cartDatabase,
    required CartState initState,
  })  : _cartDatabase = cartDatabase,
        super(initState) {
    on<CartReadFromDatabase>(_onReadFromDatabase);
    on<CartAddItem>(_onAddItem);
    on<CartDecrementItemQuantity>(_onDecrementItem);
    on<CartRemoveItem>(_onRemoveItem);
  }
  
  Future<void> _onReadFromDatabase(CartReadFromDatabase event, emit) async {
    final cart = await _cartDatabase.getCart(tableId: event.tableId);
    if (cart == null) return;
    emit(CartState(cart: cart));
  }

  Future<void> _onAddItem(CartAddItem event, emit) async {
    final cart = state.cart;
    final items = [...cart.items];

    for (int i = 0; i < items.length; i++) {
      CartItem item = items[i];
      if (item.id == event.item.id) {
        item = item.copyWith(quantity: item.quantity + 1);
        items[i] = item;

        final newCart = cart.copyWith(items: items);

        await _cartDatabase.writeCart(newCart);

        emit(
          CartState(
            status: ECartStateStatus.loaded,
            cart: newCart,
          ),
        );
        return;
      }
    }

    final newCart = cart.copyWith(items: [...items, event.item]);
    await _cartDatabase.writeCart(newCart);

    emit(
      CartState(
        status: ECartStateStatus.loaded,
        cart: newCart,
      ),
    );
  }

  Future<void> _onDecrementItem(CartDecrementItemQuantity event, emit) async {
    final cart = state.cart;
    final items = [...cart.items];
    final cartItem = event.item;

    if (cartItem.quantity > 1) {
      final index = items.indexOf(cartItem);
      final newCartItem = cartItem.copyWith(quantity: cartItem.quantity - 1);
      items[index] = newCartItem;

      final newCart = cart.copyWith(items: items);

      await _cartDatabase.writeCart(newCart);

      emit(CartState(status: ECartStateStatus.loaded, cart: newCart));
    } else {
      add(CartRemoveItem(event.item));
    }
  }

  Future<void> _onRemoveItem(CartRemoveItem event, emit) async {
    final cart = state.cart;
    final items = [...cart.items];
    items.remove(event.item);

    final newCart = cart.copyWith(items: items);

    await _cartDatabase.writeCart(newCart);

    emit(
      CartState(
        status: ECartStateStatus.loaded,
        cart: newCart,
      ),
    );
  }
}
