import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../generated/l10n.dart';
import 'AuthMethods.dart';

class AuthRepository implements AuthMethods {
  @override
  Future<void> registerUsingEmail(
      {required String email,
      required String password,
      required String username}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      userCredential.user!
        ..updateDisplayName(username)
        ..reload();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "email-already-in-use":
          throw FirebaseAuthException(
              code: e.code, message: S.current.language);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInWithEmail(
      {required String email, required String password}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      String? errorMessage;
      switch (e.code) {
        case "user-not-found":
          errorMessage = S.current.loginUserReport;
        case "wrong-password":
          errorMessage = S.current.loginPasswordReport;
      }
      throw FirebaseAuthException(code: e.code, message: errorMessage);
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        await auth.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.toString());
    } catch (e) {
      rethrow;
    }
  }
}