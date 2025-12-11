import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final bool emailVerified;
  final List providerIds;

  const AuthUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    required this.emailVerified,
    required this.providerIds,
  });

  factory AuthUser.fromFirebaseUser(User user) {
    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      emailVerified: user.emailVerified,
      providerIds: user.providerData.map((e) => e.providerId).toList(),
    );
  }

  @override
  List get props => [
    uid,
    email,
    displayName,
    photoUrl,
    emailVerified,
    providerIds,
  ];
}
