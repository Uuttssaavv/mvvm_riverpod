import 'package:flutter_project/enums/product_state_enums.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/services/local_database_services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final itemViewmodelProvider =
    StateNotifierProvider<ItemViewmodel, ProductState>((_) => ItemViewmodel());

class ItemViewmodel extends StateNotifier<ProductState> {
  final DatabaseService _databaseService = DatabaseService.instance;
  ItemViewmodel() : super(ProductState());
  Future<void> createProduct(ProductModel product) async {
    state = state.copyWith(isLoading: true);
    final addedProduct = await _databaseService.create(product);
    final products = [...state.products];
    state = state.copyWith(
      isLoading: false,
      products: products..add(addedProduct),
    );
  }

  Future<void> queryAllProducts() async {
    state = state.copyWith(isLoading: true);
    final ProductList products = await _databaseService.getAllProducts();
    if (products.isEmpty) {
      state = state.copyWith(
        isLoading: false,
        product: Product.dataEmpty,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        products: products,
      );
    }
  }

  Future<void> updateProduct(ProductModel product) async {
    state = state.copyWith(isLoading: true);
    await _databaseService.update(product);
    final products = [...state.products];
    int index = products.indexWhere((e) => e.id == product.id);
    products[index] = product;

    state = state.copyWith(
      isLoading: false,
      products: products,
    );
  }

  Future<void> delete(ProductModel product) async {
    final products = state.products..remove(product);

    state = state.copyWith(isLoading: true);
    await _databaseService.delete(product.id!);
    state = state.copyWith(
      isLoading: false,
      products: products,
    );
  }
}

class ProductState {
  final bool isLoading;
  final String? errorMessage;
  final ProductList products;
  final Product product;
  ProductState({
    this.isLoading = false,
    this.errorMessage,
    this.product = Product.idle,
    this.products = const [],
  });
  ProductState copyWith({
    bool? isLoading,
    String? errorMessage,
    Product? product,
    ProductList products = const [],
  }) =>
      ProductState(
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage ?? this.errorMessage,
        product: product ?? this.product,
        products: products.isNotEmpty ? products : this.products,
      );
}
