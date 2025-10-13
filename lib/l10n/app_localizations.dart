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
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uz'),
  ];

  /// No description provided for @hero_title.
  ///
  /// In en, this message translates to:
  /// **'Lost or found? Leave an announcement.'**
  String get hero_title;

  /// No description provided for @hero_sub.
  ///
  /// In en, this message translates to:
  /// **'“Honesty is the greatest reward.”'**
  String get hero_sub;

  /// No description provided for @btn_lost.
  ///
  /// In en, this message translates to:
  /// **'❗ Lost'**
  String get btn_lost;

  /// No description provided for @btn_found.
  ///
  /// In en, this message translates to:
  /// **'✅ Found'**
  String get btn_found;

  /// No description provided for @btn_lostlist.
  ///
  /// In en, this message translates to:
  /// **'📋 Lost items'**
  String get btn_lostlist;

  /// No description provided for @btn_reward.
  ///
  /// In en, this message translates to:
  /// **'🎁 Rewarded'**
  String get btn_reward;

  /// No description provided for @btn_foundlist.
  ///
  /// In en, this message translates to:
  /// **'🔎 Found items'**
  String get btn_foundlist;

  /// No description provided for @btn_mine.
  ///
  /// In en, this message translates to:
  /// **'⭐ My announcements'**
  String get btn_mine;

  /// No description provided for @why_title.
  ///
  /// In en, this message translates to:
  /// **'Why BINGO?'**
  String get why_title;

  /// No description provided for @why_text.
  ///
  /// In en, this message translates to:
  /// **'Simple form, quick result. All announcements in one place.'**
  String get why_text;

  /// No description provided for @guide_title.
  ///
  /// In en, this message translates to:
  /// **'Quick guide'**
  String get guide_title;

  /// No description provided for @guide_1.
  ///
  /// In en, this message translates to:
  /// **'❗ Fill out the \'Lost\' or ✅ \'Found\' form'**
  String get guide_1;

  /// No description provided for @guide_2.
  ///
  /// In en, this message translates to:
  /// **'City and contact — required'**
  String get guide_2;

  /// No description provided for @guide_3.
  ///
  /// In en, this message translates to:
  /// **'If a reward is listed, it appears in a separate section'**
  String get guide_3;

  /// No description provided for @lost_form_title.
  ///
  /// In en, this message translates to:
  /// **'Lost — announcement'**
  String get lost_form_title;

  /// No description provided for @found_form_title.
  ///
  /// In en, this message translates to:
  /// **'Found — announcement'**
  String get found_form_title;

  /// No description provided for @lost_list_title.
  ///
  /// In en, this message translates to:
  /// **'📋 All lost items'**
  String get lost_list_title;

  /// No description provided for @reward_list_title.
  ///
  /// In en, this message translates to:
  /// **'🎁 Rewarded'**
  String get reward_list_title;

  /// No description provided for @found_list_title.
  ///
  /// In en, this message translates to:
  /// **'🔎 Found items'**
  String get found_list_title;

  /// No description provided for @mine_title.
  ///
  /// In en, this message translates to:
  /// **'⭐ My announcements'**
  String get mine_title;

  /// No description provided for @btn_delete_mine.
  ///
  /// In en, this message translates to:
  /// **'Delete my announcements'**
  String get btn_delete_mine;

  /// No description provided for @chat_title.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get chat_title;

  /// No description provided for @btn_send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get btn_send;

  /// No description provided for @btn_submit.
  ///
  /// In en, this message translates to:
  /// **'Submit announcement'**
  String get btn_submit;

  /// No description provided for @confirm_del.
  ///
  /// In en, this message translates to:
  /// **'Delete this announcement? This action cannot be undone.'**
  String get confirm_del;

  /// No description provided for @lbl_item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get lbl_item;

  /// No description provided for @lbl_city.
  ///
  /// In en, this message translates to:
  /// **'City/Region'**
  String get lbl_city;

  /// No description provided for @lbl_place.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get lbl_place;

  /// No description provided for @lbl_date.
  ///
  /// In en, this message translates to:
  /// **'Date/Time'**
  String get lbl_date;

  /// No description provided for @lbl_contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get lbl_contact;

  /// No description provided for @lbl_reward.
  ///
  /// In en, this message translates to:
  /// **'Reward (optional)'**
  String get lbl_reward;

  /// No description provided for @lbl_notes.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get lbl_notes;

  /// No description provided for @lbl_photo.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get lbl_photo;

  /// No description provided for @ph_item.
  ///
  /// In en, this message translates to:
  /// **'For example: Phone, bag'**
  String get ph_item;

  /// No description provided for @ph_item_found.
  ///
  /// In en, this message translates to:
  /// **'For example: Passport, key'**
  String get ph_item_found;

  /// No description provided for @ph_city.
  ///
  /// In en, this message translates to:
  /// **'For example: Samarkand'**
  String get ph_city;

  /// No description provided for @ph_place_lost.
  ///
  /// In en, this message translates to:
  /// **'Where did you lose it?'**
  String get ph_place_lost;

  /// No description provided for @ph_place_found.
  ///
  /// In en, this message translates to:
  /// **'Where did you find it?'**
  String get ph_place_found;

  /// No description provided for @ph_date_lost.
  ///
  /// In en, this message translates to:
  /// **'25/08/2025 14:00'**
  String get ph_date_lost;

  /// No description provided for @ph_date_found.
  ///
  /// In en, this message translates to:
  /// **'25/08/2025 10:00'**
  String get ph_date_found;

  /// No description provided for @ph_contact.
  ///
  /// In en, this message translates to:
  /// **'+998 ** *** ** **'**
  String get ph_contact;

  /// No description provided for @ph_reward.
  ///
  /// In en, this message translates to:
  /// **'100000 UZS'**
  String get ph_reward;

  /// No description provided for @ph_notes.
  ///
  /// In en, this message translates to:
  /// **'Write detailed information'**
  String get ph_notes;

  /// No description provided for @ph_name.
  ///
  /// In en, this message translates to:
  /// **'Your name'**
  String get ph_name;

  /// No description provided for @ph_message.
  ///
  /// In en, this message translates to:
  /// **'Message...'**
  String get ph_message;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'dd'**
  String get user;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login_google.
  ///
  /// In en, this message translates to:
  /// **'Login with Google'**
  String get login_google;

  /// No description provided for @chat_error.
  ///
  /// In en, this message translates to:
  /// **'Message cannot be empty'**
  String get chat_error;

  /// No description provided for @chat_sending_error.
  ///
  /// In en, this message translates to:
  /// **'Error sending message:'**
  String get chat_sending_error;

  /// No description provided for @chat_empty.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get chat_empty;

  /// No description provided for @chat_hint.
  ///
  /// In en, this message translates to:
  /// **'Type a message...'**
  String get chat_hint;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get title;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'This is a description'**
  String get description;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search announcements...'**
  String get searchHint;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No announcements found'**
  String get noData;

  /// No description provided for @lostFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Lost '**
  String get lostFormTitle;

  /// No description provided for @foundFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Found'**
  String get foundFormTitle;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'Item'**
  String get item;

  /// No description provided for @itemHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Black wallet, phone'**
  String get itemHint;

  /// No description provided for @itemHelper.
  ///
  /// In en, this message translates to:
  /// **'Write exact name: color, brand, model.'**
  String get itemHelper;

  /// No description provided for @city.
  ///
  /// In en, this message translates to:
  /// **'City/Region'**
  String get city;

  /// No description provided for @cityHint.
  ///
  /// In en, this message translates to:
  /// **'For example: Samarkand / Registan'**
  String get cityHint;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Place'**
  String get place;

  /// No description provided for @placeHint.
  ///
  /// In en, this message translates to:
  /// **'Where did you lose it? (market, bus stop...)'**
  String get placeHint;

  /// No description provided for @dateTime.
  ///
  /// In en, this message translates to:
  /// **'Date/Time'**
  String get dateTime;

  /// No description provided for @dateTimeHint.
  ///
  /// In en, this message translates to:
  /// **'2025-08-30 14:00'**
  String get dateTimeHint;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @contactHint.
  ///
  /// In en, this message translates to:
  /// **'+998 90 123 45 67'**
  String get contactHint;

  /// No description provided for @reward.
  ///
  /// In en, this message translates to:
  /// **'Reward (optional)'**
  String get reward;

  /// No description provided for @rewardHint.
  ///
  /// In en, this message translates to:
  /// **'100000 UZS'**
  String get rewardHint;

  /// No description provided for @extra.
  ///
  /// In en, this message translates to:
  /// **'Additional'**
  String get extra;

  /// No description provided for @extraHint.
  ///
  /// In en, this message translates to:
  /// **'Features: sticker, cover, documents inside...'**
  String get extraHint;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get image;

  /// No description provided for @noFile.
  ///
  /// In en, this message translates to:
  /// **'No file selected'**
  String get noFile;

  /// No description provided for @chooseAnother.
  ///
  /// In en, this message translates to:
  /// **'Choose another photo'**
  String get chooseAnother;

  /// No description provided for @imageRequired.
  ///
  /// In en, this message translates to:
  /// **'Photo selection is required'**
  String get imageRequired;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit announcement'**
  String get submit;

  /// No description provided for @foundTitle1.
  ///
  /// In en, this message translates to:
  /// **'Why BINGO?'**
  String get foundTitle1;

  /// No description provided for @foundDescription1.
  ///
  /// In en, this message translates to:
  /// **'Simple form, quick result. All announcements in one place.'**
  String get foundDescription1;

  /// No description provided for @foundTitle2.
  ///
  /// In en, this message translates to:
  /// **'Quick guide'**
  String get foundTitle2;

  /// No description provided for @foundDescription2.
  ///
  /// In en, this message translates to:
  /// **'❗ Fill out the \'Lost\' or ✅ \'Found\' form'**
  String get foundDescription2;

  /// No description provided for @btn_share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get btn_share;

  /// No description provided for @btn_message.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get btn_message;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uz'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uz':
      return AppLocalizationsUz();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
