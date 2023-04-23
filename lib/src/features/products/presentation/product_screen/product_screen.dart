import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});
  final productId;
  // ProductID
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product Screen"),
      ),
      body: Consumer(builder: ((context, ref, child) {
        // final productValue = ref.watch(productProvider(productId));
        // return productValue.when(

        // );
        return Text("product screen");
      })),
    );
  }
}
