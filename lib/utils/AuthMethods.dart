import 'package:flutter_reg/utils/AuthResult.dart';

abstract class AuthMethods {
  Stream<AuthResult> registerUsingEmail(
      {required String email,
      required String password,
      required String username});

  Stream<AuthResult> signInWithEmail(
      {required String email, required String password});
  Stream<AuthResult> signInWithGoogle();
}
