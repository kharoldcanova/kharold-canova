import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

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
    Locale('es')
  ];

  /// Saludo en inglés.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// Saludo personalizado para el usuario.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {username}!'**
  String greetUser(Object username);

  /// Descripción del perfil del usuario en inglés.
  ///
  /// In en, this message translates to:
  /// **'Flutter developer with almost 5 years of experience. I love making applications with custom and innovative styles. If you want to know more about my work, you can check out my Git repository and see some of my passions on LinkedIn.'**
  String get profile_description;

  /// Texto para el botón de descarga del CV en inglés.
  ///
  /// In en, this message translates to:
  /// **'Download CV'**
  String get download_cv;

  /// Título de la sección de habilidades en inglés.
  ///
  /// In en, this message translates to:
  /// **'What can I do?'**
  String get what_i_can_do_title;

  /// Texto para la sección de páginas web en inglés.
  ///
  /// In en, this message translates to:
  /// **'Web pages'**
  String get web_pages;

  /// Descripción de la sección de páginas web en inglés.
  ///
  /// In en, this message translates to:
  /// **'Development of responsive and modern web pages using Flutter, HTML, CSS, and JavaScript to ensure an optimal user experience on all devices.'**
  String get web_pages_description;

  /// Título de la sección de aplicaciones móviles en inglés.
  ///
  /// In en, this message translates to:
  /// **'Mobile applications'**
  String get mobile_apps;

  /// Descripción de la sección de aplicaciones móviles en inglés.
  ///
  /// In en, this message translates to:
  /// **'Creation of native and cross-platform mobile applications with Flutter for Android and iOS, focusing on performance, usability, and attractive design to deliver exceptional user experiences.'**
  String get mobile_apps_description;

  /// Título de la sección de gestión de bases de datos en inglés.
  ///
  /// In en, this message translates to:
  /// **'Database management'**
  String get database_management;

  /// Descripción de la sección de gestión de bases de datos en inglés.
  ///
  /// In en, this message translates to:
  /// **'Documentation and administration of databases using MySQL to ensure integrity, security, and efficiency in data management for mobile and web applications.'**
  String get database_management_description;

  /// Título de la sección de automatización con GitHub Actions en inglés.
  ///
  /// In en, this message translates to:
  /// **'Automation with Git Actions'**
  String get automatizaacion_gitactions;

  /// Descripción de la sección de automatización con GitHub Actions en inglés.
  ///
  /// In en, this message translates to:
  /// **'Implementation of automated workflows using GitHub Actions to optimize development processes, continuous integration, and continuous deployment (CI/CD) in software projects.'**
  String get automatizaacion_gitactions_description;

  /// Título de la sección de proyectos en inglés.
  ///
  /// In en, this message translates to:
  /// **'Some of my projects are:'**
  String get proyects_title;

  /// Texto del botón para ver el proyecto.
  ///
  /// In en, this message translates to:
  /// **'Go to project'**
  String get go_to_project;

  /// Título de la sección de Login con Flutter en inglés.
  ///
  /// In en, this message translates to:
  /// **'Login with Flutter'**
  String get login_flutter;

  /// Descripción del proyecto de Login con Flutter en inglés.
  ///
  /// In en, this message translates to:
  /// **'Login application developed with Flutter with an attractive design that allows authentication with Firebase.'**
  String get login_flutter_description;

  /// Título de la sección de Chatbot en inglés.
  ///
  /// In en, this message translates to:
  /// **'Chatbot'**
  String get chatbot;

  /// Descripción del proyecto de Chatbot en inglés.
  ///
  /// In en, this message translates to:
  /// **'Chatbot application that consumes a response API with a Yes/No image to interact with the user.'**
  String get chatbot_description;

  /// Título del proyecto de clon de TikTok en inglés.
  ///
  /// In en, this message translates to:
  /// **'TikTok clone'**
  String get tok_tik_clone;

  /// Descripción del proyecto de clon de TikTok en inglés.
  ///
  /// In en, this message translates to:
  /// **'Clone of the popular TikTok application, developed with Flutter, which allows users to watch short videos with an interface similar to the original.'**
  String get tok_tik_clone_description;

  /// Texto para la sección de contacto en inglés.
  ///
  /// In en, this message translates to:
  /// **'Would you like to work with me?'**
  String get work_with_me;

  /// Texto del botón para enviar correo electrónico.
  ///
  /// In en, this message translates to:
  /// **'Send me an email'**
  String get send_me_an_email;

  /// Título de la sección de teléfonos en inglés.
  ///
  /// In en, this message translates to:
  /// **'Phones'**
  String get phones;

  /// Título de la sección de correo electrónico en inglés.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;
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
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
