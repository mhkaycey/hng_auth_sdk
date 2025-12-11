import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_provider_base.dart';

class GoogleSignInProvider implements AuthProviderBase {
  final FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;

  GoogleSignInProvider({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _googleSignIn = googleSignIn ?? GoogleSignIn.instance;
  }

  @override
  Future<User> signIn() async {
    try {
      if (!_googleSignIn.supportsAuthenticate()) {
        throw FirebaseAuthException(
          code: 'unsupported-platform',
          message: 'Google Sign-In not supported on this platform.',
        );
      }

      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'user-canceled',
          message: 'Google Sign-In canceled by user.',
        );
      }

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'invalid-credential',
          message: 'Missing ID token from Google.',
        );
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      return userCredential.user!;
    } on FirebaseAuthException {
      rethrow;
    } catch (e) {
      throw FirebaseAuthException(
        code: 'google-sign-in-failed',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> signOut() async {
    await Future.wait([_googleSignIn.signOut(), _firebaseAuth.signOut()]);
  }
}
