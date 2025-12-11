import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' hide GoogleAuthProvider;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_auth_sdk/src/core/auth_config.dart';
import 'package:hng_auth_sdk/src/core/auth_state.dart';
import 'package:hng_auth_sdk/src/exceptions/auth_exceptions.dart';
import 'package:hng_auth_sdk/src/exceptions/error_mapper.dart';
import 'package:hng_auth_sdk/src/models/auth_user.dart';
import 'package:hng_auth_sdk/src/providers/email_password_provider.dart';
import 'package:hng_auth_sdk/src/providers/google_auth_provider.dart' as custom;
import 'package:hng_auth_sdk/src/providers/apple_auth_provider.dart' as apple;

class AuthService {
  final FirebaseAuth _firebaseAuth;
  final Ref _ref;
  final AuthConfig config;

  late final Map _providers;

  AuthService({
    required this.config,
    required Ref ref,
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       _ref = ref {
    _initializeProviders();
    _listenToAuthChanges();
  }

  void _initializeProviders() {
    _providers = {
      AuthProviderType.emailPassword: EmailPasswordProvider(_firebaseAuth),
      AuthProviderType.google: custom.GoogleSignInProvider(
        firebaseAuth: _firebaseAuth,
      ),
      AuthProviderType.apple: apple.AppleAuthProvider(_firebaseAuth),
    };
  }

  void _listenToAuthChanges() {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user != null) {
        _ref
            .read(authStateProvider.notifier)
            .setAuthenticated(AuthUser.fromFirebaseUser(user));
      } else {
        _ref.read(authStateProvider.notifier).setUnauthenticated();
      }
    });

    // Token expiration check
    if (config.autoRefreshToken) {
      _firebaseAuth.idTokenChanges().listen((User? user) async {
        if (user != null) {
          try {
            final tokenResult = await user.getIdTokenResult();
            final expirationTime = tokenResult.expirationTime;

            if (expirationTime != null) {
              final timeUntilExpiry = expirationTime.difference(DateTime.now());

              if (timeUntilExpiry < config.tokenRefreshThreshold) {
                _ref
                    .read(authStateProvider.notifier)
                    .setTokenExpired(AuthUser.fromFirebaseUser(user));
              }
            }
          } catch (e) {
            // Handle token refresh error
          }
        }
      });
    }
  }

  // Email/Password Authentication
  Future signInWithEmailPassword(String email, String password) async {
    try {
      final provider =
          _providers[AuthProviderType.emailPassword] as EmailPasswordProvider;
      final user = await provider.signIn(email, password);
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.mapFirebaseException(e);
    } catch (e) {
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }

  Future signUpWithEmailPassword(String email, String password) async {
    try {
      final provider =
          _providers[AuthProviderType.emailPassword] as EmailPasswordProvider;
      final user = await provider.signUp(email, password);
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.mapFirebaseException(e);
    } catch (e) {
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }

  Future signInWithGoogle() async {
    log('🔵 Starting Google Sign-In...');
    try {
      final provider =
          _providers[AuthProviderType.google] as custom.GoogleSignInProvider;
      log('🔵 Provider obtained');
      final user = await provider.signIn();
      log('🔵 Sign-in successful: ${user.email}');
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      log('🔴 Firebase error: ${e.code} - ${e.message}');
      throw ErrorMapper.mapFirebaseException(e);
    } on AuthException catch (e) {
      log('🔴 Auth exception: ${e.message}');
      rethrow;
    } catch (e, stackTrace) {
      log('🔴 Unexpected error: $e');
      log('Stack trace: $stackTrace');
      if (e.toString().contains('sign_in_canceled')) {
        throw AuthCancelledException();
      }
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }

  // Apple Authentication
  Future signInWithApple() async {
    try {
      final provider =
          _providers[AuthProviderType.apple] as apple.AppleAuthProvider;
      final user = await provider.signIn();
      return AuthUser.fromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.mapFirebaseException(e);
    } catch (e) {
      if (e.toString().contains('canceled')) {
        throw AuthCancelledException();
      }
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();

      if (config.providers.google) {
        await (_providers[AuthProviderType.google]
                as custom.GoogleSignInProvider)
            .signOut();
      }

      if (config.providers.apple) {
        await (_providers[AuthProviderType.apple] as apple.AppleAuthProvider)
            .signOut();
      }
    } catch (e) {
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }

  // Password Reset
  Future sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw ErrorMapper.mapFirebaseException(e);
    }
  }

  // Get current user
  AuthUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    return user != null ? AuthUser.fromFirebaseUser(user) : null;
  }

  // Refresh token
  Future refreshToken() async {
    try {
      await _firebaseAuth.currentUser?.getIdToken(true);
    } catch (e) {
      throw ErrorMapper.mapGeneralException(e as Exception);
    }
  }
}

final authServiceProvider = Provider((ref) {
  throw UnimplementedError('AuthService must be initialized with config');
});
