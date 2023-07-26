import 'package:flutter/material.dart';
import 'package:kharoldcanova/config/theme/current_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        foregroundColor: theme.colorScheme.onBackground,
        title: const Text('KHAROLD'),
        toolbarHeight: 100,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const BannerWidget(),
            const PresentationWidget(),
            Container(
              color: Colors.blueAccent[700],
              height: 450,
            )
          ],
        ),
      ),
    );
  }
}

class BannerWidget extends StatelessWidget {
  const BannerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: 650,
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Container(
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
                          Container(
                            width: 500,
                            color: Theme.of(context).colorScheme.background,
                            child: const Text(
                                'Desarrollador de Flutter con dos años de experiencia, me encanta hacer aplicaciones con estilos personalizados ademas de innovadores, si quieres conocer mas de mi trabajo, puedes consultar mi repositorio de Git y checar algunas de mis pasiones en Linkedin. '),
                          )
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
                            onPressed: () {},
                            child: const Text('Linkdin'),
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
                            onPressed: () {},
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

class PresentationWidget extends StatelessWidget {
  const PresentationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: 650,
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Kharold Canova',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          SizedBox(height: 10),
          Text(
            'Desarrollador Flutter Frontend',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
