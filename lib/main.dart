import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_reg/pages/ProfileScreen.dart';
import 'package:flutter_reg/pages/RegistrationScreen.dart';
import 'package:flutter_reg/utils/AuthRepository.dart';
import 'package:flutter_reg/utils/LocaleProvider.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/l10n.dart';

void main() async {
  await GetStorage.init("Fields input prikol");
  runApp(const MyApp());

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => LocaleProvider()),
  ], builder: (context, child) {
    final provider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        focusColor: Colors.grey,
        useMaterial3: true,
      ),
      home: const RegistrationScreen(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L10n.all,
      locale: provider.locale,
    );
  });
}

class LanguageMenu extends StatelessWidget {
  const LanguageMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LocaleProvider>(context);
    provider.setLocale(Localizations.localeOf(context));

    return PopupMenuButton<Locale>(
      icon: const Icon(Icons.more_vert),
      onSelected: (Locale locale) {
        provider.setLocale(locale);
      },
      itemBuilder: (BuildContext context) {
        return L10n.all.map((Locale locale) {
          return PopupMenuItem<Locale>(
            value: locale,
            child: Text(
              _getLanguageName(locale),
              style: TextStyle(
                color: locale == provider.locale ? Colors.blue : null,
              ),
            ),
          );
        }).toList();
      },
    );
  }
}

class InputField extends StatefulWidget {
  const InputField(
      {super.key,
      required this.icon,
      required this.title,
      required this.obscure,
      required this.state, required this.controller});

  final IconData icon;
  final String title;
  final bool obscure;
  final TextEditingController controller;

  final ValueChanged<bool> state;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  String input = "";
  final _formKey = GlobalKey<FormBuilderState>();
  late dynamic box;

  @override
  void initState() {
    super.initState();
    box = GetStorage(widget.title);
  }

  void _changeInput(String? text) {
    setState(() {
      input = text!;
      box.write("value", input);
    });

    if (widget.title == "Email") {
      widget.state(isValidEmail(input));
    } else if (widget.title == "Password") {
      widget.state(isValidPassword(input));
    } else if (widget.title == "Username") {
      widget.state(input.isNotEmpty);
    }
  }

  String? _getHelper(String? text) {
    if (widget.title == "Email" && text != null) {
      return isValidEmail(text)
          ? null
          : AppLocalizations.of(context)!.emailReport;
    } else if (widget.title == "Password" && text != null) {
      return isValidPassword(text)
          ? null
          : AppLocalizations.of(context)!.passwordReport;
    } else if (widget.title == "Username" && text == null) {
      return AppLocalizations.of(context)!.usernameReport;
    }
    return null;
  }

  TextInputType? _getType() {
    if (widget.title == "Email") {
      return TextInputType.emailAddress;
    } else if (widget.title == "Password") {
      return TextInputType.visiblePassword;
    } else if (widget.title == "Username") {
      return TextInputType.name;
    } else {
      return TextInputType.none;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: FormBuilderTextField(
            name: "Input text",
            decoration: InputDecoration(
                labelText: widget.title,
                labelStyle: const TextStyle(fontSize: 24, color: Colors.grey),
                helperMaxLines: 2,
                prefixIcon: Icon(widget.icon),
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12),
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(20.0)))),
            style: const TextStyle(fontSize: 24),
            cursorColor: Colors.black,
            obscureText: widget.obscure,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: _getType(),
            validator: _getHelper,
            controller: widget.controller,
            onChanged: _changeInput,
          ),
        ),
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
            child: Center(
              child: Text(
                AppLocalizations.of(context)!.google,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

bool isValidEmail(String email) {
  RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  return emailRegex.hasMatch(email);
}

bool isValidPassword(String password) {
  RegExp passwordRegex = RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$");
  return passwordRegex.hasMatch(password);
}

String _getLanguageName(Locale locale) {
  switch (locale.languageCode) {
    case "ru":
      return "Русский";
    case "en":
      return "English";
    case "uk":
      return "Українська";
    default:
      return "Unknown";
  }
}