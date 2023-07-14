import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/pages/ProfileScreen.dart';
import 'package:flutter_reg/pages/RegistrationScreen.dart';
import 'package:flutter_reg/utils/AuthRepository.dart';

import 'firebase_options.dart';

void main() async{
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        focusColor: Colors.grey,
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.icon,
      required this.title,
      required this.obscure,
      required this.onTextChanged,
      required this.state});

  final IconData icon;
  final String title;
  final bool obscure;

  final ValueChanged<String> onTextChanged;

  final ValueChanged<bool> state;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String input = "";

  _changeInput(String text) {
    setState(() {
      input = text;
    });
    widget.onTextChanged(text);

    if (widget.title == "Email") {
      widget.state(isValidEmail(input));
    } else if (widget.title == "Password") {
      widget.state(isValidPassword(input));
    } else if (widget.title == "Username") {
      widget.state(input.isNotEmpty);
    }
  }

  String? _getHelper() {
    if (widget.title == "Email" && input.isNotEmpty) {
      return isValidEmail(input) ? null : "Некорректный формат email";
    } else if (widget.title == "Password" && input.isNotEmpty) {
      return isValidPassword(input)
          ? null
          : "Пароль должен содержать цифры и буквы, и быть не менее 8 символов";
    } else if (widget.title == "Username" && input.isEmpty) {
      return "Поле не должно быть пустым!";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: TextField(
            decoration: InputDecoration(
                labelText: widget.title,
                labelStyle: const TextStyle(fontSize: 24, color: Colors.grey),
                helperText: _getHelper(),
                helperStyle: const TextStyle(fontSize: 13, color: Colors.red),
                helperMaxLines: 2,
                prefixIcon: Icon(widget.icon),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            textDirection: TextDirection.ltr,
            style: const TextStyle(fontSize: 24),
            cursorColor: Colors.black12,
            obscureText: widget.obscure,
            onChanged: _changeInput)
      ),
    );
  }
}

class ContinueButton extends StatelessWidget {
  const ContinueButton(
      {super.key,
      required this.title,
      required this.state,
      required this.callback});

  final String title;
  final bool state;
  final VoidCallback callback;

  Color isEnabled() {
    if (state) {
      return const Color.fromARGB(255, 0, 191, 50);
    } else {
      return Colors.grey;
    }
  }

  onClick() {
    if (state) {
      callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 120,
      child: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: ElevatedButton(
          onPressed: onClick,
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(isEnabled()),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
                (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.black;
              }
              return Colors.white;
            }),
          ),
          child: Text(
            title,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}

class SignBlock extends StatelessWidget {
  const SignBlock({super.key, required this.screen, required this.title});

  final String title;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(left: 10),
                child: Divider(height: 100, color: Colors.grey, thickness: 2))),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      screen,
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
            },
            child: Text(
              title,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            )),
        const Expanded(
            flex: 1,
            child: Padding(
                padding: EdgeInsets.only(right: 10),
                child: Divider(height: 100, color: Colors.grey, thickness: 2)))
      ],
    );
  }
}

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

   GestureTapCallback onClick(BuildContext context) {
     return () async {
       User? user = await AuthRepository.signInWithGoogle();
       if (user != null) {
         Navigator.of(context).push(
           PageRouteBuilder(
             pageBuilder: (context, animation, secondaryAnimation) =>
                 ProfileScreen(),
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
     };
   }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick(context),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            child: Image.asset(
              'assets/images/google.png',
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 200,
            height: 70,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              border: Border.all(width: 1, color: Colors.black),
              color: Colors.white,
            ),
            child: const Center(
              child: Text(
                'С помощью Google',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  RegExp emailRegex = RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  RegExp passwordRegex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  return passwordRegex.hasMatch(password);
}
