import 'package:flutter/material.dart';
import 'package:flutter_project/features/crud_item/item_viewmodel.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/widgets/product_form.dart';
import 'package:flutter_project/widgets/text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ItemView extends ConsumerStatefulWidget {
  const ItemView({Key? key}) : super(key: key);

  @override
  ItemViewState createState() => ItemViewState();
}

class ItemViewState extends ConsumerState {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      ref.read(itemViewmodelProvider.notifier).queryAllProducts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(itemViewmodelProvider);
    return Stack(
      children: [
        if (state.products.isEmpty)
          const Center(
            child: text(
              'No products found',
            ),
          )
        else
          ListView.separated(
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return Dismissible(
                background: Container(color: Colors.red),
                key: Key('${product.id}'),
                direction: DismissDirection.endToStart,
                onDismissed: (_) async {
                  await ref
                      .watch(itemViewmodelProvider.notifier)
                      .delete(state.products[index]);
                },
                child: ListTile(
                  leading: CircleAvatar(
                    child: text(state.products[index].id!.toInt()),
                  ),
                  title: text(product.title),
                  subtitle: text(product.description),
                  onTap: () {
                    showProductForm(product: product);
                  },
                ),
              );
            },
            itemCount: state.products.length,
            shrinkWrap: true,
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                showProductForm();
              },
              child: const Icon(Icons.add),
            ),
          ),
        ),
      ],
    );
  }

  void showProductForm({ProductModel? product}) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        insetPadding: EdgeInsets.zero,
        content: ProductForm(
          productModel: product,
          onSubmitted: (title, description, isUpdate) async {
            final createdProduct = ProductModel(
              id: product?.id,
              title: title,
              description: description,
              dateAdded: DateTime.now(),
            );
            if (isUpdate) {
              await ref
                  .watch(itemViewmodelProvider.notifier)
                  .updateProduct(createdProduct);
            } else {
              await ref
                  .watch(itemViewmodelProvider.notifier)
                  .createProduct(createdProduct);
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
