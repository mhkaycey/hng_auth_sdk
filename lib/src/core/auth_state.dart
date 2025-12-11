import 'package:flutter_riverpod/legacy.dart';
import 'package:hng_auth_sdk/src/core/auth_config.dart';
import 'package:hng_auth_sdk/src/models/auth_user.dart';

class AuthStateData {
  final AuthState state;
  final AuthUser? user;
  final String? errorMessage;

  const AuthStateData({required this.state, this.user, this.errorMessage});

  AuthStateData copyWith({
    AuthState? state,
    AuthUser? user,
    String? errorMessage,
  }) {
    return AuthStateData(
      state: state ?? this.state,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthStateNotifier extends StateNotifier {
  AuthStateNotifier()
    : super(const AuthStateData(state: AuthState.unauthenticated));

  void setAuthenticated(AuthUser user) {
    state = AuthStateData(state: AuthState.authenticated, user: user);
  }

  void setUnauthenticated() {
    state = const AuthStateData(state: AuthState.unauthenticated);
  }

  void setTokenExpired(AuthUser? user) {
    state = AuthStateData(state: AuthState.tokenExpired, user: user);
  }

  void setError(String message) {
    state = state.copyWith(errorMessage: message);
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final authStateProvider = StateNotifierProvider((ref) => AuthStateNotifier());
