abstract class AuthException implements Exception {
  final String message;
  final String? code;

  AuthException(this.message, [this.code]);

  @override
  String toString() => message;
}

class InvalidCredentialsException extends AuthException {
  InvalidCredentialsException([String? message])
    : super(
        message ?? 'Invalid email or password combination',
        'invalid-credentials',
      );
}

class UserNotFoundException extends AuthException {
  UserNotFoundException([String? message])
    : super(message ?? 'No account found with this email', 'user-not-found');
}

class EmailAlreadyInUseException extends AuthException {
  EmailAlreadyInUseException([String? message])
    : super(
        message ?? 'An account already exists with this email',
        'email-in-use',
      );
}

class WeakPasswordException extends AuthException {
  WeakPasswordException([String? message])
    : super(
        message ?? 'Password is too weak. Use at least 6 characters',
        'weak-password',
      );
}

class TokenExpiredException extends AuthException {
  TokenExpiredException([String? message])
    : super(
        message ?? 'Your session has expired. Please login again',
        'token-expired',
      );
}

class NetworkException extends AuthException {
  NetworkException([String? message])
    : super(
        message ?? 'Network error. Please check your connection',
        'network-error',
      );
}

class UnknownAuthException extends AuthException {
  UnknownAuthException([String? message])
    : super(message ?? 'An unexpected error occurred', 'unknown-error');
}

class AuthCancelledException extends AuthException {
  AuthCancelledException([String? message])
    : super(message ?? 'Authentication was cancelled', 'auth-cancelled');
}

class UserDisabledException extends AuthException {
  UserDisabledException([String? message])
    : super(message ?? 'This account has been disabled', 'user-disabled');
}

class OperationNotAllowedException extends AuthException {
  OperationNotAllowedException([String? message])
    : super(
        message ?? 'This operation is not allowed',
        'operation-not-allowed',
      );
}

class TooManyRequestsException extends AuthException {
  TooManyRequestsException([String? message])
    : super(
        message ?? 'Too many requests. Please try again later',
        'too-many-requests',
      );
}
