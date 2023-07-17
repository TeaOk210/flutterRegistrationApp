import 'package:flutter/cupertino.dart';
import 'package:flutter_reg/l10n/l10n.dart';


class LocaleProvirer extends ChangeNotifier {
  Locale? _locale; Locale? get locale => _locale;

  void setLocale(Locale? locale) {
    if (!L10n.all.contains(locale)) return;

    _locale = locale;
    notifyListeners();
  }
}