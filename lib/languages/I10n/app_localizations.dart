import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_af.dart';
import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_id.dart';
import 'app_localizations_pt.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'I10n/app_localizations.dart';
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
    Locale('af'),
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('id'),
    Locale('pt'),
  ];

  /// No description provided for @app_name.
  ///
  /// In en, this message translates to:
  /// **'Pranker'**
  String get app_name;

  /// No description provided for @ad_warning.
  ///
  /// In en, this message translates to:
  /// **'This action may contain ad.'**
  String get ad_warning;

  /// No description provided for @title_app_language.
  ///
  /// In en, this message translates to:
  /// **'App language'**
  String get title_app_language;

  /// No description provided for @action_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get action_next;

  /// No description provided for @body_onboarding_1.
  ///
  /// In en, this message translates to:
  /// **'Prank your friends with realistic scissor and razor sounds!'**
  String get body_onboarding_1;

  /// No description provided for @body_onboarding_2.
  ///
  /// In en, this message translates to:
  /// **'Make your friends think they’re losing their hair!'**
  String get body_onboarding_2;

  /// No description provided for @body_onboarding_3.
  ///
  /// In en, this message translates to:
  /// **'Shock your friends with realistic taser sounds and vibrations!'**
  String get body_onboarding_3;

  /// No description provided for @body_onboarding_4.
  ///
  /// In en, this message translates to:
  /// **'Realistic sound effects and sneaky fun await.'**
  String get body_onboarding_4;

  /// No description provided for @title_category_screen.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get title_category_screen;

  /// No description provided for @body_category_screen.
  ///
  /// In en, this message translates to:
  /// **'Select type of content you like.'**
  String get body_category_screen;

  /// No description provided for @action_got_it.
  ///
  /// In en, this message translates to:
  /// **'Okay, got it!'**
  String get action_got_it;

  /// No description provided for @action_remind_later.
  ///
  /// In en, this message translates to:
  /// **'Remind me later'**
  String get action_remind_later;

  /// No description provided for @title_premium_screen.
  ///
  /// In en, this message translates to:
  /// **'Go Pro & Prank Like a Pro!'**
  String get title_premium_screen;

  /// No description provided for @header_why_premium.
  ///
  /// In en, this message translates to:
  /// **'Unlock the ultimate prank arsenal:'**
  String get header_why_premium;

  /// No description provided for @body_premium_feature_1.
  ///
  /// In en, this message translates to:
  /// **'Realistic Trimmer Sounds'**
  String get body_premium_feature_1;

  /// No description provided for @body_premium_feature_2.
  ///
  /// In en, this message translates to:
  /// **'Vibration Effects for Ultra-Real Feel'**
  String get body_premium_feature_2;

  /// No description provided for @body_premium_feature_3.
  ///
  /// In en, this message translates to:
  /// **'Extra Prank Modes (Electric Razor, Scissors, Shaver & more!)'**
  String get body_premium_feature_3;

  /// No description provided for @body_premium_feature_4.
  ///
  /// In en, this message translates to:
  /// **'Ad-Free Pranking Experience'**
  String get body_premium_feature_4;

  /// No description provided for @label_choose_plan.
  ///
  /// In en, this message translates to:
  /// **'Choose Your Plan:'**
  String get label_choose_plan;

  /// No description provided for @plan_weekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get plan_weekly;

  /// No description provided for @plan_week.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get plan_week;

  /// No description provided for @plan_monthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get plan_monthly;

  /// No description provided for @plan_annual.
  ///
  /// In en, this message translates to:
  /// **'Annual'**
  String get plan_annual;

  /// No description provided for @plan_year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get plan_year;

  /// No description provided for @plan_label_best.
  ///
  /// In en, this message translates to:
  /// **'Best Value'**
  String get plan_label_best;

  /// No description provided for @action_upgrade_pro.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to pro'**
  String get action_upgrade_pro;

  /// No description provided for @action_restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get action_restore;

  /// No description provided for @action_terms_of_use.
  ///
  /// In en, this message translates to:
  /// **'Terms of use'**
  String get action_terms_of_use;

  /// No description provided for @action_privacy_policy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get action_privacy_policy;

  /// No description provided for @title_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title_settings;

  /// No description provided for @action_restore_purchase.
  ///
  /// In en, this message translates to:
  /// **'Restore purchase'**
  String get action_restore_purchase;

  /// No description provided for @category_hair_clipper.
  ///
  /// In en, this message translates to:
  /// **'Hair clipper'**
  String get category_hair_clipper;

  /// No description provided for @category_hair_cut.
  ///
  /// In en, this message translates to:
  /// **'Hair cut'**
  String get category_hair_cut;

  /// No description provided for @category_taser.
  ///
  /// In en, this message translates to:
  /// **'Taser'**
  String get category_taser;

  /// No description provided for @category_fart.
  ///
  /// In en, this message translates to:
  /// **'Fart'**
  String get category_fart;

  /// No description provided for @category_gun.
  ///
  /// In en, this message translates to:
  /// **'Gun'**
  String get category_gun;

  /// No description provided for @category_bomb_sound.
  ///
  /// In en, this message translates to:
  /// **'Bomb sound'**
  String get category_bomb_sound;

  /// No description provided for @category_animals.
  ///
  /// In en, this message translates to:
  /// **'Animals'**
  String get category_animals;

  /// No description provided for @category_air_horn.
  ///
  /// In en, this message translates to:
  /// **'Air horn'**
  String get category_air_horn;

  /// No description provided for @category_horror_sound.
  ///
  /// In en, this message translates to:
  /// **'Horror sound'**
  String get category_horror_sound;

  /// No description provided for @category_police_siren.
  ///
  /// In en, this message translates to:
  /// **'Police siren'**
  String get category_police_siren;

  /// No description provided for @action_play_after.
  ///
  /// In en, this message translates to:
  /// **'Play after'**
  String get action_play_after;

  /// No description provided for @action_loop.
  ///
  /// In en, this message translates to:
  /// **'Loop'**
  String get action_loop;

  /// No description provided for @action_play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get action_play;

  /// No description provided for @action_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get action_stop;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'af',
    'ar',
    'de',
    'en',
    'es',
    'fr',
    'id',
    'pt',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'af':
      return AppLocalizationsAf();
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'id':
      return AppLocalizationsId();
    case 'pt':
      return AppLocalizationsPt();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
