import 'package:ecommerceriverpod/src/constants/test_products.dart';
import 'package:ecommerceriverpod/src/features/products/data/fake_products_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('fake products repository ...', () {
    final productsRepository = ProductsRepository();
    expect(productsRepository.fetchProductsList(), kTestProducts);
  });
}
