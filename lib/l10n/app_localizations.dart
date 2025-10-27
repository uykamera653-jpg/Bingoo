// GENERATED: manual fixed version for btn_delete and deleted_msg
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uz.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  // existing getters...
  String get hero_title;
  String get hero_sub;
  String get btn_lost;
  String get btn_found;
  String get btn_lostlist;
  String get btn_reward;
  String get btn_foundlist;
  String get btn_mine;
  String get why_title;
  String get why_text;
  String get guide_title;
  String get guide_1;
  String get guide_2;
  String get guide_3;
  String get lost_form_title;
  String get found_form_title;
  String get lost_list_title;
  String get reward_list_title;
  String get found_list_title;
  String get mine_title;
  String get btn_delete_mine;

  // IMPORTANT — add these two:
  String get btn_delete;
  String get deleted_msg;

  String get chat_title;
  String get btn_send;
  String get btn_submit;
  String get confirm_del;
  String get lbl_item;
  String get lbl_city;
  String get lbl_place;
  String get lbl_date;
  String get lbl_contact;
  String get lbl_reward;
  String get lbl_notes;
  String get lbl_photo;
  String get ph_item;
  String get ph_item_found;
  String get ph_city;
  String get ph_place_lost;
  String get ph_place_found;
  String get ph_date_lost;
  String get ph_date_found;
  String get ph_contact;
  String get ph_reward;
  String get ph_notes;
  String get ph_name;
  String get ph_message;
  String get user;
  String get logout;
  String get login_google;
  String get chat_error;
  String get chat_sending_error;
  String get chat_empty;
  String get chat_hint;
  String get title;
  String get description;
  String get searchHint;
  String get noData;
  String get lostFormTitle;
  String get foundFormTitle;
  String get item;
  String get itemHint;
  String get itemHelper;
  String get city;
  String get cityHint;
  String get place;
  String get placeHint;
  String get dateTime;
  String get dateTimeHint;
  String get contact;
  String get contactHint;
  String get reward;
  String get rewardHint;
  String get extra;
  String get extraHint;
  String get image;
  String get noFile;
  String get chooseAnother;
  String get imageRequired;
  String get submit;
  String get foundTitle1;
  String get foundDescription1;
  String get foundTitle2;
  String get foundDescription2;
  String get btn_share;
  String get btn_message;
}
