// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get hello => 'Hola';

  @override
  String greetUser(Object username) {
    return 'Bienvenido, $username!';
  }

  @override
  String get profile_description =>
      'Desarrollador de Flutter con casi 5 años de experiencia, me encanta hacer aplicaciones con estilos personalizados ademas de innovadores, si quieres conocer mas de mi trabajo, puedes consultar mi repositorio de Git y checar algunas de mis pasiones en Linkedin.';

  @override
  String get download_cv => 'Descargar CV';

  @override
  String get what_i_can_do_title => '¿Que es lo que puedo hacer?';

  @override
  String get web_pages => 'Páginas web';

  @override
  String get web_pages_description =>
      'Desarrollo de páginas web responsivas y modernas utilizando Flutter, HTML, CSS y JavaScript para garantizar una experiencia de usuario óptima en todos los dispositivos.';

  @override
  String get mobile_apps => 'Aplicaciones móviles';

  @override
  String get mobile_apps_description =>
      'Creación de aplicaciones móviles nativas y multiplataforma con Flutter para Android y iOS, enfocándome en el rendimiento, la usabilidad y el diseño atractivo para ofrecer experiencias excepcionales a los usuarios.';

  @override
  String get database_management => 'Gestión de bases de datos';

  @override
  String get database_management_description =>
      'Documentacion y administración de bases de datos utilizando MySQL para asegurar la integridad, seguridad y eficiencia en el manejo de datos en aplicaciones móviles y web.';

  @override
  String get automatizaacion_gitactions => 'Automatización con Git Actions';

  @override
  String get automatizaacion_gitactions_description =>
      'Implementación de flujos de trabajo automatizados utilizando GitHub Actions para optimizar procesos de desarrollo, integración continua y despliegue continuo (CI/CD) en proyectos de software.';

  @override
  String get proyects_title => 'Algunos de mis proyectos son: ';

  @override
  String get go_to_project => 'Ir al proyecto';

  @override
  String get login_flutter => 'Login con Flutter';

  @override
  String get login_flutter_description =>
      'Aplicación de inicio de sesión desarrollada con Flutter con diseño atractivo que permite autenticarse con Firebase.';

  @override
  String get chatbot => 'Chatbot';

  @override
  String get chatbot_description =>
      'Aplicación de chatbot que consume una API de respuestas con una imagen de Yes/No para interactuar con el usuario.';

  @override
  String get tok_tik_clone => 'Clon de TikTok';

  @override
  String get tok_tik_clone_description =>
      'Clon de la popular aplicación TikTok, desarrollado con Flutter, que permite a los usuarios ver videos cortos con una interfaz similar a la original.';

  @override
  String get work_with_me => '¿Te gustaría trabajar conmigo?';

  @override
  String get send_me_an_email => 'Envíame un correo';

  @override
  String get phones => 'Teléfonos';

  @override
  String get email => 'Correo electrónico';
}
