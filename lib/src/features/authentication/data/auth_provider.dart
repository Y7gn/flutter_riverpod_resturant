import 'package:ecommerceriverpod/src/features/authentication/domain/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../../utils/constants.dart';
import '../domain/enum AuthState { loading, authenticated, notAuthenticated.dart';
import 'authRepository.dart';
import 'models/auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthStates> {
  final AuthRepository _repo;

  AuthStateNotifier(this._repo, [AuthStates? state])
      : super(state ?? AuthStates.initial()) {
    checkAuthStatus();
  }

  Future<void> changeAuthStatus(bool loginStatus) async {
    if (loginStatus == true) {
      state = state.copyWith(
        status: AuthState.authenticated,
      );
    }
    if (loginStatus == false) {
      state = state.copyWith(
        status: AuthState.notAuthenticated,
      );
    }
  }

  Future<void> checkAuthStatus() async {
    // check storage for existing token/user
    print("checkAuthStatus token");
    final box = Hive.box(Constants.authStorageKey);

    final token = box.get('token');
    // final user = box.get('user');
    print(token);

    // if authenticated, update state accordingly
    if (token != null && token.toString().isNotEmpty) {
      state = state.copyWith(
        status: AuthState.authenticated,
        // user: AppUser.fromJson(user.toString()),
        accessToken: token.toString(),
      );

      return;
    }
    state = state.copyWith(
      status: AuthState.notAuthenticated,
    );
  }
}

final authNotifierProvider =
    StateNotifierProvider<AuthStateNotifier, AuthStates>((ref) {
  final repo = ref.watch(authRepositoryProvider);
  return AuthStateNotifier(repo);
});
