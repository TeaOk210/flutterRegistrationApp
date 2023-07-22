import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthMethods {

  Future<User?> registerUsingEmail({required String email, required String password, required String username});

  Future<User?> signInWithEmail({required String email, required String password});

  Future<User?> signInWithGoogle();
}