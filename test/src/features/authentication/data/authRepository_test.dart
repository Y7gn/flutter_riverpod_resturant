import 'package:ecommerceriverpod/src/features/authentication/data/authRepository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('authRepository ...', (tester) async {
    final authRepository = AuthRepository();
    expect(
        authRepository.createUserWithEmailAndPassword(
            "dsadas", 'dsadasd', 'dsadsad'),
        []);
  });
}
