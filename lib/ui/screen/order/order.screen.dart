import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/data/bloc/cart/cart_bloc.dart';
import 'package:waiter_app/data/bloc/catalog/catalog_bloc.dart';
import 'package:waiter_app/data/database/cart.database.dart';
import 'package:waiter_app/data/entity/cart.entity.dart';
import 'package:waiter_app/data/repository/catalog.repository.dart';
import 'package:waiter_app/ui/screen/order/widget/cart.widget.dart';
import 'package:waiter_app/ui/screen/order/widget/catalog.widget.dart';

class OrderScreen extends StatelessWidget {
  final int tableId;

  const OrderScreen(this.tableId, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => CartBloc(
            cartDatabase: context.read<CartDatabase>(),
            initState: CartState(
              status: ECartStateStatus.loading,
              cart: Cart(tableId: tableId),
            ),
          )..add(CartReadFromDatabase(tableId: tableId)),
        ),
        BlocProvider(
          create: (_) => CatalogBloc(
            initState: const CatalogCategories(
              status: ECatalogStatus.loading,
            ),
            catalogRepository: context.read<CatalogRepository>(),
          )..add(LoadCategories()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Режим продаж'),
        ),
        body: const Column(
          children: [
            Expanded(
              child: CartWidget(),
            ),
            Expanded(
              child: CatalogWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
