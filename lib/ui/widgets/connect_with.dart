import 'package:flutter/material.dart';

class ConnectWith extends StatelessWidget {
  const ConnectWith({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Text('Or connect with:'),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // TODO clickable
            Image.asset(
              'assets/google.png',
              height: 64,
            ),
            const SizedBox(width: 18),
            Image.asset(
              'assets/github.png',
              height: 64,
            ),
          ],
        )
      ],
    );
  }
}
