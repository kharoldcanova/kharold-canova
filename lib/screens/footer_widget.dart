import 'package:flutter/material.dart';
import 'package:kharoldcanova/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatefulWidget {
  const FooterWidget({super.key});

  @override
  State<FooterWidget> createState() => _FooterWidgetState();
}

class _FooterWidgetState extends State<FooterWidget> {
//send email
  Future<void> sendEmail() async {
    const toEmail = 'kharoldcanova@gmail.com';
    const subject = 'Contacto';
    const message = 'Hola Kharold: \n\nVi tu portafolio, ¿Podemos hablar?';

    final url =
        'mailto:$toEmail?subject=${Uri.encodeFull(subject)}&body=${Uri.encodeFull(message)}';
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('No se pudo abrir $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final translations = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Theme.of(context).colorScheme.secondary,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  translations.work_with_me,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 20),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: FilledButton(
                    onPressed: () {
                      setState(() {
                        sendEmail();
                      });
                    },
                    child: Text(translations.send_me_an_email),
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.surface,
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Wrap(
              spacing: 50,
              runSpacing: 30,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${translations.phones} :",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      '+51 962 268 628',
                      style: TextStyle(fontSize: 14),
                    ),
                    const Text(
                      '+51 942 174 671',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                //SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${translations.email} :",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'kharoldcanova@gmail.com',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
