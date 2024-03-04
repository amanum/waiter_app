import 'package:decimal/decimal.dart';
import 'package:waiter_app/data/entity/catalog_category.entity.dart';
import 'package:waiter_app/data/entity/catalog_item.entity.dart';

List<CatalogCategory> categories = [
  CatalogCategory(1, '1 блюда'),
  CatalogCategory(2, 'Напитки'),
];

List<CatalogItem> catalogItems = [
  CatalogItem(id: 1, title: 'Плов', price: Decimal.fromInt(1200), categoryId: 1,),
  CatalogItem(id: 2, title: 'Пельмени', price: Decimal.fromInt(1000), categoryId: 1,),
  CatalogItem(id: 3, title: 'Coca cola', price: Decimal.fromInt(800), categoryId: 2,),
  CatalogItem(id: 4, title: 'Sprite', price: Decimal.fromInt(850), categoryId: 2,),
];

class CatalogRepository {
  List<CatalogCategory> getCategories() {
    return categories;
  }

  List<CatalogItem> getCatalogItems({required int categoryId}) {
    return catalogItems.where((element) => element.categoryId == categoryId).toList();
  }
}