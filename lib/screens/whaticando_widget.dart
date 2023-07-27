import 'package:flutter/material.dart';

class WhatICanDoWidget extends StatelessWidget {
  const WhatICanDoWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      height: 750,
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
                  '¿Que es lo que puedo hacer?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).colorScheme.onPrimary),
                ),
              ],
            ),
            const SizedBox(height: 60),
            SizedBox(
              child: Wrap(
                spacing: 1.0,
                runSpacing: 2.0,
                alignment: WrapAlignment.start,
                runAlignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            radius: 80,
                            child: Icon(
                              Icons.web,
                              color: Theme.of(context).colorScheme.primary,
                              size: 100,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            title: Text(
                              'Paginas Web',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            subtitle: Text(
                              'Desarrollo de paginas web.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundColor:
                                Theme.of(context).colorScheme.onPrimary,
                            child: Icon(
                              Icons.phone_android,
                              color: Theme.of(context).colorScheme.primary,
                              size: 100,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ListTile(
                            title: Text(
                              'Aplicaciones moviles',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                            subtitle: Text(
                              'Desarrollo de aplicaciones moviles.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       '¡Con diseños personalizados atractivos e interactivos!',
            //       softWrap: true,
            //       overflow: TextOverflow.clip,
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         fontSize: 18,
            //         color: Theme.of(context).colorScheme.onPrimary,
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
