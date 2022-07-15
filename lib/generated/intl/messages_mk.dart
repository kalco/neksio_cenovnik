// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a mk locale. All the
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
  String get localeName => 'mk';

  static String m0(count) => "Вкупно ${count} производи";

  static String m1(version, buildNumber) =>
      "Верзија: ${version} (${buildNumber})";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("Нексио"),
        "aboutNeksio":
            MessageLookupByLibrary.simpleMessage("За нексио компјутери"),
        "aboutNeksioDesc": MessageLookupByLibrary.simpleMessage(
            "Оваа апликиација е неофицијална и не е поддржана од Нексио компјутер.\nСите податоци во оваа апликација се од јавен карактер и не сносувам никаква одговорност за веродостојноста на истите."),
        "contactInfo":
            MessageLookupByLibrary.simpleMessage("Контакт информации"),
        "emptyField": MessageLookupByLibrary.simpleMessage(
            "Внесете го вашето име за да продолжите"),
        "favorite": MessageLookupByLibrary.simpleMessage("Омилени"),
        "favoriteProducts":
            MessageLookupByLibrary.simpleMessage("Омилени производи"),
        "home": MessageLookupByLibrary.simpleMessage("Почетна"),
        "listAllProduct": MessageLookupByLibrary.simpleMessage(
            "Дознај цени на повеќе од 1200 производи"),
        "neksioCenovnik":
            MessageLookupByLibrary.simpleMessage("Нексио Ценовник"),
        "neksioKompjuteri":
            MessageLookupByLibrary.simpleMessage("Нексио Компјутери"),
        "noFavorite": MessageLookupByLibrary.simpleMessage(
            "Сеуште немате омилени производи"),
        "productBrend": MessageLookupByLibrary.simpleMessage("Бренд:"),
        "productCat": MessageLookupByLibrary.simpleMessage("Подкатегорија:"),
        "productCode": MessageLookupByLibrary.simpleMessage("Код:"),
        "productPrice": MessageLookupByLibrary.simpleMessage("Цена"),
        "productStock": MessageLookupByLibrary.simpleMessage("Лагер"),
        "productVat": MessageLookupByLibrary.simpleMessage("ДДВ"),
        "productWarranty": MessageLookupByLibrary.simpleMessage("Гаранција"),
        "search": MessageLookupByLibrary.simpleMessage("Пребарај"),
        "searchBy": MessageLookupByLibrary.simpleMessage("Пребарај по"),
        "searchByCategories": MessageLookupByLibrary.simpleMessage("Категории"),
        "searchProductPlaceholder":
            MessageLookupByLibrary.simpleMessage("Пребарај производи..."),
        "signIn": MessageLookupByLibrary.simpleMessage(
            "Внесете го вашето име за до го видите ценовникот."),
        "signInButton": MessageLookupByLibrary.simpleMessage("Влези"),
        "totalProducts": m0,
        "version": m1,
        "yourName": MessageLookupByLibrary.simpleMessage("Вашето име"),
        "zdravo": MessageLookupByLibrary.simpleMessage("Здраво, ")
      };
}
