import 'package:firebase_auth/firebase_auth.dart';
import 'package:hng_auth_sdk/headless/auth_sdk_headless.dart';

class ErrorMapper {
  static AuthException mapFirebaseException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
      case 'wrong-password':
      case 'invalid-credential':
        return InvalidCredentialsException(e.message);

      case 'user-not-found':
        return UserNotFoundException(e.message);

      case 'email-already-in-use':
        return EmailAlreadyInUseException(e.message);

      case 'weak-password':
        return WeakPasswordException(e.message);

      case 'user-token-expired':
      case 'id-token-expired':
        return TokenExpiredException(e.message);

      case 'network-request-failed':
        return NetworkException(e.message);

      case 'user-disabled':
        return UserDisabledException('This account has been disabled');

      case 'operation-not-allowed':
        return OperationNotAllowedException('This operation is not allowed');

      case 'too-many-requests':
        return TooManyRequestsException(
          'Too many requests. Please try again later',
        );

      default:
        return UnknownAuthException(
          e.message ?? 'An unexpected error occurred',
        );
    }
  }

  static AuthException mapGeneralException(Exception e) {
    if (e is FirebaseAuthException) {
      return mapFirebaseException(e);
    }
    return UnknownAuthException(e.toString());
  }
}
