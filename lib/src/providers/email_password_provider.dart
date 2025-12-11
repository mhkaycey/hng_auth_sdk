import 'package:firebase_auth/firebase_auth.dart';
import 'package:hng_auth_sdk/src/providers/auth_provider_base.dart';

class EmailPasswordProvider implements AuthProviderBase {
  final FirebaseAuth _firebaseAuth;

  EmailPasswordProvider(this._firebaseAuth);

  @override
  Future signIn([String? email, String? password]) async {
    if (email == null || password == null) {
      throw ArgumentError(
        'Email and password are required for email authentication',
      );
    }
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  Future signUp(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user!;
  }

  @override
  Future signOut() async {
    await _firebaseAuth.signOut();
  }

  // @override
  // Future googleSignIn() {
  //   // TODO: implement googleSignIn
  //   throw UnimplementedError();
  // }
}
