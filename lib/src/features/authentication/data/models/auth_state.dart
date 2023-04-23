// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ecommerceriverpod/src/features/authentication/domain/enum%20AuthState%20%7B%20loading,%20authenticated,%20notAuthenticated.dart';

import '../../domain/app_user.dart';

class AuthStates {
  final String? accessToken;
  final AppUser? user;
  final AuthState status;
  final String? errorMessage;
  final bool loading;

  bool get hasError => errorMessage != null && errorMessage!.isNotEmpty;

  AuthStates({
    this.accessToken,
    this.user,
    this.status = AuthState.notAuthenticated,
    this.errorMessage,
    this.loading = false,
  });

  AuthStates copyWith({
    String? accessToken,
    AppUser? user,
    AuthState? status,
    String? errorMessage,
    bool? loading,
  }) {
    return AuthStates(
      accessToken: accessToken ?? this.accessToken,
      user: user ?? this.user,
      status: status ?? this.status,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory AuthStates.initial() {
    return AuthStates(
      status: AuthState.notAuthenticated,
      user: null,
      accessToken: null,
      errorMessage: null,
      loading: false,
    );
  }

  @override
  String toString() =>
      'status $status accessToken $accessToken user ${user.toString()} ';
}
