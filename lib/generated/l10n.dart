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

  /// `Внесете го вашето име за до го видите ценовникот.`
  String get signIn {
    return Intl.message(
      'Внесете го вашето име за до го видите ценовникот.',
      name: 'signIn',
      desc: '',
      args: [],
    );
  }

  /// `Вашето име`
  String get yourName {
    return Intl.message(
      'Вашето име',
      name: 'yourName',
      desc: '',
      args: [],
    );
  }

  /// `Здраво, `
  String get zdravo {
    return Intl.message(
      'Здраво, ',
      name: 'zdravo',
      desc: '',
      args: [],
    );
  }

  /// `Почетна`
  String get home {
    return Intl.message(
      'Почетна',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Пребарај`
  String get search {
    return Intl.message(
      'Пребарај',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Омилени`
  String get favorite {
    return Intl.message(
      'Омилени',
      name: 'favorite',
      desc: '',
      args: [],
    );
  }

  /// `Нексио`
  String get about {
    return Intl.message(
      'Нексио',
      name: 'about',
      desc: '',
      args: [],
    );
  }

  /// `Омилени производи`
  String get favoriteProducts {
    return Intl.message(
      'Омилени производи',
      name: 'favoriteProducts',
      desc: '',
      args: [],
    );
  }

  /// `Сеуште немате омилени производи`
  String get noFavorite {
    return Intl.message(
      'Сеуште немате омилени производи',
      name: 'noFavorite',
      desc: '',
      args: [],
    );
  }

  /// `Контакт информации`
  String get contactInfo {
    return Intl.message(
      'Контакт информации',
      name: 'contactInfo',
      desc: '',
      args: [],
    );
  }

  /// `Верзија: {version} ({buildNumber})`
  String version(Object version, Object buildNumber) {
    return Intl.message(
      'Верзија: $version ($buildNumber)',
      name: 'version',
      desc: 'Верзија на апликацијата',
      args: [version, buildNumber],
    );
  }

  /// `Вкупно {count} производи`
  String totalProducts(Object count) {
    return Intl.message(
      'Вкупно $count производи',
      name: 'totalProducts',
      desc: 'Вкупно производи',
      args: [count],
    );
  }

  /// `Код:`
  String get productCode {
    return Intl.message(
      'Код:',
      name: 'productCode',
      desc: '',
      args: [],
    );
  }

  /// `Подкатегорија:`
  String get productCat {
    return Intl.message(
      'Подкатегорија:',
      name: 'productCat',
      desc: '',
      args: [],
    );
  }

  /// `Бренд:`
  String get productBrend {
    return Intl.message(
      'Бренд:',
      name: 'productBrend',
      desc: '',
      args: [],
    );
  }

  /// `Нексио Компјутери`
  String get neksioKompjuteri {
    return Intl.message(
      'Нексио Компјутери',
      name: 'neksioKompjuteri',
      desc: '',
      args: [],
    );
  }

  /// `Пребарај производи...`
  String get searchProductPlaceholder {
    return Intl.message(
      'Пребарај производи...',
      name: 'searchProductPlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Дознај цени на повеќе од 1200 производи`
  String get listAllProduct {
    return Intl.message(
      'Дознај цени на повеќе од 1200 производи',
      name: 'listAllProduct',
      desc: '',
      args: [],
    );
  }

  /// `Нексио Ценовник`
  String get neksioCenovnik {
    return Intl.message(
      'Нексио Ценовник',
      name: 'neksioCenovnik',
      desc: '',
      args: [],
    );
  }

  /// `Внесете го вашето име за да продолжите`
  String get emptyField {
    return Intl.message(
      'Внесете го вашето име за да продолжите',
      name: 'emptyField',
      desc: '',
      args: [],
    );
  }

  /// `За нексио компјутери`
  String get aboutNeksio {
    return Intl.message(
      'За нексио компјутери',
      name: 'aboutNeksio',
      desc: '',
      args: [],
    );
  }

  /// `Оваа апликиација е неофицијална но е поддржана од Нексио компјутер.\nСите податоци во оваа апликација се превземени од приватно API и истите се обновуваат еднаш дневно.`
  String get aboutNeksioDesc {
    return Intl.message(
      'Оваа апликиација е неофицијална но е поддржана од Нексио компјутер.\nСите податоци во оваа апликација се превземени од приватно API и истите се обновуваат еднаш дневно.',
      name: 'aboutNeksioDesc',
      desc: '',
      args: [],
    );
  }

  /// `Влези`
  String get signInButton {
    return Intl.message(
      'Влези',
      name: 'signInButton',
      desc: '',
      args: [],
    );
  }

  /// `Пребарај по`
  String get searchBy {
    return Intl.message(
      'Пребарај по',
      name: 'searchBy',
      desc: '',
      args: [],
    );
  }

  /// `Категории`
  String get searchByCategories {
    return Intl.message(
      'Категории',
      name: 'searchByCategories',
      desc: '',
      args: [],
    );
  }

  /// `Лагер`
  String get productStock {
    return Intl.message(
      'Лагер',
      name: 'productStock',
      desc: '',
      args: [],
    );
  }

  /// `Цена`
  String get productPrice {
    return Intl.message(
      'Цена',
      name: 'productPrice',
      desc: '',
      args: [],
    );
  }

  /// `Гаранција`
  String get productWarranty {
    return Intl.message(
      'Гаранција',
      name: 'productWarranty',
      desc: '',
      args: [],
    );
  }

  /// `ДДВ`
  String get productVat {
    return Intl.message(
      'ДДВ',
      name: 'productVat',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'mk'),
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
