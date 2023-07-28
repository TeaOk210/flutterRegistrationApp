// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';

class AuthResult {
  final User? user;
  final String? error;
  AuthResult({
    this.user,
    this.error,
  });

  @override
  String toString() => 'AuthResult(onSuccess: $user, error: $error)';

  @override
  bool operator ==(covariant AuthResult other) {
    if (identical(this, other)) return true;

    return other.user == user && other.error == error;
  }

  @override
  int get hashCode => user.hashCode ^ error.hashCode;
}
