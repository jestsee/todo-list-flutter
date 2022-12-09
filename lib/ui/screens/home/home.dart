import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Home extends HookConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: const Center(
          child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Center(child: Text('Ini home🏠')),
      )),
    );
  }
}
