part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {}

final class LoadCategories extends CatalogEvent {
  @override
  List<Object?> get props => [];
}

final class LoadCatalogItems extends CatalogEvent {
  final int categoryId;

  LoadCatalogItems(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
