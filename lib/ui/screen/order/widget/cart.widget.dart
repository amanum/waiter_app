import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/data/bloc/cart/cart_bloc.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CartBloc>();
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Стол ${state.cart.tableId}'),
                Text('Сумма ${state.cart.totalSum.toString()}'),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.cart.items.length,
                itemBuilder: (context, index) {
                  final item = state.cart.items[index];
                  return ListTile(
                    tileColor: Colors.black12,
                    title: Text(item.title),
                    subtitle: Text(item.sellingPrice.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () => bloc.add(CartAddItem(item)),
                          icon: const Icon(Icons.add),
                        ),
                        Text(item.quantity.toString()),
                        IconButton(
                          onPressed: () => bloc.add(CartDecrementItemQuantity(item)),
                          icon: const Icon(Icons.remove),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
