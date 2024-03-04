import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waiter_app/data/bloc/cart/cart_bloc.dart';
import 'package:waiter_app/data/bloc/catalog/catalog_bloc.dart';
import 'package:waiter_app/data/entity/cart_item.entity.dart';
import 'package:waiter_app/data/entity/catalog_category.entity.dart';
import 'package:waiter_app/data/entity/catalog_item.entity.dart';

class CatalogWidget extends StatelessWidget {
  const CatalogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatalogBloc, CatalogState>(
      builder: (context, state) {
        if (state.status == ECatalogStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          switch (state) {
            case CatalogCategories():
              return GridView.count(
                childAspectRatio: 3 / 2,
                crossAxisCount: 2,
                children: state.categories.map((e) => CategoryWidget(e)).toList(),
              );
            case CatalogItems():
              final bloc = context.read<CatalogBloc>();
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: ElevatedButton(
                      onPressed: () => bloc.add(LoadCategories()),
                      child: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  Expanded(
                    child: GridView.count(
                      childAspectRatio: 3 / 2,
                      crossAxisCount: 2,
                      children: state.items.map((e) => CatalogItemWidget(e)).toList(),
                    ),
                  ),
                ],
              );
          }
          return const SizedBox.shrink();
        }
      },
    );
  }
}

class CategoryWidget extends StatelessWidget {
  final CatalogCategory category;

  const CategoryWidget(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CatalogBloc>();
    return ElevatedButton(
      onPressed: () => bloc.add(LoadCatalogItems(category.id)),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
      child: Text(
        category.title,
        style: const TextStyle(fontSize: 20),
      ),
    );
  }
}

class CatalogItemWidget extends StatelessWidget {
  final CatalogItem item;

  const CatalogItemWidget(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    final cartBloc = context.read<CartBloc>();
    return ElevatedButton(
      onPressed: () => cartBloc.add(CartAddItem(CartItem(catalogItem: item))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            item.price.toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(item.title),
        ],
      ),
    );
  }
}
