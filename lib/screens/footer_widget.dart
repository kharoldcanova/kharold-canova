import 'package:flutter/material.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          color: Theme.of(context).colorScheme.secondary,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '¿Te gustaria trabajar conmigo?',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 20),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: FilledButton(
                      onPressed: () {}, child: const Text('Enviame un correo')),
                )
              ],
            ),
          ),
        ),
        Container(
          color: Theme.of(context).colorScheme.background,
          child: const Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Telefonos:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '+51 963 572 573',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      '+51 942 174 671',
                      style: TextStyle(fontSize: 14),
                    )
                  ],
                ),
                SizedBox(width: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Correo electronico:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
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
