import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/authRepository.dart';
import '../../domain/enum AuthState { loading, authenticated, notAuthenticated.dart';
import 'dart:developer' as devtools show log;

class EmailPasswordSignInController
    extends StateNotifier<AsyncValue<AuthState>> {
  EmailPasswordSignInController({required this.authRepository})
      : super(const AsyncValue.data(AuthState.notAuthenticated));
  final AuthRepository authRepository;

  Future<bool> submit(String email, String password) async {
    try {
      state = AsyncValue.loading();
      devtools.log("start EmailPasswordSignInController");
      final token =
          await authRepository.signInWithEmailAndPassword(email, password);
      devtools.log("finished EmailPasswordSignInController");
      devtools.log(token);
      if (token == "ERROR") {
        state = AsyncValue.data(AuthState.notAuthenticated);
        return false;
      }
      state = AsyncValue.data(AuthState.authenticated);
      return true;
    } catch (e, st) {
      state = AsyncValue.data(AuthState.notAuthenticated);
      return false;
    }
  }

  Future<bool> submitRegister(
      String username, String email, String password) async {
    try {
      // state = AsyncValue.loading();
      devtools.log("start EmailPasswordSignInController");
      final result = await authRepository.createUserWithEmailAndPassword(
          username, email, password);
      // devtools.log("finished EmailPasswordSignInController");
      // devtools.log(token);
      if (result == "ERROR") {
        // state = AsyncValue.data(AuthState.notAuthenticated);
        // return false;
      }
      // state = AsyncValue.data(AuthState.authenticated);
      return true;
    } catch (e, st) {
      // state = AsyncValue.data(AuthState.notAuthenticated);
      return false;
    }
  }
}

final emailPasswordSignInControllerProvider =
    StateNotifierProvider<EmailPasswordSignInController, AsyncValue>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return EmailPasswordSignInController(authRepository: authRepository);
});
