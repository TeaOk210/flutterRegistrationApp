import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reg/pages/RegistrationScreen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PersonInfo(),
    );
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

  @override
  void initState() {
    super.initState();
    emailState = user!.emailVerified;
  }

  String emailVerified() {
    if (emailState) {
      return AppLocalizations.of(context)!.emaisStateTrue;
    } else {
      return AppLocalizations.of(context)!.emailStateFalse;
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

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const RegistrationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
              child: Image.network(checkImage(),
                  height: 200, width: 200, fit: BoxFit.cover)),
          Text(user!.displayName.toString(),
              style: const TextStyle(fontSize: 20)),
          RichText(
              text: TextSpan(
                  text: AppLocalizations.of(context)!.email,
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
                      backgroundColor: MaterialStatePropertyAll(buttonColor())),
                  child: Text(AppLocalizations.of(context)!.reportEmail,
                      style: const TextStyle(fontSize: 15, color: Colors.white)))),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                  onPressed: onExit,
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.cyan)),
                  child: Text(AppLocalizations.of(context)!.signOut,
                      style: const TextStyle(fontSize: 15, color: Colors.white))))
        ],
      ),
    );
  }
}