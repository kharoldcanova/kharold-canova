import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({
    super.key,
  });

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  //go to url
  Future<void> goToUrl(url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('No se pudo abrir $url');
    }
  }

  //open cv pdf
  Future<void> openPDF() async {
    const pdfPath = 'assets/cv-flutter.pdf';
    if (!await launchUrl(
      Uri.parse(pdfPath),
      mode: LaunchMode.platformDefault,
    )) {
      throw Exception('No se pudo abrir el PDF');
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: 850,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'font-banner-3.jpg',
                    fit: BoxFit.fill,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        alignment: WrapAlignment.spaceBetween,
                        children: [
                          Text(
                            'KHAROLD CANOVA',
                            style: TextStyle(
                                fontSize: 80,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.secondary),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 500,
                                color: Theme.of(context).colorScheme.background,
                                child: const Text(
                                  'Desarrollador de Flutter con dos años de experiencia, me encanta hacer aplicaciones con estilos personalizados ademas de innovadores, si quieres conocer mas de mi trabajo, puedes consultar mi repositorio de Git y checar algunas de mis pasiones en Linkedin. ',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  minimumSize: const Size(250, 60),
                                ),
                                onPressed: () {
                                  setState(() {
                                    openPDF();
                                  });
                                },
                                child: const Text('Descargar CV'),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        spacing: 10,
                        runSpacing: 10,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              minimumSize: const Size(250, 60),
                            ),
                            onPressed: () {
                              setState(() {
                                goToUrl(
                                    'https://www.linkedin.com/in/kharoldcanova/');
                              });
                            },
                            child: const Text('Linkedin'),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              elevation: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              minimumSize: const Size(250, 60),
                            ),
                            onPressed: () {
                              setState(() {
                                goToUrl('https://github.com/kharoldcanova');
                              });
                            },
                            child: const Text('GitHub'),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
