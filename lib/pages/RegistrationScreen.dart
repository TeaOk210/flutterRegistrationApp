import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/pages/LoginScreen.dart';
import 'package:flutter_reg/pages/ProfileScreen.dart';
import 'package:flutter_reg/utils/AuthRepository.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernamecontroller = TextEditingController();

  bool emailState = false;
  bool passwordState = false;
  bool usernameState = false;

  void _updateUsernameState(bool value) {
    setState(() {
      usernameState = value;
    });
  }

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
    User? user = await AuthRepository.registrUsingEmail(
        email: emailController.text, password: passwordController.text, username: usernamecontroller.text);
    if (user != null) {
      Navigator.of(context).push(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const ProfileScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
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
      appBar: AppBar(
        actions: const [
          LanguageMenu()
        ],
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
                child: Text(AppLocalizations.of(context)!.reg,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(fontSize: 50))),
            InputField(
                icon: Icons.email,
                title: "Email",
                obscure: false,
                // onTextChanged: _updateEmail,
                state: _updateEmailState,
            controller: emailController),
            InputField(
                icon: Icons.person,
                title: "Username",
                obscure: false,
                // onTextChanged: _updateUsername,
                state: _updateUsernameState,
            controller: usernamecontroller),
            InputField(
                icon: Icons.lock,
                title: "Password",
                obscure: true,
                // onTextChanged: _updatePassword,
                state: _updatePasswordState,
            controller: passwordController),
            ContinueButton(
              title: AppLocalizations.of(context)!.regBtn,
              state: emailState && passwordState,
              callback: _onClick,
            ),
            SignBlock(title: AppLocalizations.of(context)!.orEnt, screen: const LoginScreen()),
            const GoogleButton()
          ],
        ),
      ),
    );
  }
}