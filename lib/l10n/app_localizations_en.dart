// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get hello => 'Hello';

  @override
  String greetUser(Object username) {
    return 'Welcome, $username!';
  }

  @override
  String get profile_description =>
      'Flutter developer with almost 5 years of experience. I love making applications with custom and innovative styles. If you want to know more about my work, you can check out my Git repository and see some of my passions on LinkedIn.';

  @override
  String get download_cv => 'Download CV';

  @override
  String get what_i_can_do_title => 'What can I do?';

  @override
  String get web_pages => 'Web pages';

  @override
  String get web_pages_description =>
      'Development of responsive and modern web pages using Flutter, HTML, CSS, and JavaScript to ensure an optimal user experience on all devices.';

  @override
  String get mobile_apps => 'Mobile applications';

  @override
  String get mobile_apps_description =>
      'Creation of native and cross-platform mobile applications with Flutter for Android and iOS, focusing on performance, usability, and attractive design to deliver exceptional user experiences.';

  @override
  String get database_management => 'Database management';

  @override
  String get database_management_description =>
      'Documentation and administration of databases using MySQL to ensure integrity, security, and efficiency in data management for mobile and web applications.';

  @override
  String get automatizaacion_gitactions => 'Automation with Git Actions';

  @override
  String get automatizaacion_gitactions_description =>
      'Implementation of automated workflows using GitHub Actions to optimize development processes, continuous integration, and continuous deployment (CI/CD) in software projects.';

  @override
  String get proyects_title => 'Some of my projects are:';

  @override
  String get go_to_project => 'Go to project';

  @override
  String get login_flutter => 'Login with Flutter';

  @override
  String get login_flutter_description =>
      'Login application developed with Flutter with an attractive design that allows authentication with Firebase.';

  @override
  String get chatbot => 'Chatbot';

  @override
  String get chatbot_description =>
      'Chatbot application that consumes a response API with a Yes/No image to interact with the user.';

  @override
  String get tok_tik_clone => 'TikTok clone';

  @override
  String get tok_tik_clone_description =>
      'Clone of the popular TikTok application, developed with Flutter, which allows users to watch short videos with an interface similar to the original.';

  @override
  String get work_with_me => 'Would you like to work with me?';

  @override
  String get send_me_an_email => 'Send me an email';

  @override
  String get phones => 'Phones';

  @override
  String get email => 'Email';
}
