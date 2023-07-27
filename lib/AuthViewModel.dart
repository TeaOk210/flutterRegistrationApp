import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_reg/utils/AuthResult.dart';
import 'package:flutter_reg/utils/index.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository repository = AuthRepository();
  final StreamController<AuthResult> _authStateController = StreamController<AuthResult>();

  Stream<AuthResult> get authResultStream => _authStateController.stream;

  Future<void> registrationUser(String email, String username, String password) async {
    await for (AuthResult state in repository.registerUsingEmail(email: email, password: password, username: username)) {
      _authStateController.add(state);
    }
  }

  Future<void> loginUser(String email, String password) async {
    await for (AuthResult state in repository.signInWithEmail(email: email, password: password)) {
      _authStateController.add(state);

    }
  }

    Future<void> googleLogin() async {
    await for (AuthResult state in repository.signInWithGoogle()) {
      _authStateController.add(state);
    }
  }

  @override
  void dispose() {
    _authStateController.close();
    super.dispose();
  }
}

class AuthViewModelSingleton {
  static final AuthViewModel _instance = AuthViewModel();
  static AuthViewModel get instance => _instance;
}