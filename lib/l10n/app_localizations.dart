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
  /// **'I\'m passionate about creating cross-platform applications, automating processes, and continuing to grow in DevOps. I also enjoy exploring Linux, staying up to date with the latest technologies, and leveraging artificial intelligence to enhance every project.'**
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

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get about;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @contact.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// No description provided for @projects.
  ///
  /// In en, this message translates to:
  /// **'Projects'**
  String get projects;

  /// No description provided for @profile_title.
  ///
  /// In en, this message translates to:
  /// **'Full Stack Developer'**
  String get profile_title;

  /// No description provided for @profile_quote.
  ///
  /// In en, this message translates to:
  /// **'Flutter · Laravel · Applied AI · Automation'**
  String get profile_quote;

  /// No description provided for @profile_since.
  ///
  /// In en, this message translates to:
  /// **'Since'**
  String get profile_since;

  /// No description provided for @profile_expertise.
  ///
  /// In en, this message translates to:
  /// **'Full Stack Development · Applied AI'**
  String get profile_expertise;

  /// Header call-to-action button.
  ///
  /// In en, this message translates to:
  /// **'Contact Me'**
  String get contact_me;

  /// Top hero line summarizing the technical profile.
  ///
  /// In en, this message translates to:
  /// **'PIURA, PERU · AVAILABLE IMMEDIATELY'**
  String get hero_eyebrow;

  /// Hero section subtitle emphasizing Systems, Full-Stack and Applied AI roles.
  ///
  /// In en, this message translates to:
  /// **'Full Stack Developer · Flutter · Applied AI'**
  String get hero_subtitle;

  /// Hero primary action that scrolls to the AI section.
  ///
  /// In en, this message translates to:
  /// **'Explore AI systems'**
  String get hero_explore_ai;

  /// Short navigation label for the AI section.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get nav_ai;

  /// Section title for AI and Agent Systems.
  ///
  /// In en, this message translates to:
  /// **'Artificial Intelligence & Agent Systems'**
  String get ai_systems;

  /// Description for the AI and Agent Systems section.
  ///
  /// In en, this message translates to:
  /// **'I design agents and applied AI systems that solve real problems: RAG over private data, NL2SQL with safeguards, multimodal assistants, and automation.'**
  String get ai_systems_desc;

  /// Label above the AI project grid.
  ///
  /// In en, this message translates to:
  /// **'Featured projects'**
  String get ai_featured;

  /// Button on each AI project card.
  ///
  /// In en, this message translates to:
  /// **'View on GitHub'**
  String get ai_view_repo;

  /// Link to the GitHub profile with all repositories.
  ///
  /// In en, this message translates to:
  /// **'View all repositories'**
  String get ai_view_all_repos;

  /// Empty state for the AI section.
  ///
  /// In en, this message translates to:
  /// **'AI projects are being updated.'**
  String get ai_empty;

  /// Short label for the CV link in the footer.
  ///
  /// In en, this message translates to:
  /// **'CV'**
  String get footer_cv;

  /// Quote section after hero.
  ///
  /// In en, this message translates to:
  /// **'Systems Engineer and Full Stack Developer: Flutter apps with Clean Architecture and BLoC, Laravel APIs and CI/CD, plus applied-AI solutions such as RAG, agents and automations.'**
  String get hero_quote;

  /// About section title.
  ///
  /// In en, this message translates to:
  /// **'About me'**
  String get about_title;

  /// About section description.
  ///
  /// In en, this message translates to:
  /// **'Systems Engineer with 4 years shipping mobile apps and APIs to production. Three years working remotely from Peru for a US company as the sole owner of its Flutter client app: I rebuilt it with Clean Architecture and BLoC and automated its releases with CI/CD. I build applied-AI solutions (RAG, local LLMs, agents, n8n) for real team problems, and I want to grow in mobile development or AI on products with real impact on people.'**
  String get about_desc;

  /// Hire me button.
  ///
  /// In en, this message translates to:
  /// **'Hire Me!'**
  String get hire_me;

  /// About me button.
  ///
  /// In en, this message translates to:
  /// **'About Me'**
  String get about_me;

  /// Services section title.
  ///
  /// In en, this message translates to:
  /// **'My Services'**
  String get services_title;

  /// Service card: Android development with Flutter.
  ///
  /// In en, this message translates to:
  /// **'Android Development with Flutter'**
  String get service_android;

  /// Service card: iOS development with Flutter.
  ///
  /// In en, this message translates to:
  /// **'iOS Development with Flutter'**
  String get service_ios;

  /// Service card: web development with Vue.js.
  ///
  /// In en, this message translates to:
  /// **'Web Development'**
  String get service_web;

  /// Service card: automation and CI/CD pipelines.
  ///
  /// In en, this message translates to:
  /// **'Automation & CI/CD'**
  String get service_rag;

  /// Service card: generative AI integration.
  ///
  /// In en, this message translates to:
  /// **'Generative AI Integration'**
  String get service_scripts;

  /// Service card: Google Apps Script and automation.
  ///
  /// In en, this message translates to:
  /// **'Apps Script & Automation'**
  String get service_contact;

  /// Portfolio section title.
  ///
  /// In en, this message translates to:
  /// **'My Portfolio'**
  String get portfolio_title;

  /// Portfolio section description.
  ///
  /// In en, this message translates to:
  /// **'Discover my latest projects and see how I bring ideas to life.'**
  String get portfolio_desc;

  /// Filter option: all projects.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get filter_all;

  /// Filter option: web development.
  ///
  /// In en, this message translates to:
  /// **'Web Development'**
  String get filter_web_dev;

  /// Filter option: VUE.
  ///
  /// In en, this message translates to:
  /// **'VUE'**
  String get filter_vue;

  /// Filter option: UI/UX.
  ///
  /// In en, this message translates to:
  /// **'UI/UX'**
  String get filter_uiux;

  /// Filter option: web design.
  ///
  /// In en, this message translates to:
  /// **'Web Design'**
  String get filter_web_design;

  /// View all projects button.
  ///
  /// In en, this message translates to:
  /// **'View All'**
  String get view_all;

  /// Show less projects button.
  ///
  /// In en, this message translates to:
  /// **'Show Less'**
  String get show_less;

  /// Experience stat with placeholder for years.
  ///
  /// In en, this message translates to:
  /// **'+{years} years of experience'**
  String stats_exp(Object years);

  /// Repositories stat with placeholder for count.
  ///
  /// In en, this message translates to:
  /// **'+{count} GitHub Repositories'**
  String stats_repos(Object count);

  /// Title for the stats/metrics section.
  ///
  /// In en, this message translates to:
  /// **'Impact & Track Record'**
  String get key_metrics_title;

  /// Title for the certifications section.
  ///
  /// In en, this message translates to:
  /// **'Technical Certifications'**
  String get certifications_title;

  /// Subtitle for the certifications section.
  ///
  /// In en, this message translates to:
  /// **'Continuous learning and professional development'**
  String get certifications_subtitle;

  /// Navigation label for the certifications section.
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get certifications;

  /// Heading for the knowledge and capabilities block.
  ///
  /// In en, this message translates to:
  /// **'Knowledge'**
  String get knowledge;

  /// Description for the knowledge block.
  ///
  /// In en, this message translates to:
  /// **'Tools and practices I use to build, ship, and operate software.'**
  String get knowledge_desc;

  /// Tooltip for the control that enables dark mode.
  ///
  /// In en, this message translates to:
  /// **'Switch to dark mode'**
  String get theme_dark;

  /// Tooltip for the control that enables light mode.
  ///
  /// In en, this message translates to:
  /// **'Switch to light mode'**
  String get theme_light;

  /// Tooltip for the language toggle.
  ///
  /// In en, this message translates to:
  /// **'Change language'**
  String get change_language;

  /// Medium profile link label.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Eyebrow label for the featured published skill.
  ///
  /// In en, this message translates to:
  /// **'Published skill'**
  String get published_skill;

  /// Link label for the featured published skill.
  ///
  /// In en, this message translates to:
  /// **'View skill'**
  String get view_skill;

  /// Label before the skill install command.
  ///
  /// In en, this message translates to:
  /// **'Install'**
  String get install_command;

  /// Certifications stat with placeholder for the count.
  ///
  /// In en, this message translates to:
  /// **'+{count} certifications'**
  String stats_certs(Object count);

  /// Footer copyright suffix.
  ///
  /// In en, this message translates to:
  /// **'All rights reserved.'**
  String get footer_rights;

  /// Description inside the contact block.
  ///
  /// In en, this message translates to:
  /// **'Tell me about your project or just say hello.'**
  String get contact_desc;

  /// Stats panel label.
  ///
  /// In en, this message translates to:
  /// **'Years of experience'**
  String get years_experience;

  /// Stats panel label.
  ///
  /// In en, this message translates to:
  /// **'GitHub repositories'**
  String get github_repos;

  /// Stats panel eyebrow.
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get impact;

  /// Heading for the professional experience timeline.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get experience;

  /// Description for the professional experience timeline.
  ///
  /// In en, this message translates to:
  /// **'A track record of shipping apps to production, automating processes and applying AI to real problems.'**
  String get experience_desc;

  /// Label for an ongoing role in the experience timeline.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// Heading for the grouped technical stack.
  ///
  /// In en, this message translates to:
  /// **'Technical stack'**
  String get tech_stack;

  /// Description for the grouped technical stack.
  ///
  /// In en, this message translates to:
  /// **'Technologies I use to build, ship, and operate software.'**
  String get tech_stack_desc;

  /// Technical stack group for AI and MCP.
  ///
  /// In en, this message translates to:
  /// **'Applied AI and automation'**
  String get skill_group_ai;

  /// Technical stack group for DevOps and cloud.
  ///
  /// In en, this message translates to:
  /// **'DevOps and CI/CD'**
  String get skill_group_devops;

  /// Technical stack group for frontend and mobile.
  ///
  /// In en, this message translates to:
  /// **'Web frontend'**
  String get skill_group_frontend;

  /// Technical stack group for backend and data.
  ///
  /// In en, this message translates to:
  /// **'Backend and APIs'**
  String get skill_group_backend;

  /// No description provided for @terminal_open.
  ///
  /// In en, this message translates to:
  /// **'Open terminal'**
  String get terminal_open;

  /// No description provided for @terminal_close.
  ///
  /// In en, this message translates to:
  /// **'Close terminal'**
  String get terminal_close;

  /// No description provided for @hero_view_projects.
  ///
  /// In en, this message translates to:
  /// **'See projects'**
  String get hero_view_projects;

  /// No description provided for @core_competencies.
  ///
  /// In en, this message translates to:
  /// **'Core competencies'**
  String get core_competencies;

  /// No description provided for @skill_group_mobile.
  ///
  /// In en, this message translates to:
  /// **'Mobile development (Flutter)'**
  String get skill_group_mobile;

  /// No description provided for @stat_years_value.
  ///
  /// In en, this message translates to:
  /// **'4'**
  String get stat_years_value;

  /// No description provided for @stat_years_label.
  ///
  /// In en, this message translates to:
  /// **'years building apps and APIs'**
  String get stat_years_label;

  /// No description provided for @stat_users_value.
  ///
  /// In en, this message translates to:
  /// **'~115'**
  String get stat_users_value;

  /// No description provided for @stat_users_label.
  ///
  /// In en, this message translates to:
  /// **'people use mm2'**
  String get stat_users_label;

  /// No description provided for @stat_remote_value.
  ///
  /// In en, this message translates to:
  /// **'3'**
  String get stat_remote_value;

  /// No description provided for @stat_remote_label.
  ///
  /// In en, this message translates to:
  /// **'years remote with a US team'**
  String get stat_remote_label;

  /// No description provided for @projects_cv_note.
  ///
  /// In en, this message translates to:
  /// **'All are personal projects built with AI-assisted development, from architecture design to integration and testing.'**
  String get projects_cv_note;

  /// No description provided for @view_site.
  ///
  /// In en, this message translates to:
  /// **'Visit site'**
  String get view_site;

  /// No description provided for @nav_experience.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get nav_experience;

  /// No description provided for @nav_education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get nav_education;

  /// No description provided for @education_title.
  ///
  /// In en, this message translates to:
  /// **'Education and certifications'**
  String get education_title;

  /// No description provided for @education.
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// No description provided for @education_school.
  ///
  /// In en, this message translates to:
  /// **'Universidad César Vallejo'**
  String get education_school;

  /// No description provided for @education_degree.
  ///
  /// In en, this message translates to:
  /// **'Systems Engineering degree (Professional Title)'**
  String get education_degree;

  /// No description provided for @education_period.
  ///
  /// In en, this message translates to:
  /// **'Peru · 2018 — 2023'**
  String get education_period;

  /// No description provided for @cert_group_genai.
  ///
  /// In en, this message translates to:
  /// **'Generative AI'**
  String get cert_group_genai;

  /// No description provided for @cert_group_ai.
  ///
  /// In en, this message translates to:
  /// **'AI and automation'**
  String get cert_group_ai;

  /// No description provided for @cert_group_dev.
  ///
  /// In en, this message translates to:
  /// **'Development'**
  String get cert_group_dev;

  /// No description provided for @cert_group_infra.
  ///
  /// In en, this message translates to:
  /// **'Infrastructure'**
  String get cert_group_infra;

  /// No description provided for @availability.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get availability;

  /// No description provided for @availability_desc.
  ///
  /// In en, this message translates to:
  /// **'Available to start immediately · Full time · Remote from Piura, Peru, with three years of experience working remotely with a US team.'**
  String get availability_desc;

  /// No description provided for @languages.
  ///
  /// In en, this message translates to:
  /// **'Languages'**
  String get languages;

  /// No description provided for @languages_desc.
  ///
  /// In en, this message translates to:
  /// **'Spanish (native) · English (B1 intermediate, EF SET): technical reading and written communication with US teams.'**
  String get languages_desc;

  /// No description provided for @hero_greeting.
  ///
  /// In en, this message translates to:
  /// **'Hi, I\'m'**
  String get hero_greeting;

  /// No description provided for @availability_now.
  ///
  /// In en, this message translates to:
  /// **'Available now'**
  String get availability_now;

  /// No description provided for @hero_role_lead.
  ///
  /// In en, this message translates to:
  /// **'Full stack developer, between'**
  String get hero_role_lead;

  /// No description provided for @hero_role_and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get hero_role_and;

  /// No description provided for @hero_role_ai.
  ///
  /// In en, this message translates to:
  /// **'AI'**
  String get hero_role_ai;

  /// No description provided for @hero_value.
  ///
  /// In en, this message translates to:
  /// **'For four years I\'ve been building apps and APIs that people use every day. I also like seeing how far an AI can go when it runs on your own device, without the cloud.'**
  String get hero_value;

  /// No description provided for @nn_title.
  ///
  /// In en, this message translates to:
  /// **'The networks behind my projects'**
  String get nn_title;

  /// No description provided for @nn_hint.
  ///
  /// In en, this message translates to:
  /// **'interactive'**
  String get nn_hint;

  /// No description provided for @nn_vision.
  ///
  /// In en, this message translates to:
  /// **'Vision'**
  String get nn_vision;

  /// No description provided for @nn_voice.
  ///
  /// In en, this message translates to:
  /// **'Voice'**
  String get nn_voice;

  /// No description provided for @nn_sql.
  ///
  /// In en, this message translates to:
  /// **'Text → SQL'**
  String get nn_sql;

  /// No description provided for @nn_semantics.
  ///
  /// In en, this message translates to:
  /// **'Three animated neural networks: vision, voice and text to SQL. They light up when you hover or tap them.'**
  String get nn_semantics;

  /// No description provided for @about_p1.
  ///
  /// In en, this message translates to:
  /// **'I\'m a systems engineer and I\'ve spent four years building mobile apps and APIs. For the last three I worked remotely from Piura for a US law firm, where I owned their client app: first I maintained it, then I rebuilt it from scratch with Clean Architecture and BLoC, and automated its releases to the app stores.'**
  String get about_p1;

  /// No description provided for @about_p2.
  ///
  /// In en, this message translates to:
  /// **'I also build things with AI: an assistant that sees and talks inside a phone with no internet, a RAG that turns questions into SQL, and automations with n8n. What drives me most is making products that make someone\'s day easier.'**
  String get about_p2;

  /// No description provided for @photo_alt.
  ///
  /// In en, this message translates to:
  /// **'Photo of Kharold Canova'**
  String get photo_alt;

  /// No description provided for @stat_stores_value.
  ///
  /// In en, this message translates to:
  /// **'2'**
  String get stat_stores_value;

  /// No description provided for @stat_stores_label.
  ///
  /// In en, this message translates to:
  /// **'app stores it ships to'**
  String get stat_stores_label;

  /// No description provided for @skills_title.
  ///
  /// In en, this message translates to:
  /// **'What I work with'**
  String get skills_title;

  /// No description provided for @projects_desc.
  ///
  /// In en, this message translates to:
  /// **'My own projects. I built most of them with help from coding agents.'**
  String get projects_desc;

  /// No description provided for @contact_title.
  ///
  /// In en, this message translates to:
  /// **'Let\'s talk'**
  String get contact_title;

  /// No description provided for @contact_text.
  ///
  /// In en, this message translates to:
  /// **'I\'m looking for my next job in mobile development or AI. If you have something in mind, or just want to talk about Flutter or local models, write to me.'**
  String get contact_text;

  /// No description provided for @contact_meta.
  ///
  /// In en, this message translates to:
  /// **'Piura, Peru (UTC−5) · remote or hybrid in Lima · Spanish and English (B1)'**
  String get contact_meta;

  /// No description provided for @copy_email.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy_email;

  /// No description provided for @email_copied.
  ///
  /// In en, this message translates to:
  /// **'Email copied'**
  String get email_copied;

  /// No description provided for @footer_made_with.
  ///
  /// In en, this message translates to:
  /// **'Made with Flutter Web'**
  String get footer_made_with;
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
