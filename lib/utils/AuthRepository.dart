import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_reg/utils/AuthResult.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../generated/l10n.dart';
import 'AuthMethods.dart';

class AuthRepository implements AuthMethods {
  @override
  Stream<AuthResult> registerUsingEmail(
      {required String email,
      required String password,
      required String username}) async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateDisplayName(username);
      await user.reload();
      yield AuthResult(user: user);
    } on FirebaseAuthException catch (e) {
      String error = e.code;
      switch (e.code) {
        case "email-already-in-use":
          error = S.current.registrationMailReport;
          break;
      }
      yield AuthResult(error: error);
    } catch (e) {
      yield AuthResult(error: e.toString());
    }
  }

  @override
  Stream<AuthResult> signInWithEmail(
      {required String email, required String password}) async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = userCredential.user;
      yield AuthResult(user: user);
    } on FirebaseAuthException catch (e) {
      yield AuthResult(error: e.code);
    } catch (e) {
      yield AuthResult(error: e.toString());
    }
  }

  @override
  Stream<AuthResult> signInWithGoogle() async* {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        yield AuthResult(user: user);
      }
    } on FirebaseAuthException catch (e) {
      yield AuthResult(error: e.code);
    }
  }
}