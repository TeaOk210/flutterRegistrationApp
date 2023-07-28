import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/utils/AuthRepository.dart';

import '../generated/l10n.dart';
import '../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool emailState = false;
  bool passwordState = false;

  String? error;

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

  void _onClick() async {
    final repo = AuthRepository();
    try {
      await repo.signInWithEmail(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        error = e.message;
      });
    } 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageMenu()],
        automaticallyImplyLeading: false,
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Text(S.of(context).ent,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(fontSize: 50))),
          InputField(
            icon: Icons.email,
            title: "Email",
            obscure: false,
            state: _updateEmailState,
            controller: emailController,
          ),
          InputField(
            icon: Icons.lock,
            title: "Password",
            obscure: true,
            state: _updatePasswordState,
            controller: passwordController,
          ),
          Text(error ?? "",
              style: const TextStyle(fontSize: 14, color: Colors.red)),
          ContinueButton(
            title: S.of(context).entBtn,
            state: emailState && passwordState,
            callback: _onClick,
          ),
          SignBlock(title: S.of(context).orReg, screen: "/registration"),
          const GoogleButton()
        ],
      )),
    );
  }
}
