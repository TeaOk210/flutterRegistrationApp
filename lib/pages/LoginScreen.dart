import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/pages/RegistrationScreen.dart';

import '../main.dart';
import '../utils/AuthRepository.dart';
import 'ProfileScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  bool emailState = false;
  bool passwordState = false;


  void _updateEmailState(bool value) {
    setState(() {
      emailState = value;
    });
  }

  void _updatePasswordState(bool value) {
    setState(() {
      passwordState = value;
    });
  }

  void _updateEmail(String value) {
    setState(() {
      email = value;
    });
  }

  void _updatePassword(String value) {
    setState(() {
      password = value;
    });
  }

  void _onClick() async {
    User? user = await AuthRepository.signInWithEmail(email: email, password: password);
    if (user != null) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfileScreen(),
          transitionsBuilder:
              (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
                padding: EdgeInsets.only(top: 50),
                child: Text("Вход",
                    textDirection: TextDirection.ltr,
                    style: TextStyle(fontSize: 50))),
            InputField(
                icon: Icons.email,
                title: "Email",
                obscure: false,
                onTextChanged: _updateEmail,
                state: _updateEmailState),
            InputField(
                icon: Icons.lock,
                title: "Password",
                obscure: true,
                onTextChanged: _updatePassword,
                state: _updatePasswordState),
            ContinueButton(
              title: "Войти",
              state: emailState && passwordState,
              callback: _onClick,
            ),
            const SignBlock(
                title: "Или зарегистрироваться", screen: RegistrationScreen()),
            const GoogleButton()
          ],
        ),
      ),
    );
  }
}
