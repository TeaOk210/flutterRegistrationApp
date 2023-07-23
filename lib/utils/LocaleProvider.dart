import 'package:flutter/cupertino.dart';

import '../generated/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale; Locale? get locale => _locale;

  LocaleProvider() {
    _locale = WidgetsBinding.instance.window.locales.first;
  }

  void setLocale(Locale? locale) {
    if (!S.delegate.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}