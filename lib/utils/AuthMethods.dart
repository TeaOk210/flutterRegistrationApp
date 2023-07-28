abstract class AuthMethods {
  Future<void> registerUsingEmail(
      {required String email,
      required String password,
      required String username});

  Future<void> signInWithEmail(
      {required String email, required String password});
  Future<void> signInWithGoogle();
}
