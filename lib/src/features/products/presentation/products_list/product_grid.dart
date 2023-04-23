import 'package:ecommerceriverpod/src/features/products/presentation/products_list/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../authentication/data/authRepository.dart';
import '../../data/fake_products_repository.dart';
import 'dart:developer' as devtools show log;

class ProductsGrid extends ConsumerWidget {
  const ProductsGrid({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsListValue = ref.watch(productsListProvider);
    // final userValue = ref
    //     .read(authRepositoryProvider)
    //     .createUserWithEmailAndPassword("asdasdasdasd111111111",
    //         "dasdasdasdasd22222222", "dsadasdasda333333");
    // final userValue = ref
    //     .read(authRepositoryProvider)
    //     .signInWithEmailAndPassword(
    //         "dasdasdasdasd22222222", "dsadasdasda333333");

    // devtools.log(userValue.toString());
    return productsListValue.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error $err'),
      data: (products) => ProductsLayoutGrid(
        itemCount: products.length,
        itemBuilder: (_, index) {
          final product = products[index];
          return ProductCard(
            product: product,
          );
        },
      ),
    );
  }
}

class ProductsLayoutGrid extends StatelessWidget {
  const ProductsLayoutGrid(
      {super.key, required this.itemCount, required this.itemBuilder});
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        for (var i = 0; i < itemCount; i++) itemBuilder(context, i),
      ],
    );
  }
}
