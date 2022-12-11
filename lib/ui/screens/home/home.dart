import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_list/controllers/auth_controller.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            const Text('Ini home🏠'),
            ref.read(authControllerProvider) != null
                ? ElevatedButton(
                    onPressed: () {
                      ref.read(authControllerProvider.notifier).signOut();
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text('Sign out'))
                : const Text('Belum sign in')
          ],
        ),
      )),
    );
  }
}
