import 'dart:convert';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/constants.dart';
import '../domain/app_user.dart';
import 'dart:developer' as devtools show log;

class AuthRepository {
  Stream<AppUser?> authStateChanges() =>
      Stream.value(null); // null means not authenticated
  AppUser? get currentUser => null; // get current user synchronously

  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final String token;
      final Map<String, dynamic> jsonData;

      devtools.log("message");
      devtools.log("signInWithEmailAndPassword AuthRepository");
      devtools.log("email");
      devtools.log("password");
      final url = Uri.parse('http://192.168.1.9:5000/api/v1/auth/login');
      final response = await http.post(url,
          body: jsonEncode({
            "email": email,
            "password": password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
      jsonData = jsonDecode(response.body);
      devtools.log(jsonData.toString());
      if (response.statusCode == 200) {
        token = jsonData['token'];
        devtools.log("200");
        final box = Hive.box(Constants.authStorageKey);

        await box.put('token', token);
        // await box.put('user', user.toJson());
        return token;
      } else {
        devtools.log("ERROR");
        token = "ERROR";
        return token;
      }
    } on Exception catch (e) {
      return e.toString();
    }
  }

  Future<String> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    devtools.log("start createUserWithEmailAndPassword");
    try {
      final url = Uri.parse('http://192.168.1.9:5000/api/v1/auth/CreateUser');
      final response = await http.post(url,
          body: jsonEncode({
            "name": name,
            "email": email,
            "password": password,
          }),
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            // 'Authorization': 'Bearer ${UserAccountData.token}',
          });
      if (response.statusCode == 200) {
        return "success";
        devtools.log(response.toString());
        devtools.log(response.statusCode.toString());
        devtools.log(response.body.toString());
      }
    } on Exception catch (e) {
      return "ERROR";
      print(e.toString());
    }
    return "ERROR";
  }

  Future<void> logout(String email, String password) async {}
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// final authStateChangesProvider = StreamProvider.autoDispose<AppUser?>((ref) {
//   // close provider when no longer needed
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.authStateChanges();
// });

// final createUserWithEmailAndPasswordProvider = FutureProvider((ref) {
//   // close provider when no longer needed
//   final authRepository = ref.watch(authRepositoryProvider);
//   return authRepository.createUserWithEmailAndPassword(
//       "nMAAAAAAAAAA", 'EEEEEEEMAIK', 'PASSSSSSWROD132');
// });

