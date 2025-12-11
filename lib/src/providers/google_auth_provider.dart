import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_provider_base.dart';

class GoogleSignInProvider implements AuthProviderBase {
  final FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;

  GoogleSignInProvider({FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    _googleSignIn = googleSignIn ?? GoogleSignIn.instance;
    // Initialize if needed (e.g., for custom client IDs)
    // _googleSignIn.initialize(clientId: 'your-client-id.googleusercontent.com');
  }

  @override
  Future<User> signIn() async {
    // Matches AuthProviderBase signature exactly (ignores params if unused)
    try {
      // Check if authenticate is supported (required in 7.x)
      if (!_googleSignIn.supportsAuthenticate()) {
        throw FirebaseAuthException(
          code: 'unsupported-platform',
          message: 'Google Sign-In not supported on this platform.',
        );
      }

      // New method: .authenticate() instead of .signIn()
      final GoogleSignInAccount? googleUser = await _googleSignIn
          .authenticate();

      if (googleUser == null) {
        throw FirebaseAuthException(
          code: 'user-canceled',
          message: 'Google Sign-In canceled by user.',
        );
      }

      // Get tokens via .authorization (separate step in 7.x)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final String? idToken = googleAuth.idToken;
      // final String? accessToken = googleAuth.accessToken; // May be null on web

      if (idToken == null) {
        throw FirebaseAuthException(
          code: 'invalid-credential',
          message: 'Missing ID token from Google.',
        );
      }

      final credential = GoogleAuthProvider.credential(
        //accessToken: accessToken, // Optional in 7.x
        idToken: idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(
        credential,
      );

      // Return dynamic to match base (cast to User if needed in subclasses)
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
    await Future.wait([
      _googleSignIn.signOut(), // Still .signOut() in 7.x
      _firebaseAuth.signOut(),
    ]);
  }
}
