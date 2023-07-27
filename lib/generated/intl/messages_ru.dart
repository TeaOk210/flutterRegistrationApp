// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "email": MessageLookupByLibrary.simpleMessage("Ваша почта"),
        "emailReport":
            MessageLookupByLibrary.simpleMessage("Некорректный формат email"),
        "emailStateFalse":
            MessageLookupByLibrary.simpleMessage("не подтверждена"),
        "emailStateTrue": MessageLookupByLibrary.simpleMessage("подтверждена"),
        "ent": MessageLookupByLibrary.simpleMessage("Вход"),
        "entBtn": MessageLookupByLibrary.simpleMessage("войти"),
        "google": MessageLookupByLibrary.simpleMessage("С помощью google"),
        "language": MessageLookupByLibrary.simpleMessage("Русский"),
        "orEnt": MessageLookupByLibrary.simpleMessage("или войти"),
        "orReg": MessageLookupByLibrary.simpleMessage("или зарегистрироваться"),
        "passwordReport": MessageLookupByLibrary.simpleMessage(
            "Пароль должен содержать цифры и буквы, и быть не менее 8 символов"),
        "reg": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "regBtn": MessageLookupByLibrary.simpleMessage("зарегистрироваться"),
        "registrationMailReport":
            MessageLookupByLibrary.simpleMessage("Почта уже зарегистрирована"),
        "reportEmail":
            MessageLookupByLibrary.simpleMessage("Подтвердить почту"),
        "signOut": MessageLookupByLibrary.simpleMessage("Выйти из аккауниа"),
        "usernameReport":
            MessageLookupByLibrary.simpleMessage("Поле не должно быть пустым!")
      };
}
