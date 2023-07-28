// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `English`
  String get language {
    return Intl.message(
      'English',
      name: 'language',
      desc: 'The current language',
      args: [],
    );
  }

  /// `Registration`
  String get reg {
    return Intl.message(
      'Registration',
      name: 'reg',
      desc: '',
      args: [],
    );
  }

  /// `Entry`
  String get ent {
    return Intl.message(
      'Entry',
      name: 'ent',
      desc: '',
      args: [],
    );
  }

  /// `sign up`
  String get regBtn {
    return Intl.message(
      'sign up',
      name: 'regBtn',
      desc: '',
      args: [],
    );
  }

  /// `log in`
  String get entBtn {
    return Intl.message(
      'log in',
      name: 'entBtn',
      desc: '',
      args: [],
    );
  }

  /// `or log in`
  String get orEnt {
    return Intl.message(
      'or log in',
      name: 'orEnt',
      desc: 'selection name',
      args: [],
    );
  }

  /// `or sign up`
  String get orReg {
    return Intl.message(
      'or sign up',
      name: 'orReg',
      desc: 'selection name',
      args: [],
    );
  }

  /// `Using google`
  String get google {
    return Intl.message(
      'Using google',
      name: 'google',
      desc: 'Using google',
      args: [],
    );
  }

  /// `Your mail is `
  String get email {
    return Intl.message(
      'Your mail is ',
      name: 'email',
      desc: 'email state',
      args: [],
    );
  }

  /// `confirmed`
  String get emailStateTrue {
    return Intl.message(
      'confirmed',
      name: 'emailStateTrue',
      desc: '',
      args: [],
    );
  }

  /// `not confirmed`
  String get emailStateFalse {
    return Intl.message(
      'not confirmed',
      name: 'emailStateFalse',
      desc: 'email not confirmed',
      args: [],
    );
  }

  /// `Confirm mail`
  String get reportEmail {
    return Intl.message(
      'Confirm mail',
      name: 'reportEmail',
      desc: 'Confirm mail',
      args: [],
    );
  }

  /// `Log out of account`
  String get signOut {
    return Intl.message(
      'Log out of account',
      name: 'signOut',
      desc: 'log out',
      args: [],
    );
  }

  /// `Incorrect email format`
  String get emailReport {
    return Intl.message(
      'Incorrect email format',
      name: 'emailReport',
      desc: 'mail field error',
      args: [],
    );
  }

  /// `The password must contain numbers and letters, and be at least 8 characters`
  String get passwordReport {
    return Intl.message(
      'The password must contain numbers and letters, and be at least 8 characters',
      name: 'passwordReport',
      desc: 'password field error',
      args: [],
    );
  }

  /// `The field should not be empty!`
  String get usernameReport {
    return Intl.message(
      'The field should not be empty!',
      name: 'usernameReport',
      desc: 'name field error',
      args: [],
    );
  }

  /// `the mail is already registered`
  String get registrationMailReport {
    return Intl.message(
      'the mail is already registered',
      name: 'registrationMailReport',
      desc: 'Mail error',
      args: [],
    );
  }

  /// `Invalid password, or it does not exist`
  String get loginPasswordReport {
    return Intl.message(
      'Invalid password, or it does not exist',
      name: 'loginPasswordReport',
      desc: 'error if the password is incorrect',
      args: [],
    );
  }

  /// `User not found`
  String get loginUserReport {
    return Intl.message(
      'User not found',
      name: 'loginUserReport',
      desc: 'error if the user is not found',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
