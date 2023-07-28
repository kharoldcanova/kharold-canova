import 'package:flutter/material.dart';

class ProyectsWidget extends StatelessWidget {
  const ProyectsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      height: 450,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          width: 450,
          child: Wrap(
            children: [
              const Icon(
                Icons.run_circle_outlined,
                size: 150,
              ),
              Text(
                '',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
