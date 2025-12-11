import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'auth_provider_base.dart';

class AppleAuthProvider implements AuthProviderBase {
  final FirebaseAuth _firebaseAuth;

  AppleAuthProvider(this._firebaseAuth);

  @override
  Future signIn([String? email, String? password]) async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oauthCredential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(
      oauthCredential,
    );
    return userCredential.user!;
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
