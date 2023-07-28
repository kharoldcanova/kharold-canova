import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProyectsWidget extends StatefulWidget {
  const ProyectsWidget({
    super.key,
  });

  @override
  State<ProyectsWidget> createState() => _ProyectsWidgetState();
}

class _ProyectsWidgetState extends State<ProyectsWidget> {
  //go to url
  Future<void> goToUrl(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Algunos de mis proyectos son:',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            ),
            const SizedBox(height: 60),
            SizedBox(
              child: Wrap(
                spacing: 5.0,
                runSpacing: 2.0,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _CustomItemProyect(
                    icon: Icons.login,
                    title: 'Login con Flutter',
                    subtitle:
                        'Realizacion de una interfaz atractiva de un diseño creado en Figma con funcionalidad de autenticacion usando los servicios de Firebase.',
                    function: () {
                      setState(() {
                        goToUrl(
                            'https://github.com/kharoldcanova/login_flutter');
                      });
                    },
                  ),
                  _CustomItemProyect(
                    icon: Icons.chat,
                    title: 'Chatbot',
                    subtitle:
                        'Un chatbot que consume una API de respuestas basadas en una imagen de Yes o No usando la libreria de Dio.',
                    function: () {
                      setState(() {
                        goToUrl('https://github.com/kharoldcanova/yes_no_app');
                      });
                    },
                  ),
                  _CustomItemProyect(
                    icon: Icons.video_call,
                    title: 'Tok Tik',
                    subtitle:
                        'Un duplicado basico de la aplicacion de Tik Tok usando librerias para reproduccion de videos.',
                    function: () {
                      setState(() {
                        goToUrl(
                            'https://github.com/kharoldcanova/toktik_app_flutter');
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}

class _CustomItemProyect extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback function;
  const _CustomItemProyect({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 25),
      child: SizedBox(
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80,
              backgroundColor: Theme.of(context).colorScheme.onSecondary,
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.secondary,
                size: 100,
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              title: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              subtitle: Text(
                subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: function,
              style: FilledButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                foregroundColor: Theme.of(context).colorScheme.secondary,
                minimumSize: const Size(180, 50),
              ),
              child: const Text('Ir al proyecto'),
            ),
          ],
        ),
      ),
    );
  }
}
