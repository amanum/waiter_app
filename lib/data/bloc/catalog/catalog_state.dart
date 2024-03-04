part of 'catalog_bloc.dart';

enum ECatalogStatus { loading, loaded }

abstract class CatalogState extends Equatable {
  final ECatalogStatus status;

  const CatalogState({required this.status});
}

class CatalogCategories extends CatalogState {
  final List<CatalogCategory> categories;

  const CatalogCategories({
    required super.status,
    this.categories = const [],
  });

  @override
  List<Object> get props => [categories];
}

class CatalogItems extends CatalogState {
  final List<CatalogItem> items;

  const CatalogItems({
    required super.status,
    this.items = const [],
  });

  @override
  List<Object> get props => [items];
}
