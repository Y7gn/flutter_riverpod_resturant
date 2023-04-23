import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:developer' as devtools show log;

import '../../domain/product.dart';

class ProductCard extends ConsumerWidget {
  const ProductCard({
    super.key,
    required this.product,
  });
  final Product product;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    devtools.log(product.toString());
    return Card(
      child: InkWell(
        // key: ,
        // onTap: ,

        child: Column(
          children: [
            // CustomImage(imageurl:product.imageUrl),
            const Divider(),
            Text("${product.itemsName}"),
            Image(
              height: 140,
              image: NetworkImage("${product.itemsImage}"),
            )
            // Text("${product.itemsPrice}"),
            // Text(
            //   product.availableQuantity <= 0
            //       ? 'Out of Stock'
            //       : 'Quantity ${product.availableQuantity}',
            // )
          ],
        ),
      ),
    );
  }
}
