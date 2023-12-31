import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../generated/l10n.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const PersonInfo();
  }
}

class PersonInfo extends StatefulWidget {
  const PersonInfo({super.key});

  @override
  State<PersonInfo> createState() => _PersonInfoState();
}

class _PersonInfoState extends State<PersonInfo> {
  User? user = FirebaseAuth.instance.currentUser;
  bool emailState = false;
  late dynamic box;

  @override
  void initState() {
    super.initState();
    emailState = user!.emailVerified;
    box = GetStorage("Password");
  }

  String emailVerified() {
    if (emailState) {
      return S.of(context).emailStateTrue;
    } else {
      return S.of(context).emailStateFalse;
    }
  }

  String checkImage() {
    if (user!.photoURL != null) {
      return user!.photoURL.toString();
    } else {
      return "https://w7.pngwing.com/pngs/313/542/png-transparent-business-organization-computer-software-tom-clancy-s-rainbow-six-siege-research-unknown-person.png";
    }
  }

  Color buttonColor() {
    if (emailState) {
      return Colors.grey;
    } else {
      return Colors.purple;
    }
  }

  Color textColor() {
    if (emailState) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  onClick() async {
    if (!emailState) {
      await user!.sendEmailVerification();
      user!.reload();
    }
  }

  onExit() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed("/registration");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LanguageMenu()],
        automaticallyImplyLeading: false,
        title: const ThemeSelection(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "your password is ${box.read("value")}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            ClipOval(
                child: Image.network(checkImage(),
                    height: 200, width: 200, fit: BoxFit.cover)),
            Text(user!.displayName.toString(),
                style: Theme.of(context).textTheme.titleSmall),
            RichText(
                text: TextSpan(
                    text: S.of(context).email,
                    style: Theme.of(context).textTheme.titleSmall,
                    children: [
                  TextSpan(
                      text: emailVerified(),
                      style: TextStyle(fontSize: 20, color: textColor()))
                ])),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: onClick,
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(buttonColor())),
                    child: Text(S.of(context).reportEmail,
                        style: Theme.of(context).textTheme.labelLarge))),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: onExit,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                    child: Text(S.of(context).signOut,
                        style: Theme.of(context).textTheme.labelLarge)))
          ],
        ),
      ),
    );
  }
}
