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
      return "https://sun9-10.userapi.com/impg/_4HPY2SUHnnMe7QjLrSRVSkDlPG9gh9CKYqltQ/OmI_xaiXTQg.jpg?size=604x604&quality=95&sign=ffd64cc67a1f0de321e2611b93339783&c_uniq_tag=IdQQGv52654nH_2mhz-7CQaCw1lEUEODAnubeI2jCHA&type=album";
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "your password is ${box.read("value")}",
              style: const TextStyle(fontSize: 20, color: Colors.cyan),
            ),
            ClipOval(
                child: Image.network(checkImage(),
                    height: 200, width: 200, fit: BoxFit.cover)),
            Text(user!.displayName.toString(),
                style: const TextStyle(fontSize: 20)),
            RichText(
                text: TextSpan(
                    text: S.of(context).email,
                    style: const TextStyle(fontSize: 20, color: Colors.black),
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
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white)))),
            Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ElevatedButton(
                    onPressed: onExit,
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                    child: Text(S.of(context).signOut,
                        style: const TextStyle(
                            fontSize: 15, color: Colors.white))))
          ],
        ),
      ),
    );
  }
}
