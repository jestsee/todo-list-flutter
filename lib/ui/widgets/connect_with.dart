import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/provider.dart';

class ConnectWith extends ConsumerWidget {
  const ConnectWith({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: <Widget>[
        const Text('Or connect with:'),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              iconSize: 64,
              icon: Image.asset('assets/google.png'),
            ),
            const SizedBox(width: 18),
            IconButton(
              onPressed: () =>
                  ref.read(authControllerProvider.notifier).signInGithub(),
              iconSize: 64,
              icon: Image.asset('assets/github.png'),
            ),
          ],
        )
      ],
    );
  }
}
