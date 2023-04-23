import 'package:ecommerceriverpod/src/constants/test_products.dart';
import 'package:ecommerceriverpod/src/features/products/domain/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as devtools show log;
import 'dart:convert'; // Add this import statement

class ProductsRepository {
  List<Product> products = [];

  Future<List<Product>> fetchProductsList() async {
    try {
      // print("start");
      final url = Uri.parse('http://192.168.1.9:5000/api/v1/products');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body)['result'];
        for (var productData in jsonData) {
          Product product = Product.fromJson(
              productData); // Replace with your own deserialization logic
          products.add(product);
        }
        return products;
      } else {
        throw Exception('Failed to fetch products');
      }
    } catch (e) {
      return [];
    }
  }

  Product? getSingleProduct(id) {
    //get single product with given id
    return _getProduct(products, id);
  }

  static Product? _getProduct(List<Product> products, String id) {
    try {
      return products.firstWhere((element) => element.itemsId == id);
    } catch (e) {
      devtools.log(e.toString());
      return null;
    }
  }
}

final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  // You can initialize your repository here if needed
  return ProductsRepository();
});

final productsListProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productsRepositoryProvider);
  return repository.fetchProductsList();
});
