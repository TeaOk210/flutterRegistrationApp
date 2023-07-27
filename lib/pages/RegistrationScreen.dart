import 'package:flutter/material.dart';
import 'package:flutter_reg/AuthViewModel.dart';
import 'package:provider/provider.dart';

import '../generated/l10n.dart';
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
    final model = Provider.of<AuthViewModel>(context);
    await model.registrationUser(emailController.text, usernamecontroller.text, passwordController.text);
    // AuthRepository repository = AuthRepository();
    // User? user = await repository.registerUsingEmail(
    //     email: emailController.text, password: passwordController.text, username: usernamecontroller.text);
    // if (user != null) {
    //   Navigator.of(context).pushReplacementNamed('/profile');
    // }
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
                child: Text(S.of(context).reg,
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
              title: S.of(context).regBtn,
              state: emailState && passwordState,
              callback: _onClick,
            ),
            SignBlock(title: S.of(context).orEnt, screen: "/login"),
            const GoogleButton()
          ],
        ),
      ),
    );
  }
}