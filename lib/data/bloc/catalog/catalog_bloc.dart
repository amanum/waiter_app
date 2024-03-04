import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waiter_app/data/entity/catalog_category.entity.dart';
import 'package:waiter_app/data/entity/catalog_item.entity.dart';
import 'package:waiter_app/data/repository/catalog.repository.dart';

part 'catalog_event.dart';

part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  final CatalogRepository _catalogRepository;

  CatalogBloc({
    required CatalogState initState,
    required CatalogRepository catalogRepository,
  })  : _catalogRepository = catalogRepository,
        super(initState) {
    on<LoadCategories>(_onLoadCategories);
    on<LoadCatalogItems>(_onLoadCatalogItems);
  }

  Future<void> _onLoadCategories(LoadCategories event, emit) async {
    final categories = _catalogRepository.getCategories();
    emit(CatalogCategories(status: ECatalogStatus.loaded, categories: categories));
  }

  Future<void> _onLoadCatalogItems(LoadCatalogItems event, emit) async {
    emit(const CatalogItems(status: ECatalogStatus.loading));
    final catalogItems = _catalogRepository.getCatalogItems(categoryId: event.categoryId);
    emit(CatalogItems(status: ECatalogStatus.loaded, items: catalogItems));
  }
}
